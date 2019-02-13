
//
//  MyindexAvController.m
//  nanpaa
//
//  Created by bianKerMacBook on 17/1/19.
//  Copyright © 2017年 bianKerMacBookDJH. All rights reserved.
//

#import "MyindexAvController.h"
#import "WMPlayer.h"
#import "UserPaiSheController.h"
#import "SaveMyVideoController.h"


@interface MyindexAvController ()

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *againShootBtn;
@property (nonatomic, strong) WMPlayer *ui_player;

@end

@implementation MyindexAvController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)initUI{
    
    ______WS();
    _ui_player = [[WMPlayer alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth + 1, kScreenHeight + 1) videoURLStr:self.videoUrlStr];
    _ui_player.userInteractionEnabled = NO;
    [self.view addSubview:_ui_player];
    [self.ui_player.player play];
    [self addNotification];
    
    _cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"cancelBACK"] forState:(UIControlStateNormal)];
    [_cancelBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view.mas_left).offset(24);
        make.width.height.offset(24);
        make.bottom.equalTo(wSelf.view.mas_bottom).offset(-40);
    }];
    
    _againShootBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _againShootBtn.layer.masksToBounds = YES;
    _againShootBtn.layer.cornerRadius = 8;
    _againShootBtn.layer.borderWidth = 1;
    [_againShootBtn.layer setBorderColor:RGB(223, 63, 101).CGColor];
    [_againShootBtn setTitleColor:RGB(223, 63, 101) forState:(UIControlStateNormal)];
    [_againShootBtn setTitle:@"Re-shoot a video >" forState:(UIControlStateNormal)];
    [_againShootBtn addTarget:self action:@selector(againActinVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_againShootBtn];
    [_againShootBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.view.mas_right).offset(-38);
        make.width.offset(180);
        make.height.offset(50);
        make.centerY.equalTo(wSelf.cancelBtn);
        
    }];
    
}

- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)addNotification{
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.ui_player.player.currentItem];
    
}

-(void)playbackFinished:(NSNotification *)notification{
    // 播放完成后重复播放
    // 跳到最新的时间点开始播放
    [_ui_player.player seekToTime:CMTimeMake(1, 1)];
    [_ui_player.player play];
}


- (void)jumpSaveControSend{
    self.hidesBottomBarWhenPushed = YES;
    SaveMyVideoController *vc = [[SaveMyVideoController alloc] init];
    vc.videoUrlStr = videoPath;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)againActinVideo{
    self.hidesBottomBarWhenPushed = YES;
    UserPaiSheController *vc = [[UserPaiSheController alloc] init];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.ui_player.player play];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.ui_player.player pause];

}

- (void)dealloc{
    self.ui_player.player = nil;
    self.ui_player.playerLayer = nil;
}

@end
