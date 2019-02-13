//
//  HuiFuController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/14.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "HuiFuController.h"
#import "PiontSendView.h"
#import <AVKit/AVKit.h>
#import "KVTimer.h"
#import "WMPlayer.h"
#import "ShowPointView.h"
#import "CeshiViewController.h"
#import "PayMentController.h"

@interface HuiFuController ()
@property (nonatomic, strong) WMPlayer *ui_player;
@property (nonatomic, strong) NSDictionary *userDic;
@property (nonatomic, strong) ShowPointView *showView;
@property (nonatomic, strong) NSString *replycoin;
@end

@implementation HuiFuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];

    [self initUI];
    
}

- (void)initUI{
    ______WS();
    if (self.imgData != nil) {
        _messageImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _messageImg.contentMode = UIViewContentModeScaleAspectFill;
        _messageImg.clipsToBounds = YES;
        UIImage *image = [ NSKeyedUnarchiver unarchiveObjectWithData:self.imgData];
        _messageImg.image = image;
        [self.view addSubview:_messageImg];
    }else{
        //    NSString *path = [[NSUserDefaults standardUserDefaults] objectForKey:@"mp4Path"];
        _ui_player = [[WMPlayer alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth + 1, kScreenHeight + 1) videoURLStr:videoPath];
        _ui_player.userInteractionEnabled = NO;
        [self.view addSubview:_ui_player];
    }
    
    
    PiontSendView *uView = [[PiontSendView alloc] init];
//    uView.userInteractionEnabled = YES;
    [self.view addSubview:uView];
    [uView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wSelf.view.mas_bottom).offset(0);
        make.height.offset(70);
        make.width.offset(kScreenWidth);
    }];
    

    _backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_backButton setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
    [self.view addSubview:_backButton];
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(uView).offset(20);
        make.centerY.equalTo(uView);
        make.width.height.offset(30);
    }];
    
    
    _nextButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"typeBrod"] isEqualToString:@"reply"]) {
        [_nextButton setTitle:@"Reply" forState:(UIControlStateNormal)];
    }else{
        [_nextButton setTitle:@"Send" forState:(UIControlStateNormal)];
    }
    [_nextButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    _nextButton.backgroundColor = RGB(212, 39, 82);
    _nextButton.layer.masksToBounds = YES;
    _nextButton.layer.cornerRadius = 8;
    //        [_nextButton.layer setBorderColor:RGB(200, 39, 81).CGColor];
    [self.view addSubview:_nextButton];
    [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.backButton);
        make.height.offset(29);
        make.right.equalTo(uView.mas_right).offset(-24);
        make.width.offset(65);
    }];
    
    
    _coinButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_coinButton setBackgroundImage:[UIImage imageNamed:@"mainPoint"] forState:(UIControlStateNormal)];
    _coinButton.backgroundColor = [UIColor clearColor];
    _coinButton.layer.masksToBounds = YES;
    _coinButton.layer.cornerRadius = 15;
    [self.view addSubview:_coinButton];
    [_coinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.backButton);
        make.height.offset(30);
        make.right.equalTo(wSelf.nextButton.mas_left).offset(-29);
        make.width.offset(30);
        
    }];

    
    [self.coinButton addTarget:self action:@selector(coinAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.nextButton addTarget:self action:@selector(sendAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];

    // 全屏添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
}


#pragma mark ---  自定义方法
- (void)tapAction{
//    [self.navigationController popViewControllerAnimated:YES];
}


- (void)coinAction {
    ______WS();
    _showView = [[ShowPointView alloc] init];
    _showView.alpha = 0;
    [self.view addSubview:_showView];
    [_showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.centerY.equalTo(wSelf.view);
        make.height.offset(370);
        make.width.offset(300);
        
    }];
    [UIView animateWithDuration:2 animations:^{
        _showView.alpha = 0.8;

    }];

}


