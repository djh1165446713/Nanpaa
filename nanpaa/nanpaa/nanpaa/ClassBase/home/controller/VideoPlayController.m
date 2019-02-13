//
//  VideoPlayController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/2.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "VideoPlayController.h"
#import "UserView.h"
#import <AVKit/AVKit.h>
#import "WMPlayer.h"
#import "CeshiViewController.h"
#import "PayMentController.h"
#import "HisViewController.h"

@interface VideoPlayController ()<UIAlertViewDelegate,MBProgressHUDDelegate>
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) NSDictionary *userDic;
@property (nonatomic, strong) UserView *uView;
@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong) MPMoviePlayerController *player;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIImageView *imageVideoBG;
@property (nonatomic, strong) WMPlayer *ui_player;
@property (nonatomic, strong) NSDictionary *hisDic;
@property (nonatomic, assign) NSNumber* isFollow;
@property (nonatomic, assign) NSNumber* isFollowing;

@end

@implementation VideoPlayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadSuperView];
    [self loadData];
}

#pragma mark ----------他人信息数据请求-----------
- (void)loadData{
    
    ______WS();
    NSDictionary *dic = userMessage;
    NSDictionary *par = @{@"targetId":self.model.userid,
                          @"token":dic[@"token"],
                          @"userid":dic[@"userid"]};
    
    [[DJHttpApi shareInstance] POST:OtherUserUrl dict:par succeed:^(id data) {
        wSelf.hisDic = data[@"rspObject"];
        _isFollow = wSelf.hisDic[@"isFollower"];
        _isFollowing = wSelf.hisDic[@"isFollowing"];
        
        
    } failure:^(NSError *error) {
        
    }];

}

#pragma mark ----------特殊UI构造-----------
- (void)loadSuperView{
    [self initUI];
    [[NSUserDefaults standardUserDefaults] setObject:_model.hxAccount forKey:@"hxAcount"];
    _userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    
    // 全屏添加手势
    UITapGestureRecognizer *tap11 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    
    [self.view addGestureRecognizer:tap11];
}

- (void)addVideoPlay{
//    NSString *moviePath=[[NSBundle mainBundle]pathForResource:@"startMV" ofType:@"mp4"];
//    NSString
    
    _imageVideoBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _imageVideoBG.hidden = YES;
    [self.view addSubview:_imageVideoBG];
    
    self.player=[[MPMoviePlayerController alloc] init];
    self.player.view.frame=CGRectMake(0, 0, kScreenWidth + 1,kScreenHeight + 1);
    self.player.movieSourceType = MPMovieSourceTypeFile;// 播放本地视频时需要这句
    self.player.controlStyle = MPMovieControlStyleNone;// 不需要进度条
    self.player.shouldAutoplay = YES;// 是否自动播放（默认为YES）
    self.player.scalingMode = MPMovieScalingModeAspectFill;
    self.player.repeatMode = MPMovieRepeatModeOne;
    self.player.fullscreen = YES;
    [self.player prepareToPlay];
    [self.view addSubview:self.player.view];

    // 全屏添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];

    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.backgroundView.userInteractionEnabled = YES;
    self.backgroundView.backgroundColor = [UIColor clearColor];
    [self.backgroundView addGestureRecognizer:tap];
    [self.view addSubview:self.backgroundView];
}


#pragma mark    ----------UI构造-----------

