//
//  LoginViewController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/10.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "LoginViewController.h"
#import "SetViewController.h"
#import "LogInController.h"
#import "CeshiViewController.h"
#import "SetAppController.h"
#import "KBTabbarController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <MediaPlayer/MediaPlayer.h>

#import "SDCycleScrollView.h"

@interface LoginViewController ()<SDCycleScrollViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong)UIImageView *logoView;
@property (nonatomic, strong)UIImageView *logoViewSmall;

@property (nonatomic, strong)UIButton *loginBtn;
@property (nonatomic, strong)UIButton *fbBtn;
@property (nonatomic, strong)UIButton *emailBtn;
@property (nonatomic, strong)UIImageView *faceImg;

@property (strong, nonatomic)  UIScrollView *scrollView;
@property (strong, nonatomic)  UIPageControl *pageControl;
@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) MPMoviePlayerController *player;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.array = @[@"Join nanppa\nwatch your favorite people.",
                   @"Record your personal video.",
                   @"Recommend friends\nand show yourself",
                   @"Join nanpaa\nwatch your favourite people"];
    [self initUI];
    [self initScrollView];
}

- (void)initScrollView {
    ______WS();
    UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,255, kScreenWidth, 60)];
    bgScrollView.contentSize = CGSizeMake(kScreenWidth * 4, kScreenHeight);
    bgScrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    bgScrollView.bounces = YES;
    bgScrollView.scrollEnabled = NO;
    bgScrollView.alwaysBounceHorizontal = YES;
    bgScrollView.alwaysBounceVertical = NO;
    bgScrollView.pagingEnabled = YES;
    bgScrollView.delegate = self;
    bgScrollView.tag = 99;
    [self.view addSubview:bgScrollView];
    
    
    
    for (int i = 0; i < 4; i++) {
        UIScrollView *smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0 + kScreenWidth * i, 0, kScreenWidth, 60)];
        smallScrollView.minimumZoomScale = 0.5;
        smallScrollView.maximumZoomScale = 2;
        [bgScrollView addSubview:smallScrollView];
        smallScrollView.delegate = self;
        smallScrollView.tag = i + 1000;
        
        UITextView *imageView = [[UITextView alloc] initWithFrame:CGRectMake(35, 0, kScreenWidth - 70, 60)];
        imageView.textAlignment = NSTextAlignmentCenter;
        imageView.backgroundColor = [UIColor clearColor];
        imageView.userInteractionEnabled = NO;
        imageView.font = [UIFont systemFontOfSize:20];
        imageView.textColor = [UIColor whiteColor];
        if (i == 0) {
            imageView.text = _array[2];
        } else {
            imageView.text = _array[i];
        }
        [smallScrollView addSubview:imageView];
    }
    
    _pageControl = [[UIPageControl alloc] initWithFrame:(CGRectMake(0, 250, kScreenWidth, 20))];
    _pageControl.numberOfPages = 3;
    _pageControl.alpha = 0.4;
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    // 添加方法
    [_pageControl addTarget:self action:@selector(changeValue:) forControlEvents:(UIControlEventValueChanged)];
    
    [self.view addSubview:_pageControl];
     // NSTimer
    _timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];

    _logoViewSmall = [[UIImageView alloc] init];
    _logoViewSmall.image = [UIImage imageNamed:@"NANPAA-1"];
    [self.view addSubview:_logoViewSmall];
    [_logoViewSmall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(112);
        make.top.equalTo(wSelf.view.mas_top).offset(203);
        make.right.equalTo(wSelf.view.mas_right).offset(-112);
        make.bottom.equalTo(bgScrollView.mas_top).offset(-16);
    }];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //  取出scrollView宽度
    CGFloat width = scrollView.frame.size.width;
    //  取出偏移量
    CGFloat x = scrollView.contentOffset.x;
    if (x < 0) {
        //  说明滑动到第一张假图
        //  需要偏移到最后一张图
        [scrollView setContentOffset:CGPointMake(width * 2, 0) animated:NO];
    }
    if (x > width * 3) {
        //  说明滑动到最后一个图
        //  需要偏移到第一张图
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}