- (void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)sendAction {
    ______WS();
    _nextButton.enabled = NO;
    NSDictionary *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSString *from = [[EMClient sharedClient] currentUsername];
    NSString *hxAcount = [[NSUserDefaults standardUserDefaults] objectForKey:@"hxAcount"];
    NSMutableDictionary *messgeDic1 = [NSMutableDictionary dictionary];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:user[@"userid"]] == nil) {
        _replycoin = @"200";
    }else{
        _replycoin = [[NSUserDefaults standardUserDefaults] objectForKey:user[@"userid"]];
    }
    
    [messgeDic1 setObject:_userDic[@"avatarUrl"] forKey:@"avatarUrl"];
    [messgeDic1 setObject:_userDic[@"nickname"] forKey:@"nickname"];
    [messgeDic1 setObject:_textStr forKey:@"inputText"];
    [messgeDic1 setObject:user[@"userid"] forKey:@"userid"];
    [messgeDic1 setObject:from forKey:@"hxAccount"];
    if (_showView.timer.timeLabel.text == nil) {
        [messgeDic1 setObject:@"0" forKey:@"price"];
    }else{
        [messgeDic1 setObject:_showView.timer.timeLabel.text forKey:@"price"];
    }
    [messgeDic1 setObject:_replycoin forKey:@"replycoin"];
    [messgeDic1 setObject:@"1" forKey:@"typeMessage"];
    
    
    
    if (_img == nil) {
            // 发送信息
            EMVideoMessageBody *body = [[EMVideoMessageBody alloc] initWithLocalPath:videoPath displayName:@"video.mp4"];
            // 生成message
            EMMessage *message = [[EMMessage alloc] initWithConversationID:hxAcount from:from to:hxAcount body:body ext:messgeDic1];
            message.chatType = EMChatTypeChat;// 设置为单聊消息
            [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
                
            } completion:^(EMMessage *message, EMError *error) {
                NSLog(@"%@",message);
                NSLog(@"%@",error);
                [wSelf.ui_player removeFromSuperview];
                wSelf.ui_player.player = nil;
                wSelf.ui_player.playerLayer = nil;
//                [wSelf.navigationController popToViewController:[wSelf.navigationController.viewControllers objectAtIndex:1] animated:YES];
            }];
        
    }else {
            NSData *imageDt = UIImageJPEGRepresentation(_img, 0.8);
            EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithData:imageDt displayName:[NSString stringWithFormat:@"%@.png",from]];
            // 生成message
            EMMessage *message = [[EMMessage alloc] initWithConversationID:hxAcount from:from to:hxAcount body:body ext:messgeDic1];
            message.chatType = EMChatTypeChat;// 设置为单聊消息
            
            [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
            } completion:^(EMMessage *message, EMError *error) {
                NSLog(@"%@",error);
//                [wSelf.navigationController popToViewController:[wSelf.navigationController.viewControllers objectAtIndex:1] animated:YES];
            }];
        }
    
//    EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithData:_imgData displayName:[NSString stringWithFormat:@"%@.jpg",from]];
//    // 生成message
//    EMMessage *message = [[EMMessage alloc] initWithConversationID:hxAcount from:from to:hxAcount body:body ext:messgeDic1];
//    message.chatType = EMChatTypeChat;// 设置为单聊消息
//    
//    [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
//    } completion:^(EMMessage *message, EMError *error) {
//        NSLog(@"%@",message.conversationId);
//    }];
    [wSelf.navigationController popToViewController:[wSelf.navigationController.viewControllers objectAtIndex:1]
                                           animated:YES];
    [[DJHManager shareManager] toastManager:@"Sending successful" superView:[UIApplication sharedApplication].keyWindow];

}




- (void)viewDidAppear:(BOOL)animated {
    [_ui_player.player play];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"huiFu"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"huiFu"];

}

- (void)dealloc {
    NSLog(@"HuiFuVC,这个页面销毁了");
}

@end