- (void)initUI{
    ______WS();
    
    if (_model.message.direction == EMMessageDirectionReceive) {
        if (_model.isRead) {
            if ([_model.messageType isEqualToString:@"video"]) {
                _ui_player = [[WMPlayer alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth + 1, kScreenHeight + 1) videoURLStr:_model.localPath];
                _ui_player.userInteractionEnabled = NO;
                [self.view addSubview:_ui_player];
                [self.ui_player.player play];
                [self addNotification];
                [self initSonUi];
            }
            
            else if ([_model.messageType isEqualToString:@"image"]){
                _messageImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                _messageImg.contentMode = UIViewContentModeScaleAspectFill;
                _messageImg.clipsToBounds = YES;
                [self.view addSubview:_messageImg];
                NSData *imageData = [NSData dataWithContentsOfFile:_model.localPath];
                UIImage *image = [ UIImage imageWithData:imageData];
                _messageImg.image = image;
                [self initSonUi];
                
            }else{
                [self initGiftUI];
                [self initSonUi];
            }
        }
        
        if (!_model.isRead) {
            
            if ([_model.price isEqualToString:@"0"]) {
                if ([_model.messageType isEqualToString:@"video"]) {
//                    _ui_player = [[WMPlayer alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth + 1, kScreenHeight + 1) videoURLStr:_model.localPath];
//                    _ui_player.userInteractionEnabled = NO;
//                    [self.view addSubview:_ui_player];
                    [self addVideoPlay];
                    [self initSonUi];
                }
                if ([_model.messageType isEqualToString:@"image"]) {
                    _messageImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                    _messageImg.contentMode = UIViewContentModeScaleAspectFill;
                    _messageImg.clipsToBounds = YES;
                    [self.view addSubview:_messageImg];
                    
                    NSData *imageData = [NSData dataWithContentsOfFile:_model.localPath];
                    _messageImg.image = [UIImage imageWithData:imageData];
                }
                if ([_model.messageType isEqualToString:@"text"]){
                    self.view.backgroundColor = RGB(43, 45, 76);
                    [self initGiftUI];
                    [self initSonUi];
                    
                }
                
                
                EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:_model.conversationId type:EMConversationTypeChat createIfNotExist:NO];
                [conversation markMessageAsReadWithId:_model.messageId error:nil];

            }
            else{
                
                if ([_model.messageType isEqualToString:@"video"]) {
                    [self addVideoPlay];
//                    _ui_player = [[WMPlayer alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth + 1, kScreenHeight + 1) videoURLStr:_model.localPath];
//                    _ui_player = [[WMPlayer alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth + 1, kScreenHeight + 1)];
//                    _ui_player.userInteractionEnabled = NO;
//                    [self.view addSubview:_ui_player];
                }
                
                if ([_model.messageType isEqualToString:@"image"]) {
                    _messageImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                    _messageImg.contentMode = UIViewContentModeScaleAspectFill;
                    _messageImg.clipsToBounds = YES;
                    [self.view addSubview:_messageImg];
                   
                }
                
                if ([_model.messageType isEqualToString:@"text"]){
                    self.view.backgroundColor = RGB(43, 45, 76);
                    [self initGiftUI];
                    [self initSonUi];
                }
                
                if (![_model.messageType isEqualToString:@"text"]) {
                    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                    _toolBar.barStyle = UIBarStyleBlackTranslucent;
                    [self.view addSubview:_toolBar];

                    _uView = [[UserView alloc] init];
                    _uView.coinLab.hidden = YES;
                    _uView.replyButton.hidden = YES;
                    [_uView.lockBtn setTitle:[NSString stringWithFormat:@"Unlock for %@ ponints",_model.price] forState:(UIControlStateNormal)];
                    [_uView.lockBtn addTarget:self action:@selector(unlockAction) forControlEvents:(UIControlEventTouchUpInside)];
                    _uView.userInteractionEnabled = YES;
                    _uView.layer.masksToBounds = YES;
                    _uView.layer.cornerRadius = 20;
                    _uView.coinLab.text = _model.replycoin;
                    [_uView.headImg sd_setImageWithURL:[NSURL URLWithString:_model.avatarUrl] placeholderImage:[UIImage imageNamed:@"placeholderImg"]];
                    [self.view addSubview:_uView];
                    [_uView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(wSelf.view).offset(20);
                        make.bottom.equalTo(wSelf.view.mas_bottom).offset(-24);
                        make.height.offset(50);
                        make.width.offset(280);
                    }];
                }
                

            }
            
            
            _HUD = [[MBProgressHUD alloc]initWithView:self.view];
            [self.view addSubview:_HUD];
            _HUD.mode = MBProgressHUDModeIndeterminate;
            _HUD.color = [UIColor blackColor];
            _HUD.delegate =self;
            [_HUD show:YES];
            
            
            [[EMClient sharedClient].chatManager asyncDownloadMessageAttachments:_model.message progress:^(int progress) {
                NSLog(@"%d",progress);
            } completion:^(EMMessage *message, EMError *error) {
                
                [wSelf.HUD removeFromSuperview];
                if ([_model.messageType isEqualToString:@"video"]) {
                    [wSelf.player setContentURL:[NSURL fileURLWithPath:wSelf.model.localPath]];
                    [wSelf.player play];
//                    _ui_player.videoURLStr = _model.localPath;
//                    double delayInSeconds = 1.0;
//                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
////                        _ui_player = [[WMPlayer alloc]init];
//                        [_ui_player.player play];
//                    });
                    
                }else if ([wSelf.model.messageType isEqualToString:@"image"]){
                    NSData *imageData = [NSData dataWithContentsOfFile:wSelf.model.localPath];
                    wSelf.messageImg.image = [UIImage imageWithData:imageData];
                }else{
                }
            }];
        }
    }

}

