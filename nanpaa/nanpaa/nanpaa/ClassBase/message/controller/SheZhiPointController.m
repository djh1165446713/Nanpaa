//
//  SheZhiPointController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/27.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "SheZhiPointController.h"
#import "KVTimer.h"
#import "WMPlayer.h"
#import "HomeController.h"
#import "BackAndNextView.h"
#import "ChooserUserController.h"
#import "MessageController.h"

@interface SheZhiPointController ()<KVTimerDelegate>
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *titleAbout;
@property (nonatomic, strong) UILabel *tishiLab;
@property (nonatomic, strong) KVTimer *timer;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *backGroundView;
@property (nonatomic, strong) WMPlayer *ui_player;

@end

@implementation SheZhiPointController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ______WS();
    if (_imageData != nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        UIImage *image = [ NSKeyedUnarchiver unarchiveObjectWithData:_imageData];
        _imageView.image = image;
        [self.view addSubview:_imageView];
        
    }else {
        _ui_player = [[WMPlayer alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth + 1, kScreenHeight + 1) videoURLStr:videoPath];
        _ui_player.userInteractionEnabled = NO;
        [self.view addSubview:_ui_player];
        [_ui_player.player play];
    }

    _backGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _backGroundView.backgroundColor =RGB(49, 56, 93);
    _backGroundView.alpha = 0.9;
    _backGroundView.userInteractionEnabled = YES;
    [self.view addSubview:_backGroundView];
    
    _titleLab = [[UILabel alloc] init];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.text = @"View Price";
    _titleLab.textColor = RGB(27, 197, 174);
    _titleLab.font = [UIFont systemFontOfSize:15];
    [_backGroundView addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.top.equalTo(wSelf.view.mas_top).offset(30);
        make.height.offset(35);
        make.width.offset(200);
    }];
    
        
    _titleAbout = [[UILabel alloc] init];
    _titleAbout.textAlignment = NSTextAlignmentCenter;
    _titleAbout.text = @"Move the Point to set viewing price of this message";
    _titleAbout.lineBreakMode = NSLineBreakByTruncatingTail;
    _titleAbout.numberOfLines = 0;

    _titleAbout.textColor = [UIColor whiteColor];
    _titleAbout.font = [UIFont systemFontOfSize:13];
    [_backGroundView addSubview:_titleAbout];
    [_titleAbout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.top.equalTo(wSelf.titleLab.mas_top).offset(40);
        make.height.offset(50);
        make.width.offset(255);
    }];
    
    _timer = [[KVTimer alloc] init];
    _timer.delegate = self;
    [_timer setShowTimerLabel:YES];
    [_timer setInterval:KVIntervalHour];
    [_timer setKofString:@""];
    [_timer setMaxTime:161 minTime:0];
    [_backGroundView addSubview:_timer];
    [_timer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.titleAbout.mas_bottom).offset(100);
        make.width.height.offset(250);
        make.centerX.equalTo(wSelf.view);
    }];
    
    _tishiLab = [[UILabel alloc] init];
    _tishiLab.textAlignment = NSTextAlignmentCenter;
    _tishiLab.text = @"Lower cost = Higher open rate";
    _tishiLab.textColor = [UIColor whiteColor];
    _tishiLab.font = [UIFont systemFontOfSize:13];
    [_backGroundView addSubview:_tishiLab];
    [_tishiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.top.equalTo(wSelf.timer.mas_bottom).offset(30);
        make.height.offset(13);
        make.width.offset(200);
    }];
    

    
    BackAndNextView *bottomView = [[BackAndNextView alloc] init];
    [bottomView.backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView.nextButton addTarget:self action:@selector(nextController) forControlEvents:(UIControlEventTouchUpInside)];
    [_backGroundView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kScreenWidth);
        make.height.offset(40);
        make.bottom.equalTo(wSelf.view.mas_bottom).offset(-30);
    }];
}







- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];

}


- (void)nextController {

    ChooserUserController *chooseVC = [[ChooserUserController alloc] init];
    chooseVC.textStr = _textStr;
    chooseVC.priceStr = _timer.timeLabel.text;
    if (_imageData != nil) {
        chooseVC.imageData = _imageData;
    }
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:chooseVC animated:YES];
    
}


- (void)dealloc {
    NSLog(@"这个页面已经被注销");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"user"]);
}


@end
