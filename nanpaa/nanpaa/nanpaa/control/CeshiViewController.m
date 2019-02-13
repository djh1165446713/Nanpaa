
//
//  CeshiViewController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/18.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "CeshiViewController.h"
#import "CDPVideoRecord.h"
#import "MBProgressHUD.h"
#import "MessageController.h"
#import "ASProgressPopUpView.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>
#import <AVFoundation/AVFoundation.h>

#define SWIDTH   [UIScreen mainScreen].bounds.size.width
#define SHEIGHT  [UIScreen mainScreen].bounds.size.height
@interface CeshiViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,MBProgressHUDDelegate,ASProgressPopUpViewDataSource>
{
    
    CDPVideoRecord *_videoRecord;
    
    UITapGestureRecognizer *tapAction;
    UIImageView *_recordBt;//录制开关
    UIButton *_beautifyBt;//美颜开关
    UIButton *_cameraSwitchBt;//摄像头切换
    UIButton *_backBtn;
    UIButton *_sgdButton;
    AVCaptureSession * _AVSession;//调用闪光灯的时候创建的类
    NSTimer *timer;
}
@property (strong, nonatomic) ASProgressPopUpView *progressView1;

@property(nonatomic,retain)AVCaptureSession * AVSession;
@property (nonatomic, retain) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, assign) BOOL isVideoIng;

@end

@implementation CeshiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    _isVideoIng = NO;
    
    ______WS();
    //初始化
    //frame最好为[UIScreen mainScreen].bounds屏幕宽高或等比宽高,否则isFullScreen=YES情况下filterView显示左右两边可能会有黑边,但最终录制的视频仍正常,即全屏无黑边
    _videoRecord=[[CDPVideoRecord alloc] initWithFrame:[UIScreen mainScreen].bounds
                                        cameraPosition:AVCaptureDevicePositionFront
                                          openBeautify:YES
                                          isFullScreen:YES
                                        addToSuperview:self.view];
    
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
    _recordBt.backgroundColor = RGB(26, 200, 175);
    [_recordBt.layer setBorderColor:[UIColor whiteColor].CGColor];
    _recordBt.layer.borderWidth = 1;
    _recordBt.layer.masksToBounds = YES;
    _recordBt.layer.cornerRadius = 30;
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
    
    
    tapAction = [[UITapGestureRecognizer alloc]
                                  initWithTarget:self
                                  action:@selector(tapAction:)];

    [_recordBt addGestureRecognizer:tapAction];


    
}


- (void)tapAction:(UITapGestureRecognizer*)sender {
    

    if (_isVideoIng) {
        [timer invalidate];
        timer = nil;            // 将销毁定时器
        [_videoRecord finishRecordingAndSaveToLibrary:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:[[NSUserDefaults standardUserDefaults] objectForKey:@"postHome"] object:self userInfo:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [_videoRecord startRecording];
        _isVideoIng = YES;

        self.progressView1 = [[ASProgressPopUpView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        self.progressView1.popUpViewAnimatedColors = @[[UIColor redColor], [UIColor orangeColor], [UIColor greenColor]];
        self.progressView1.dataSource = self;
        [self.view addSubview:_progressView1];
        [self progress];

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
    _videoRecord.openBeautify = sender.selected;
}


- (void)progress
{
    if (self.progressView1.progress >= 1.0) {
        [self endVideoSend];
        [timer invalidate];
        timer = nil;            // 将销毁定时器
    }
    
    float progress = self.progressView1.progress;
    if (_isVideoIng && progress < 1.0) {
        progress += 0.07;
        [self.progressView1 setProgress:progress animated:self.isVideoIng];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1
                                         target:self
                                       selector:@selector(progress)
                                       userInfo:nil
                                        repeats:NO];
    }
}

- (void)endVideoSend{
    [_videoRecord finishRecordingAndSaveToLibrary:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:[[NSUserDefaults standardUserDefaults] objectForKey:@"postHome"] object:self userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - ASProgressPopUpView dataSource
// <ASProgressPopUpViewDataSource> is entirely optional
// it allows you to supply custom NSStrings to ASProgressPopUpView
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


-(void)backClick {
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidDisappear:(BOOL)animated {

}



@end