- (void)initSonUi{
    ______WS();
    _messageLab = [[UILabel alloc] init];
    _messageLab.textAlignment = NSTextAlignmentCenter;
    _messageLab.text = _model.inputText;
    _messageLab.backgroundColor = RGB(102, 102, 102);
    _messageLab.lineBreakMode = NSLineBreakByTruncatingTail;
    _messageLab.numberOfLines = 0;
    _messageLab.textColor = [UIColor whiteColor];
    _messageLab.alpha = 0.5;
    _messageLab.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_messageLab];
    [_messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.view);
        make.height.offset(100);
        make.width.offset(kScreenWidth);
    }];
    
    UITapGestureRecognizer *tapHead = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeadAction)];
    _uView = [[UserView alloc] init];
    _uView.lockBtn.hidden = YES;
    [_uView.headImg addGestureRecognizer:tapHead];
    [_uView.replyButton addTarget:self action:@selector(replyAction) forControlEvents:(UIControlEventTouchUpInside)];
    _uView.coinLab.text = _model.replycoin;
    _uView.layer.masksToBounds = YES;
    [_uView.headImg sd_setImageWithURL:[NSURL URLWithString:_model.avatarUrl] placeholderImage:[UIImage imageNamed:@"placeholderImg"] options:(SDWebImageRefreshCached)];
    _uView.layer.cornerRadius = 25;
    [self.view addSubview:_uView];
    [_uView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(20);
        make.bottom.equalTo(wSelf.view.mas_bottom).offset(-24);
        make.height.offset(50);
        make.width.offset(170);
    }];

}

- (void)initGiftUI{
    
    ______WS();
    self.view.backgroundColor = RGB(44, 47, 76);
    UIImageView *giftBGImg = [[UIImageView alloc] init];
    giftBGImg.image = [UIImage imageNamed:@"giftBGImg"];
    giftBGImg.layer.masksToBounds = YES;
    giftBGImg.layer.cornerRadius = 150;
    [self.view addSubview:giftBGImg];
    [giftBGImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.centerY.equalTo(wSelf.view);
        make.width.height.offset(300);
    }];
    
    
    UILabel *priceLab = [[UILabel alloc] init];
    priceLab.textColor = [UIColor whiteColor];
    priceLab.userInteractionEnabled = NO;
    priceLab.font = [UIFont systemFontOfSize:33];
    priceLab.text = _model.price;
    priceLab.textAlignment = NSTextAlignmentCenter;
    [giftBGImg addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(giftBGImg);
        make.height.offset(33);
        make.bottom.equalTo(giftBGImg.mas_bottom).offset(-70);
        make.width.offset(300);
    }];
    
    
    EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:_model.conversationId type:EMConversationTypeChat createIfNotExist:NO];
    [conversation markMessageAsReadWithId:_model.messageId error:nil];
    
}

#pragma mark ----------给播放器添加观察者-----------
-(void)addNotification{
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.ui_player.player.currentItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                            selector:@selector(MovieFinishedCallback:)
     
                                                name:MPMoviePlayerPlaybackDidFinishNotification
     
                                              object:self.player];
}


-(void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成.");
    // 播放完成后重复播放
    // 跳到最新的时间点开始播放
    [_ui_player.player seekToTime:CMTimeMake(0, 1)];
    [_ui_player.player play];
}


-(void)MovieFinishedCallback:(NSNotification *)notification{
    [self.player pause];
    double delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [self.player play];
    });
}

#pragma mark ----------自定义方法-----------
- (void)tapHeadAction{
    self.hidesBottomBarWhenPushed = YES;
    HisViewController *vc = [[HisViewController alloc] init];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)tapAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)replyAction {
//    [[NSUserDefaults standardUserDefaults] setObject:self.model.replycoin forKey:@"userReplyNum"];
//    self.hidesBottomBarWhenPushed = YES;
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"huiFu"];
//    CeshiViewController *vc = [[CeshiViewController alloc] init];
//    [self.navigationController presentViewController:vc animated:YES completion:nil];
    
    NSString *coin = [NSString stringWithFormat:@"%@",_userDic[@"coin"]];
    NSString *price = [NSString stringWithFormat:@"%@",_model.replycoin];
    if ([coin integerValue] > [price integerValue] == YES ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Please confirm whether or not to pay %@",_model.replycoin]  delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        alert.tag = 2003;
        [alert show];
    }else {
        self.hidesBottomBarWhenPushed = YES;
        PayMentController *vc = [[PayMentController alloc] init];
        [self.navigationController presentViewController:vc animated:YES completion:nil];
    }

    
}

