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
//#import "IQKeyboardManager.h"
#import "CustomTextField.h"

@interface MessageController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) CustomTextField *messageText;
@property (nonatomic, strong) WMPlayer *ui_player;
@property (nonatomic, strong) UIButton *downButton;
@property (nonatomic, strong) UIButton *broadcastBuuton;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong) UIButton *leftNavBtn;

@end

@implementation MessageController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUI];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayDidEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:nil];
}



- (void)initUI {
    ______WS();
    
    if (_image != nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
//        UIImage *image = [ NSKeyedUnarchiver unarchiveObjectWithData:_data];
        _imageView.image =_image;
        [self.view addSubview:_imageView];
        
    }else {
//        [self addVideoPlay];
        _ui_player = [[WMPlayer alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth + 1, kScreenHeight + 1) videoURLStr:videoPath];
        _ui_player.userInteractionEnabled = NO;
        [self.view addSubview:_ui_player];
        [_ui_player.player play];
    }
    
    UITapGestureRecognizer *tap11 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    
    _messageText = [[CustomTextField alloc] initWithFrame:CGRectMake(0,  kScreenHeight / 2, kScreenWidth, 40) placeholder:nil clear:YES leftView:nil fontSize:20.0];
//    _messageText.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
    _messageText.alpha = 0.5;
    _messageText.delegate = self;
    _messageText.textAlignment = NSTextAlignmentCenter;
    _messageText.backgroundColor = RGB(102, 102, 102);
    [self.view addSubview:_messageText];
  
    
    self.downButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.downButton setImage:[UIImage imageNamed:@"downLoad"] forState:(UIControlStateNormal)];
    [self.downButton addTarget:self action:@selector(downVorM) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.downButton];
    [self.downButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.view.mas_right).offset(-30);
        make.top.equalTo(wSelf.view.mas_top).offset(30);
        make.width.height.offset(35);
    }];
    
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"typeBrod"]);
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"typeBrod"] isEqualToString:@"reply"]) {
        
        _leftNavBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_leftNavBtn setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
        _leftNavBtn.exclusiveTouch = YES;
        [_leftNavBtn  addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:_leftNavBtn];
        [_leftNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.view).offset(0);
            make.top.equalTo(wSelf.view).offset(25);
            make.width.offset(50);
            make.height.offset(24);
        }];
        
        _broadcastBuuton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _broadcastBuuton.backgroundColor = RGB(212, 39, 82);
        [_broadcastBuuton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_broadcastBuuton addTarget:self action:@selector(broadSendAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_broadcastBuuton setTitle:@"Reply" forState:(UIControlStateNormal)];
        
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
        
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"typeBrod"] isEqualToString:@"send"]){
        
        _leftNavBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_leftNavBtn setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
        _leftNavBtn.exclusiveTouch = YES;
        [_leftNavBtn  addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:_leftNavBtn];
        [_leftNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.view).offset(0);
            make.top.equalTo(wSelf.view).offset(25);
            make.width.offset(50);
            make.height.offset(24);
        }];

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
    }
    else {

        BackAndNextView *bottomView = [[BackAndNextView alloc] init];
        [bottomView.backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
        [bottomView.nextButton addTarget:self action:@selector(nextController) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(kScreenWidth);
            make.height.offset(75);
            make.bottom.equalTo(wSelf.view.mas_bottom).offset(0);
        }];
        
        UIView *backGroundView = [[UIView alloc] init];
        [backGroundView addGestureRecognizer:tap11];
        [self.view addSubview:backGroundView];
        [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(bottomView.mas_top).offset(0);
            make.width.offset(kScreenWidth);
            make.top.equalTo(wSelf.view.mas_top).offset(0);
        }];
    }
    
}
- (void)moviePlayDidEnd:(NSNotification *)notification {
    [_ui_player.player seekToTime:kCMTimeZero];
    [_ui_player.player play];
}

- (void)tapAction{
//    [self.navigationController popViewControllerAnimated:YES];
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

/**
 *  自适应字体
 */
-(CGSize)sizeWithString:(NSString*)string font:(UIFont*)font     width:(float)width {
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width,   80000) options:NSStringDrawingTruncatesLastVisibleLine |   NSStringDrawingUsesFontLeading    |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size;
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
    if (_image != nil) {
        szVC.img = _image;
    }
    [self.navigationController pushViewController:szVC animated:YES];

}

- (void)broadSendAction {
    self.hidesBottomBarWhenPushed=YES;
    HuiFuController *vc = [[HuiFuController alloc] init];
    if (_image != nil) {
        vc.img = _image;
    }
    vc.textStr = self.messageText.text;
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_messageText becomeFirstResponder];
    [self.ui_player.player play];
//    [[IQKeyboardManager sharedManager] setEnable:YES];
//    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;  //控制点击背景是否收起键盘

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.ui_player.player pause];

}

- (void)dealloc {
    NSLog(@"信息这个页面已经被注销");
    [self.ui_player removeFromSuperview];
    self.ui_player = nil;
}
@end