// 结束减速 完全停止后， 改变pageControl 的page, 必须是手动拖动才会执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 获取偏移量
    CGFloat x = scrollView.contentOffset.x;
    CGFloat width = scrollView.frame.size.width;
    NSInteger page = x / width;
    if (page == 0) {
        _pageControl.currentPage = 2;
        
    } else {
        _pageControl.currentPage = page -  1;
    }
}


#pragma mark pageControl 方法
- (void)changeValue:(UIPageControl *)pageControl
{
    UIScrollView *bgScrollView = (UIScrollView *)[self.view viewWithTag:99];
    // 获取当前的 page
    NSInteger currentPage = pageControl.currentPage;
    CGFloat x = (currentPage + 1 ) * bgScrollView.frame.size.width;
    // 设置偏移量
    [bgScrollView setContentOffset:(CGPointMake(x, 0)) animated:YES];
    
}

//#pragma mark-- 自动轮播
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获取偏移量
    CGFloat x = scrollView.contentOffset.x;
    CGFloat width = scrollView.frame.size.width;
    NSInteger page = x / width;
    if (page == 0) {
        
        _pageControl.currentPage = 2;
    } else
    {
        _pageControl.currentPage = page - 1;
    }
}


- (void)timer:(NSTimer *)timer
{
    UIScrollView *bgScrollView = (UIScrollView *)[self.view viewWithTag:99];
    
    // 改变contentOffSet
    // 如果需要重新定位 先定位再动画， 否则直接动画
    CGFloat x = bgScrollView.contentOffset.x;
    CGFloat width = bgScrollView.frame.size.width;
    
    if (width + x >= bgScrollView.contentSize.width) {
        // 先定位
        [bgScrollView setContentOffset:(CGPointMake(0, 0)) animated:NO];
        // 再动画
        [bgScrollView setContentOffset:(CGPointMake(width, 0)) animated:YES];
    } else{
        [bgScrollView setContentOffset:(CGPointMake(x + width, 0)) animated:YES];
    }
}





- (void)initUI {
    ______WS();
    _logoView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds ];
    _logoView.backgroundColor = [UIColor redColor];
    _logoView.image = [UIImage imageNamed:@"bigpic"];
    _logoView.hidden = YES;
    [self.view addSubview:_logoView];

    
    NSString *moviePath=[[NSBundle mainBundle]pathForResource:@"startMV" ofType:@"mp4"];
    self.player = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL fileURLWithPath:moviePath]];
    [self.view addSubview:self.player.view];
    self.player.view.frame = CGRectMake(0, 0, kScreenWidth,kScreenHeight);
    self.player.movieSourceType = MPMovieSourceTypeFile;// 播放本地视频时需要这句
    self.player.controlStyle = MPMovieControlStyleNone;// 不需要进度条
    self.player.shouldAutoplay = YES;// 是否自动播放（默认为YES）
    self.player.scalingMode = MPMovieScalingModeAspectFill;
    self.player.repeatMode = MPMovieRepeatModeOne;
    self.player.fullscreen = YES;
    [self.player play];//可以不加这句

    _emailBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_emailBtn setTitle:@"Sign up with Email" forState:(UIControlStateNormal)];
    [_emailBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_emailBtn addTarget:self action:@selector(signEmaAct) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_emailBtn];
    [_emailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.logoView);;
        make.width.offset(kScreenWidth / 3 + 100);
        make.bottom.equalTo(wSelf.logoView.mas_bottom).offset(-24);
        make.height.offset(30);
    }];

    
    _fbBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _fbBtn.alpha = 0.7;
    _fbBtn.layer.masksToBounds = YES;
    _fbBtn.layer.cornerRadius = 10;
    [_fbBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
    _fbBtn.layer.borderWidth = 1;
    [_fbBtn setTitle:@"Log In with Facebook" forState:(UIControlStateNormal)];
    [_fbBtn addTarget:self action:@selector(fbLogin) forControlEvents:(UIControlEventTouchUpInside)];
    _fbBtn.backgroundColor = RGB(179, 45, 83);
    [self.view addSubview:_fbBtn];
    [_fbBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(15);
        make.right.equalTo(wSelf.view.mas_right).offset(-15);
        make.bottom.equalTo(wSelf.emailBtn.mas_top).offset(-16);
        make.height.offset(50);
    }];
    

    _faceImg = [[UIImageView alloc] init];
    _faceImg.image = [UIImage imageNamed:@"facebok"];
    _faceImg.userInteractionEnabled = YES;
    [_fbBtn addSubview:_faceImg];
    [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.fbBtn);
        make.left.equalTo(wSelf.fbBtn).offset(40);
        make.width.height.offset(25);
    }];
    
    
    _loginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_loginBtn setTitle:@"Log In" forState:(UIControlStateNormal)];
    _loginBtn.alpha = 0.7;
    _loginBtn.backgroundColor = RGB(179, 45, 83);
    [self.view addSubview:_loginBtn];
    [_loginBtn addTarget:self action:@selector(loginInAct) forControlEvents:(UIControlEventTouchUpInside)];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(15);
        make.right.equalTo(wSelf.view.mas_right).offset(-15);
        make.bottom.equalTo(wSelf.fbBtn.mas_top).offset(-20);
        make.height.equalTo(wSelf.fbBtn);
    }];
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = 10;
    [_loginBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
    _loginBtn.layer.borderWidth = 1;
    
}


