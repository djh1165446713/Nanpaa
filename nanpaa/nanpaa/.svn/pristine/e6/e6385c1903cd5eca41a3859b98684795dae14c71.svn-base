//
//  UserPaiSheController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/8.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "UserPaiSheController.h"
#import "CDPVideoRecord.h"//引入.h文件
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>
#import <AVFoundation/AVFoundation.h>
#import "MessageController.h"
#import "ASProgressPopUpView.h"
#import "MyindexAvController.h"
#import "SaveMyVideoController.h"

#define SWIDTH   [UIScreen mainScreen].bounds.size.width
#define SHEIGHT  [UIScreen mainScreen].bounds.size.height
@interface UserPaiSheController ()<MBProgressHUDDelegate,ASProgressPopUpViewDataSource>
{
    
    CDPVideoRecord *_videoRecord;
    
    UIImageView *_recordBt;//录制开关
    UIButton *_beautifyBt;//美颜开关
    UIButton *_cameraSwitchBt;//摄像头切换
    UIButton *_backBtn;
    UIButton *_sgdButton;
    AVCaptureSession * _AVSession;//调用闪光灯的时候创建的类
    BOOL isSGDok;
    NSTimer *timer;
}

@property(nonatomic,retain)AVCaptureSession * AVSession;
@property (strong, nonatomic) ASProgressPopUpView *progressView1;


@end

@implementation UserPaiSheController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    ______WS();
    //初始化
    //frame最好为[UIScreen mainScreen].bounds屏幕宽高或等比宽高,否则isFullScreen=YES情况下filterView显示左右两边可能会有黑边,但最终录制的视频仍正常,即全屏无黑边
    _videoRecord=[[CDPVideoRecord alloc] initWithFrame:[UIScreen mainScreen].bounds
                                        cameraPosition:AVCaptureDevicePositionFront
                                          openBeautify:YES
                                          isFullScreen:YES
                                        addToSuperview:self.view];
    
    isSGDok = NO;
    //摄像头切换
    _cameraSwitchBt=[[UIButton alloc] init];
    [_cameraSwitchBt setBackgroundImage:[UIImage imageNamed:@"jtqh"] forState:(UIControlStateNormal)];
    [_cameraSwitchBt addTarget:self action:@selector(cameraSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cameraSwitchBt];
    [_cameraSwitchBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.view.mas_right).offset(-24);
        make.width.height.offset(24);
        make.top.equalTo(wSelf.view.mas_top).offset(30);
    }];
    
    
    
//    //闪光灯开关
//    _sgdButton=[[UIButton alloc] init];
//    [_sgdButton setBackgroundImage:[UIImage imageNamed:@"sgdKai"] forState:(UIControlStateNormal)];
//    [_sgdButton setBackgroundImage:[UIImage imageNamed:@"sgdGuan"] forState:(UIControlStateSelected)];
//    [_sgdButton addTarget:self action:@selector(sgdButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_sgdButton];
//    [_sgdButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(wSelf.view.mas_left).offset(24);
//        make.width.height.offset(24);
//        make.top.equalTo(wSelf.view.mas_top).offset(30);
//    }];
    
    
    
    //美颜开关
    _beautifyBt = [[UIButton alloc] init];
    [_beautifyBt setBackgroundImage:[UIImage imageNamed:@"meiyan"] forState:(UIControlStateNormal)];
    _beautifyBt.selected=YES;
    [_beautifyBt addTarget:self action:@selector(beautifyClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_beautifyBt];
    [_beautifyBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.view.mas_right).offset(-24);
        make.width.height.offset(24);
        make.bottom.equalTo(wSelf.view.mas_bottom).offset(-40);
    }];
    
    
    
    //录制开关
    _recordBt=[[UIImageView alloc] init];
    _recordBt.userInteractionEnabled = YES;
    _recordBt.layer.masksToBounds = YES;
    _recordBt.layer.cornerRadius = 30;
    [_recordBt setImage:[UIImage imageNamed:@"video_1"]];
    [self.view addSubview:_recordBt];
    [_recordBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.width.height.offset(60);
        make.centerY.equalTo(_beautifyBt);
    }];
    
    
    _backBtn=[[UIButton alloc] init];
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"cancelBACK"] forState:(UIControlStateNormal)];
    [_backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view.mas_left).offset(24);
        make.width.height.offset(24);
        make.bottom.equalTo(wSelf.view.mas_bottom).offset(-40);
    }];
    
    
    
//    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//    [_recordBt addGestureRecognizer:tapGR];
    
    
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]
                                                                initWithTarget:self
                                                                action:@selector(handleLongPressGestures:)];
    
    [_recordBt addGestureRecognizer:longPressGestureRecognizer];
    
    
    
}

