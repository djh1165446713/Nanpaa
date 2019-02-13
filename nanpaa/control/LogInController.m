//
//  LogInController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/20.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "LogInController.h"
#import "loginView.h"
#import "KBTabbarController.h"
#import "RACSignal.h"
#import "RACSignal+Operations.h"
#import "RACTuple.h"
#import "UITextField+RACSignalSupport.h"
#import "SendUerViewController.h"

@interface LogInController ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *leftNavBtn;
@property (nonatomic, strong) loginView *emailView;
@property (nonatomic, strong) loginView *passView;
@property (nonatomic, strong) UIImageView *bgImg;
@property (nonatomic, strong) UILabel *titleLabel;;
@property (nonatomic, strong) UIButton *subButton;
@property (nonatomic,strong) UIActivityIndicatorView *appendActivity;  /**< 附加菊花图 */

@end

@implementation LogInController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}

- (void)setUI {
    ______WS();
    _bgImg = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds ];
    _bgImg.image = [UIImage imageNamed:@"bigpic"];
    [self.view addSubview:_bgImg];
    // 导航栏
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(0);
        make.width.offset(kScreenWidth);
        make.top.equalTo(wSelf.view).offset(0);
        make.height.offset(64);
    }];
    
    
    // UI
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:20];
    _titleLabel.text = @"Log In";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.bgView);
        make.top.equalTo(wSelf.bgView.mas_top).offset(34);
        make.width.offset(100);
        make.height.offset(34);
    }];
    
    
    _leftNavBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_leftNavBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
    [_leftNavBtn  addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_bgView addSubview:_leftNavBtn];
    [_leftNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.bgView).offset(20);
        make.centerY.equalTo(wSelf.titleLabel);
        make.width.offset(12);
        make.height.offset(24);
    }];
    
    _emailView = [[loginView alloc] init];
    _emailView.userLabel.text = @"Email";
    [self.view addSubview:_emailView];
    [self.emailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(30);
        make.right.equalTo(wSelf.view.mas_right).offset(-30);
        make.top.equalTo(wSelf.bgView.mas_bottom).offset(120);
        make.height.offset(60);
    }];
    
    _passView = [[loginView alloc] init];
    _passView.frame = CGRectMake(30, 235, 300, 55);
    _passView.userLabel.text = @"Password";
    //    _passView.userText.secureTextEntry = YES;
    [self.view addSubview:_passView];
    [self.passView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(30);
        make.right.equalTo(wSelf.view.mas_right).offset(-30);
        make.top.equalTo(wSelf.emailView.mas_bottom).offset(10);
        make.height.offset(60);
        
    }];
    
    _subButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _subButton.frame = CGRectMake(30, 430, kScreenWidth - 60, 45);
    _subButton.backgroundColor = RGB(179, 45, 83);
    _subButton.layer.masksToBounds = YES;
    _subButton.layer.cornerRadius = 20;
    [_subButton setTitle:@"Log In" forState:(UIControlStateNormal)];
    [_subButton addTarget:self action:@selector(subAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_subButton];
    [self.subButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(30);
        make.right.equalTo(wSelf.view.mas_right).offset(-30);
        make.top.equalTo(wSelf.passView.mas_bottom).offset(100);
        make.height.offset(45);
    }];
    
    self.subButton.enabled = NO;
    RACSignal *signal = [RACSignal combineLatest:@[self.emailView.userText.rac_textSignal,self.passView.userText.rac_textSignal]];
    [signal subscribeNext:^(RACTuple *x) {
        NSString *e = x.first;
        NSString *p = x.second;
        if (e.length > 0 && p.length != 0) {
            wSelf.subButton.enabled = YES;
            self.subButton.backgroundColor = RGB(179, 45, 83);
        }
        else{
            self.subButton.backgroundColor = RGB(122, 122, 122);
        }
    }];
}


#pragma mark --- 自定义方法
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)subAction {
    ______WS();
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.color = [UIColor blackColor];
    [activityIndicator startAnimating];
    [activityIndicator setHidesWhenStopped:YES];
    self.subButton.enabled = NO;
    self.appendActivity = activityIndicator;
    [self.subButton addSubview:activityIndicator];
    
    [activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.subButton.mas_right).offset(- wSelf.subButton.size.width / 4 + wSelf.subButton.size.height / 4);
        make.centerY.equalTo(wSelf.subButton);
        make.height.width.offset(wSelf.subButton.size.height / 2);
    }];
    
    NSDictionary  *par = @{@"email":_emailView.userText.text,
                           @"password":_passView.userText.text};
    [[DJHttpApi shareInstance] POST:LoginUrl dict:par succeed:^(id data) {
        if ([[NSString stringWithFormat:@"%@",data[@"rspCode" ]] isEqualToString:@"10000"]) {
            if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"sendUser_success"] isEqualToString:@"yes"]){
                NSDictionary *dic = data[@"rspObject"];
                [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"user"];
                SendUerViewController *userVC = [[SendUerViewController alloc] init];
                [wSelf.navigationController pushViewController:userVC animated:YES];
                
            }else{
                wSelf.subButton.enabled = YES;
                NSDictionary *dic = data[@"rspObject"];
                [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"user"];
                KBTabbarController *mainVC = [[KBTabbarController alloc] init];
                wSelf.view.window.rootViewController = mainVC;
                //                    [self.navigationController pushViewController:mainVC animated:YES];
            }
        }
        else {
            [[DJHManager shareManager] toastManager:@"Request timeout, try again later" superView:wSelf.view];
            [activityIndicator removeFromSuperview];
            self.subButton.enabled = YES;
        }
        
    } failure:^(NSError *error) {
        NSLog(@"请求错误");
        [[DJHManager shareManager] toastManager:@"Request timeout, try again later" superView:wSelf.view];
        self.subButton.enabled = YES;
    }];
}


- (void)dealloc{
    NSLog(@"%@ : 销毁了",self);
}


@end