#pragma mark --- 自定义方法
- (void)signEmaAct{
    SetViewController *setVC = [[SetViewController alloc] init];
    [self.navigationController pushViewController:setVC animated:YES];
}

- (void)loginInAct {
    LogInController *loginVC = [[LogInController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}




-(void)fbLogin {
    [ShareSDK getUserInfo:SSDKPlatformTypeFacebook onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             NSLog(@"%lu",(unsigned long)user.gender);
             //1。创建管理者对象
             AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
             manager.requestSerializer = [AFJSONRequestSerializer serializer];
             //2.上传文件
             NSString *gender = [NSString stringWithFormat:@"%lu",(unsigned long)user.gender];
             NSString *thirdPartAccount = user.uid;
             NSString *username = user.nickname;

             NSString *Url = [NSString stringWithFormat:@"%@%@",URLdomain,ThirdLoginUrl];
             [manager POST:Url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                 //上传文件参数
                 
                 NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:user.icon]];
//                 UIImage *image = [UIImage imageNamed:@"back"];
//                 NSData *imageData = UIImagePNGRepresentation(image);
                 //这个就是参数
                 [formData appendPartWithFileData:data name:@"avatar" fileName:@"headIcon.png" mimeType:@"image/png"];
                 [formData appendPartWithFormData:[gender dataUsingEncoding:NSUTF8StringEncoding]
                                             name:@"gender"];
                 [formData appendPartWithFormData:[username dataUsingEncoding:NSUTF8StringEncoding]
                                             name:@"nickname"];
                 [formData appendPartWithFormData:[thirdPartAccount dataUsingEncoding:NSUTF8StringEncoding]
                                             name:@"thirdPartAccount"];
                 [formData appendPartWithFormData:[@".png" dataUsingEncoding:NSUTF8StringEncoding]
                                             name:@"type"];
             } progress:^(NSProgress * _Nonnull uploadProgress) {
                 //打印下上传进度
                 NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
             } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 //请求成功
                 NSLog(@"请求成功：%@",responseObject);
                 NSDictionary *dic = responseObject[@"rspObject"];
                 [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"user"];
                 KBTabbarController *mainVC = [[KBTabbarController alloc] init];
                 [self.navigationController pushViewController:mainVC animated:YES];
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 //请求失败
                 NSLog(@"请求失败：%@",error);
             }];
         }
         else
         {
             NSLog(@"%@",error);
         }
     }];
}



- (void)viewDidDisappear:(BOOL)animated {

    [self.player stop];  
}

- (void)dealloc{
    [_timer invalidate];
    _timer = nil;
}

#pragma mark --- viewAction
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
    [_timer setFireDate:[NSDate distantPast]];
    [_player play];
}


@end
