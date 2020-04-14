//
//  YQRoomPushViewController.m
//  DouYuZhiBo_OC
//
//  Created by 夜无眠 on 2020/2/18.
//  Copyright © 2020 杨乾. All rights reserved.
//

#import "YQRoomPushViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface YQRoomPushViewController ()<UIGestureRecognizerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate, AVCaptureFileOutputRecordingDelegate>

@property(nonatomic, strong) AVCaptureSession * session;
@property(nonatomic, strong) AVCaptureDeviceInput * videoDeviceInput;
@property(nonatomic, strong) AVCaptureVideoDataOutput * videoOutput;
@property(nonatomic, strong) AVCaptureVideoPreviewLayer * previewLayer;
@property(nonatomic, strong) dispatch_queue_t videoGlobleQueue;
@property(nonatomic, strong) dispatch_queue_t audioGlobleQueue;

@property(nonatomic, strong) AVCaptureMovieFileOutput *movieOutput;

@end

@implementation YQRoomPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.center = CGPointMake(100, 100);
        
        [btn setTitle:@"开始采集" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        [btn sizeToFit];
        [btn addTarget:self action:@selector(startCapture) forControlEvents:UIControlEventTouchUpInside];
        btn;
    })];
    
    [self.view addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.center = CGPointMake(300, 100);
        
        [btn setTitle:@"结束采集" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        [btn sizeToFit];
        [btn addTarget:self action:@selector(stopCapture) forControlEvents:UIControlEventTouchUpInside];
        btn;
    })];
    
    [self.view addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.center = CGPointMake(200, 300);
        
        [btn setTitle:@"切换镜头" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        [btn sizeToFit];
        [btn addTarget:self action:@selector(switchScene) forControlEvents:UIControlEventTouchUpInside];
        btn;
    })];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    // 隐藏导航栏后 导致左滑手势返回的功能失效了, 为使其重新有效
    // 添加了全局的 pop 手势后, 这个就不需要了...
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


#pragma mark ----------------------------------------------------------------------------------
#pragma mark -- 视频采集
- (dispatch_queue_t)videoGlobleQueue {
    if (!_videoGlobleQueue) {
        _videoGlobleQueue = dispatch_get_global_queue(0, 0);
    }
    return _videoGlobleQueue;
}

- (dispatch_queue_t)audioGlobleQueue {
    if (!_audioGlobleQueue) {
        _audioGlobleQueue = dispatch_get_global_queue(0, 0);
    }
    return _audioGlobleQueue;
}
- (void)startCapture {
    
    // 1. 创建捕捉会话
    AVCaptureSession * session = [[AVCaptureSession alloc] init];
    self.session = session;
     
    // 设置 视频的输入&输出
    [self setupVideo];
    
    // 设置 音频的输入&输出
    [self setupAudio];
    
    // 添加写入文件的 output
    AVCaptureMovieFileOutput *movieOutput = [[AVCaptureMovieFileOutput alloc] init];
    // 设置写入文件的稳定性
    AVCaptureConnection * connection = [movieOutput connectionWithMediaType:AVMediaTypeVideo];
    connection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeAuto;
    
    self.movieOutput = movieOutput;
    
    // 4. 给用户看到一个预览图层(可选)
    AVCaptureVideoPreviewLayer * previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    previewLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view.layer insertSublayer:previewLayer atIndex:0];
    self.previewLayer = previewLayer;
    
    // 5. 开始采集
    [session startRunning];
    
    // 6. 将采集到的画面写入到文件中
    NSString *pathStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    pathStr = [pathStr stringByAppendingPathComponent:@"abc.mp4"];
    
    [movieOutput startRecordingToOutputFileURL:[NSURL fileURLWithPath:pathStr] recordingDelegate:self];
}

- (void)stopCapture {
    // 停止写入文件
    [self.movieOutput stopRecording];
    // 停止采集
    [self.session stopRunning];
    [self.previewLayer removeFromSuperlayer];
}

// 设置 视频的输入&输出
- (void)setupVideo {
    // 2. 给捕捉会话设置输入源 (以摄像头作为输入源)
        // 2.1 获取摄像头设备
    //    AVCaptureDevice * captureDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInDuoCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionFront];
        
        NSArray<AVCaptureDevice *> *devicesArr = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        
        AVCaptureDevice * captureDevice = nil;
        for (AVCaptureDevice  * device in devicesArr) {
            if (device.position == AVCaptureDevicePositionFront) {
                captureDevice = device;
            }
        }
        
        // 2.2 通过device 创建 AVCaptureInput 对象
        NSError * error = nil;
        AVCaptureDeviceInput * captureInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
        self.videoDeviceInput = captureInput;
        YQLog(@"error = %@", error);
        
        // 2.3 将 input 添加到会话中
        [self.session addInput:captureInput];
        
        // 3. 给捕捉会话设置输出源
        AVCaptureVideoDataOutput * output = [[AVCaptureVideoDataOutput alloc] init];
        [output setSampleBufferDelegate:self queue:self.videoGlobleQueue];
        [self.session addOutput:output];
    
        self.videoOutput = output;
}

// 设置 音频的输入&输出
- (void)setupAudio {
    // 获取话筒设备
    AVCaptureDevice * audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    
    // 根据device创建AVCaptureInput
    AVCaptureDeviceInput * audioDeviceInput = [AVCaptureDeviceInput  deviceInputWithDevice:audioDevice error:nil];
    
    // 将input 添加到会话中
    [self.session addInput:audioDeviceInput];
    
    // 3. 给捕捉会话设置音频的输出源
    AVCaptureAudioDataOutput * output = [[AVCaptureAudioDataOutput alloc] init];
    [output setSampleBufferDelegate:self queue:self.audioGlobleQueue];
    [self.session addOutput:output];
    
}

// 切换镜头
- (void)switchScene {
    // 1. 获取之前的镜头
    AVCaptureDevicePosition position = self.videoDeviceInput.device.position;
    
    // 2. 获取当前应该显示的镜头
    position = position == AVCaptureDevicePositionFront ? AVCaptureDevicePositionBack : AVCaptureDevicePositionFront;
    
    // 3. 根据当前的镜头创建新的 Device
    NSArray<AVCaptureDevice *> *devicesArr = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDevice * captureDevice = nil;
    for (AVCaptureDevice  * device in devicesArr) {
        if (device.position == position) {
            captureDevice = device;
        }
    }
    
    // 4. 根据新的 Device 创建新的 Input
    NSError * error = nil;
    AVCaptureDeviceInput * captureInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    YQLog(@"error = %@", error);
    
    // 5. 在 Session 中切换 Input
    [self.session beginConfiguration];
    [self.session removeInput:self.videoDeviceInput];
    [self.session addInput:captureInput];
    [self.session commitConfiguration];
    self.videoDeviceInput = captureInput;
}

#pragma mark --AVCaptureVideoDataOutputSampleBufferDelegate && AVCaptureAudioDataOutputSampleBufferDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    if (connection == [self.videoOutput connectionWithMediaType:AVMediaTypeVideo]) {  // 采集到的是视频数据
        YQLog(@"采集到的是视频数据");
    } else { // 采集到的是音频数据
        YQLog(@"采集到的是音频数据");
    }
}

- (void)captureOutput:(AVCaptureFileOutput *)output didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections {
    YQLog(@"开始写入文件");
}

- (void)captureOutput:(AVCaptureFileOutput *)output didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections error:(nullable NSError *)error {
    YQLog(@"结束写入文件");
}

@end
