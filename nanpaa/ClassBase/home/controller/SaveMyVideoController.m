
//
//  SaveMyVideoController.m
//  nanpaa
//
//  Created by bianKerMacBook on 17/1/19.
//  Copyright © 2017年 bianKerMacBookDJH. All rights reserved.
//

#import "SaveMyVideoController.h"
#import "WMPlayer.h"
#import "MeViewController.h"

@interface SaveMyVideoController ()<MBProgressHUDDelegate>
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UIView *backGoundView;
@property (nonatomic, strong) WMPlayer *ui_player;
@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation SaveMyVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void)initUI{
    
    ______WS();
    _ui_player = [[WMPlayer alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth + 1, kScreenHeight + 1) videoURLStr:videoPath];
    _ui_player.userInteractionEnabled = NO;
    [self.view addSubview:_ui_player];
    [self addNotification];
    
    _backGoundView = [[UIView alloc] init];
    _backGoundView.backgroundColor = RGB(49, 56, 93);
    _backGoundView.alpha = 0.5;
    [self.view addSubview:_backGoundView];
    [_backGoundView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(wSelf.view).offset(0);
        make.right.equalTo(wSelf.view.mas_right).offset(0);
        make.height.offset(70);
        make.bottom.equalTo(wSelf.view.mas_bottom).offset(0);
    }];
    
    _cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
    [_cancelBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.backGoundView addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view.mas_left).offset(16);
        make.width.height.offset(24);
        make.centerY.equalTo(wSelf.backGoundView);
    }];
    
    
    _saveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _saveBtn.layer.masksToBounds = YES;
    _saveBtn.layer.cornerRadius = 8;
    _saveBtn.layer.borderWidth = 1;
    [_saveBtn.layer setBorderColor:RGB(223, 63, 101).CGColor];
    [_saveBtn setTitleColor:RGB(223, 63, 101) forState:(UIControlStateNormal)];
    [_saveBtn setTitle:@"Save" forState:(UIControlStateNormal)];
    [_saveBtn addTarget:self action:@selector(saveVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saveBtn];
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.view.mas_right).offset(-29);
        make.width.offset(66);
        make.height.offset(26);
        make.centerY.equalTo(wSelf.cancelBtn);
        
    }];
    

}


- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)saveVideo{
    self.saveBtn.enabled = NO;
    _HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.mode = MBProgressHUDModeIndeterminate;
    //    _HUD.activityIndicatorColor =
    _HUD.color = [UIColor blackColor];
    _HUD.delegate =self;
    [_HUD show:YES];
    NSDictionary *userData = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    //1。创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *Url = [NSString stringWithFormat:@"%@%@",URLdomain,UpVideoURL];
    [manager POST:Url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传文件参数
        NSData *data = [NSData dataWithContentsOfFile:videoPath];
        
        //这个就是参数
        [formData appendPartWithFileData:data name:@"indexVideo" fileName:@"myVideo.mp4" mimeType:@"video/mp4"];
        
        [formData appendPartWithFormData:[userData[@"token"] dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"token"];
        [formData appendPartWithFormData:[@".mp4" dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"type"];
        [formData appendPartWithFormData:[userData[@"userid"] dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"userid"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        [[DJHManager shareManager] toastManager:@"Saved successfully" superView:windowKey];
        self.saveBtn.enabled = YES;
        [_HUD hideAnimated:YES];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1]
                                              animated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.saveBtn.enabled = NO;
        //请求失败  处理
        NSLog(@"请求失败：%@",error);
        [_HUD hideAnimated:YES];

    }];
}


-(void)addNotification{
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.ui_player.player.currentItem];
    
}

-(void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成.");
//     播放完成后重复播放
//     跳到最新的时间点开始播放
    [_ui_player.player seekToTime:CMTimeMake(1, 1)];

    [_ui_player.player play];
}


- (void)viewWillAppear:(BOOL)animated{
    [self.ui_player.player play];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.ui_player.player pause];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:AVPlayerItemDidPlayToEndTimeNotification];
    self.ui_player.player = nil;
    self.ui_player.playerLayer = nil;
    NSLog(@"我移除了AV了");
}


@end
