//
//  MessageController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/9/20.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "MessageController.h"
#import "SheZhiPointController.h"
#import "BackAndNextView.h"
#import "WMPlayer.h"
#import "VideoPlayController.h"
#import "HuiFuController.h"
#import "IQKeyboardManager.h"

@interface MessageController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITextField *messageText;
@property (nonatomic, strong) WMPlayer *ui_player;
@property (nonatomic, strong) UIButton *downButton;
@property (nonatomic, strong) UIButton *broadcastBuuton;
@property (nonatomic, strong) MPMoviePlayerController *player;


@end

@implementation MessageController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUI];
}
- (void)addVideoPlay{
    //    NSString *moviePath=[[NSBundle mainBundle]pathForResource:@"startMV" ofType:@"mp4"];
    //    NSString
    self.player = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL fileURLWithPath:videoPath]];
    [self.view addSubview:self.player.view];
    self.player.view.frame = CGRectMake(0, 0, kScreenWidth + 1,kScreenHeight + 1);
    self.player.movieSourceType = MPMovieSourceTypeFile;// 播放本地视频时需要这句
    self.player.controlStyle = MPMovieControlStyleNone;// 不需要进度条
    self.player.shouldAutoplay = YES;// 是否自动播放（默认为YES）
    self.player.scalingMode = MPMovieScalingModeAspectFill;
    self.player.repeatMode = MPMovieRepeatModeOne;
    self.player.fullscreen = YES;
}

- (void)initUI {
    ______WS();
    
    if (_data != nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        UIImage *image = [ NSKeyedUnarchiver unarchiveObjectWithData:_data];
        _imageView.image = image;
        [self.view addSubview:_imageView];
        
    }else {
        [self addVideoPlay];
    }
    
    _messageText = [[UITextField alloc] init];
    _messageText.alpha = 0.5;
    _messageText.delegate = self;
    _messageText.textAlignment = NSTextAlignmentCenter;
    _messageText.backgroundColor = RGB(102, 102, 102);
    _messageText.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:_messageText];
    [_messageText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.view);
        make.height.offset(40);
        make.width.offset(kScreenWidth);
    }];
    
    self.downButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.downButton setImage:[UIImage imageNamed:@"downLoad"] forState:(UIControlStateNormal)];
    [self.downButton addTarget:self action:@selector(downVorM) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.downButton];
    [self.downButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.view.mas_right).offset(-30);
        make.top.equalTo(wSelf.view.mas_top).offset(30);
        make.width.height.offset(35);
    }];
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"huiFu"]) {
        
        // 全屏添加手势
        UITapGestureRecognizer *tap11 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        
        _broadcastBuuton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _broadcastBuuton.backgroundColor = RGB(212, 39, 82);
        [_broadcastBuuton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_broadcastBuuton addTarget:self action:@selector(broadSendAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_broadcastBuuton setTitle:@"Broadcast" forState:(UIControlStateNormal)];
        
        [self.view addSubview:_broadcastBuuton];
        [_broadcastBuuton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(wSelf.view.mas_bottom).offset(0);
            make.width.offset(kScreenWidth);
            make.height.offset(60);
        }];
        
        UIView *backGroundView = [[UIView alloc] init];
        [backGroundView addGestureRecognizer:tap11];
        [self.view addSubview:backGroundView];
        [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(wSelf.broadcastBuuton.mas_top).offset(0);
            make.width.offset(kScreenWidth);
            make.top.equalTo(wSelf.view.mas_top).offset(0);
        }];
        
        
    }else {
        BackAndNextView *bottomView = [[BackAndNextView alloc] init];
        [bottomView.backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
        [bottomView.nextButton addTarget:self action:@selector(nextController) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(kScreenWidth);
            make.height.offset(75);
            make.bottom.equalTo(wSelf.view.mas_bottom).offset(0);
        }];
    }
    
}


- (void)tapAction{
    [self.navigationController popViewControllerAnimated:YES];
}

// 下载方法
- (void)downVorM{
    if (self.data != nil) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *image = [ NSKeyedUnarchiver unarchiveObjectWithData:_data];
            _imageView.image = image;
                //保存相册核心代码
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(videoOrImage:didFinishSavingWithError:contextInfo:), nil);
        }
        );
    }else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(videoPath)) {
                //保存相册核心代码
                
                UISaveVideoAtPathToSavedPhotosAlbum(videoPath, self, @selector(videoOrImage:didFinishSavingWithError:contextInfo:), nil);
            }
        });
    }
}

#pragma mark 视频保存完毕的回调
- (void)videoOrImage:(NSString *)video1Path didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInf{
 
    [[DJHManager shareManager] toastManager:@"save succee" superView:self.view];
}

#pragma mark ---- 自定义方法

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)nextController {
    self.hidesBottomBarWhenPushed=YES;
    SheZhiPointController *szVC = [[SheZhiPointController alloc] init];
    szVC.textStr = _messageText.text;
    if (_data != nil) {
        szVC.imageData = _data;
    }
    [self.navigationController pushViewController:szVC animated:YES];

}

- (void)broadSendAction {
    self.hidesBottomBarWhenPushed=YES;
    HuiFuController *vc = [[HuiFuController alloc] init];
    vc.textStr = self.messageText.text;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    [_messageText resignFirstResponder];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_messageText becomeFirstResponder];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;  //控制点击背景是否收起键盘

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"huiFu"];

}

- (void)dealloc {
    NSLog(@"信息这个页面已经被注销");
}
@end