// 定时器方法
- (void)actionLi {
    [_videoRecord finishRecordingAndSaveToLibrary:YES];
    [timer invalidate];
    timer = nil;
    
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"imageDisplay"];
    NSDictionary *dic = @{@"img":imageData};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"postPaishe" object:self userInfo:dic];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)tapAction:(UITapGestureRecognizer*)sender{
    [_recordBt setImage:[UIImage imageNamed:@"video_1"]];
    [_videoRecord startRecording];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(actionLi) userInfo:nil repeats:NO];
    NSLog(@"我是轻拍手势");
    
}

- (void)handleLongPressGestures:(UITapGestureRecognizer*)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"长按开始");
        [_recordBt setImage:[UIImage imageNamed:@"video_2"]];
        self.progressView1 = [[ASProgressPopUpView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        self.progressView1.popUpViewAnimatedColors = @[[UIColor redColor], [UIColor orangeColor], [UIColor greenColor]];
        self.progressView1.dataSource = self;
        [self.view addSubview:_progressView1];
        [self progress];
        [_videoRecord startRecording];

    }else if (sender.state == UIGestureRecognizerStateEnded){
        [_recordBt setImage:[UIImage imageNamed:@"video_1"]];
        [timer invalidate];
        timer = nil;            // 将销毁定时器
        [self endVideoSend];
    }
    else {
        NSLog(@"长按中");
    }
}


#pragma mark - 点击事件
//转换摄像头
-(void)cameraSwitch:(UIButton *)sender{
    //切换摄像头位置
    [_videoRecord changeCameraPosition];
    
    //判断当前摄像头位置
    sender.selected=([_videoRecord getCurrentCameraPosition]==AVCaptureDevicePositionFront)?NO:YES;
}
//开关美颜
-(void)beautifyClick:(UIButton *)sender{
    sender.selected=!sender.selected;
    
    //开关美颜功能
    _videoRecord.openBeautify=sender.selected;
}


- (void)sgdButtonAction {
    
    
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device.torchMode == AVCaptureTorchModeOff) {
        //Create an AV session
        self.AVSession = [[AVCaptureSession alloc]init];
        // Create device input and add to current session
        AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        [self.AVSession addInput:input];
        // Create video output and add to current session
        AVCaptureVideoDataOutput * output = [[AVCaptureVideoDataOutput alloc]init];
        [self.AVSession addOutput:output];
        // Start session configuration
        [self.AVSession beginConfiguration];
        [device lockForConfiguration:nil];
        // Set torch to on
        [device setTorchMode:AVCaptureTorchModeOn];
        [device unlockForConfiguration];
        [self.AVSession commitConfiguration];
        // Start the session
    }
    
    if (!isSGDok) {
        isSGDok = YES;
        [self.AVSession startRunning];
        
    }else{
        isSGDok = NO;
        
        [self.AVSession stopRunning];
        
    }
}


- (void)progress
{
    if (self.progressView1.progress >= 1.0) {
        [self endVideoSend];
        [timer invalidate];
        timer = nil;            // 将销毁定时器
    }
    
    float progress = self.progressView1.progress;
    if (progress < 1.0) {
        progress += 0.07;
        [self.progressView1 setProgress:progress animated:YES];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                 target:self
                                               selector:@selector(progress)
                                               userInfo:nil
                                                repeats:NO];
    }
}


- (void)endVideoSend{
    [_videoRecord finishRecordingAndSaveToLibrary:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"postPaishe" object:self userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (NSString *)progressView:(ASProgressPopUpView *)progressView stringForProgress:(float)progress
{
    NSString *s;
    if (progress >= 1.0) {
    }
    return s;
}

- (BOOL)progressViewShouldPreCalculatePopUpViewSize:(ASProgressPopUpView *)progressView;
{
    return NO;
}

////开关录制
//-(void)recordClick:(UIButton *)sender{
//    if (sender.selected==YES) {
//        //结束录制
//        [_videoRecord finishRecordingAndSaveToLibrary:YES];
////        [self dismissViewControllerAnimated:YES completion:nil];
//
////        MessageController *messVC = [[MessageController alloc] init];
//
//
//        [[NSNotificationCenter defaultCenter] postNotificationName:[[NSUserDefaults standardUserDefaults] objectForKey:@"postHome"] object:self userInfo:nil];
//        [self dismissViewControllerAnimated:YES completion:nil];
//
////        [self.navigationController pushViewController:messVC animated:YES];
//
//    }
//    else{
//        //开启录制
//        [_videoRecord startRecording];
//    }
//    sender.selected=!sender.selected;
//}


/*
 
 //save to Userdefaults
 
 NSData *imageData;
 // create NSData-object from image
 imageData = [NSKeyedArchiver archivedDataWithRootObject:yourUIImage];
 // save NSData-object to UserDefaults
 [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"image"];
 
 //load imag from Userdefaults
 NSData *imageData;
 imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"image"];
 
 if(imageData != nil)
 {
 yourUIImage = [NSKeyedUnarchiver unarchiveObjectWithData: imageData];
 }
 
 */





-(void)backClick {
    //    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