- (void)unlockAction {
    
    NSString *coin = [NSString stringWithFormat:@"%@",_userDic[@"coin"]];
    NSString *price = [NSString stringWithFormat:@"%@",_model.price];
    if ([coin integerValue] > [price integerValue] == YES ) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"confirm purchase" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        alert.tag = 2002;
            [alert show];
    }else {
        self.hidesBottomBarWhenPushed = YES;
        PayMentController *vc = [[PayMentController alloc] init];
        [self.navigationController presentViewController:vc animated:YES completion:nil];
    }

}

#pragma mark ----------UIAlertView Delegate-----------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    ______WS();
    if (buttonIndex == 0) {
        
    }else {
        NSDictionary *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];

        if (alertView.tag == 2002) {
            NSDictionary *par = @{@"coin":_model.price,
                                  @"targetId":_model.userid,
                                  @"type":@"1",
                                  @"token":user[@"token"],
                                  @"userid":user[@"userid"]};
            
            [[DJHttpApi shareInstance] POST:payMentUrl dict:par succeed:^(id data) {
                [wSelf.uView removeFromSuperview];
                wSelf.uView = [[UserView alloc] init];
                wSelf.uView.lockBtn.hidden = YES;
                [wSelf.uView.replyButton addTarget:self action:@selector(replyAction) forControlEvents:(UIControlEventTouchUpInside)];
                wSelf.uView.userInteractionEnabled = YES;
                wSelf.uView.coinLab.text = _model.replycoin;
                wSelf.uView.layer.masksToBounds = YES;
                [wSelf.uView.headImg sd_setImageWithURL:[NSURL URLWithString:wSelf.model.avatarUrl] placeholderImage:[UIImage imageNamed:@"placeholderImg"]];
                wSelf.uView.layer.cornerRadius = 25;
                [wSelf.view addSubview:wSelf.uView];
                [wSelf.uView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(wSelf.view).offset(20);
                    make.bottom.equalTo(wSelf.view.mas_bottom).offset(-24);
                    make.height.offset(50);
                    make.width.offset(170);
                }];
                
                wSelf.messageLab = [[UILabel alloc] init];
                wSelf.messageLab.textAlignment = NSTextAlignmentCenter;
                wSelf.messageLab.text = _model.inputText;
                wSelf.messageLab.backgroundColor = RGB(102, 102, 102);
                wSelf.messageLab.lineBreakMode = NSLineBreakByTruncatingTail;
                wSelf.messageLab.numberOfLines = 0;
                wSelf.messageLab.textColor = [UIColor whiteColor];
                wSelf.messageLab.alpha = 0.8;
                wSelf.messageLab.font = [UIFont systemFontOfSize:20];
                [wSelf.view addSubview:wSelf.messageLab];
                [wSelf.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(wSelf.view);
                    make.height.offset(100);
                    make.width.offset(kScreenWidth);
                }];
                
                [wSelf.toolBar removeFromSuperview];
                if ([wSelf.model.messageType isEqualToString:@"video"]) {
                }
                
                EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:_model.conversationId type:EMConversationTypeChat createIfNotExist:NO];
                [conversation markMessageAsReadWithId:_model.messageId error:nil];
            } failure:^(NSError *error) {
                
            }];
        }
        if (alertView.tag == 2003) {
            if ([_isFollow integerValue] == 1 && [_isFollowing integerValue] == 1) {
                self.hidesBottomBarWhenPushed = YES;
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"huiFu"];
                CeshiViewController *vc = [[CeshiViewController alloc] init];
                [self.navigationController presentViewController:vc animated:YES completion:nil];
            }else{
                NSDictionary *par = @{@"coin":_model.replycoin,
                                      @"targetId":_model.userid,
                                      @"type":@"1",
                                      @"token":user[@"token"],
                                      @"userid":user[@"userid"]};
                
                [[DJHttpApi shareInstance] POST:payMentUrl dict:par succeed:^(id data) {
                    
                    self.hidesBottomBarWhenPushed = YES;
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"huiFu"];
                    CeshiViewController *vc = [[CeshiViewController alloc] init];
                    [self.navigationController presentViewController:vc animated:YES completion:nil];
                    
                } failure:^(NSError *error) {
                    
                }];

            }
        }
    }
}



- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:MPMoviePlayerPlaybackDidFinishNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:AVPlayerItemDidPlayToEndTimeNotification];
    self.ui_player.player = nil;
    self.ui_player.playerLayer = nil;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.ui_player.player pause];
}

@end
