//
//  SetViewController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/11.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "SetViewController.h"
#import "loginView.h"
#import "GenderView.h"
#import "KBTabbarController.h"
#import "PictrueController.h"
#import "RACSignal.h"
#import "RACSignal+Operations.h"
#import "UITextField+RACSignalSupport.h"
#import "RACTuple.h"
#import "IQKeyboardManager.h"
#import "FWandYSView.h"
#import "NSObject+RACPropertySubscribing.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

#import "UIView+Toast.h"
#import <QuartzCore/QuartzCore.h>

#import "NanpaaAboutController.h"

@interface SetViewController ()<UITextFieldDelegate> {

}
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *leftNavBtn;
@property (nonatomic, strong) loginView *emailView;
@property (nonatomic, strong) loginView *nickName;
@property (nonatomic, strong) loginView *passView;
@property (nonatomic, strong) loginView *refereeId;
@property (nonatomic, strong) UIButton *subButton;
@property (nonatomic, strong) GenderView *manView;
@property (nonatomic, strong) GenderView *womenView;
@property (nonatomic, strong) UIButton *fwBtn;
@property (nonatomic, strong) UIButton *ysBtn;
@property (nonatomic, strong) UIImageView *bgImg;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSString *genderStr;
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Sign Up";
    [self initUI];
    
}


- (void) initUI {

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

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.text = @"Sign Up";
    _titleLabel.font = [UIFont systemFontOfSize:20];
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
        make.left.equalTo(wSelf.bgView).offset(15);
        make.centerY.equalTo(wSelf.titleLabel);
        make.width.offset(12);
        make.height.offset(24);
    }];
    
    _emailView = [[loginView alloc] init];
    _emailView.userLabel.text = @"Email";
    _emailView.userText.tag = 103;
    _emailView.userText.delegate = self;
    [self.view addSubview:_emailView];
    [_emailView.userText addTarget:self action:@selector(textFileChangeVuale:) forControlEvents:UIControlEventEditingChanged];
    [self.emailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(30);
        make.right.equalTo(wSelf.view.mas_right).offset(-30);
        make.top.equalTo(wSelf.bgView.mas_bottom).offset(70);
        make.height.offset(60);
    }];
    
    
    _nickName = [[loginView alloc] init];
    _nickName.frame = CGRectMake(30, 160, 300, 55);
    _nickName.userLabel.text = @"Nick Name";
    _nickName.userText.tag = 102;
    [_nickName.userText addTarget:self action:@selector(textFileChangeVuale:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_nickName];
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(30);
        make.right.equalTo(wSelf.view.mas_right).offset(-30);
        make.top.equalTo(wSelf.emailView.mas_bottom).offset(10);
        make.height.offset(60);

    }];

    _passView = [[loginView alloc] init];
    _passView.frame = CGRectMake(30, 235, 300, 55);
    _passView.userText.tag = 101;
    _passView.userLabel.text = @"Password";
    [_passView.userText addTarget:self action:@selector(textFileChangeVuale:) forControlEvents:UIControlEventEditingChanged];
//    _passView.userText.secureTextEntry = YES;
    [self.view addSubview:_passView];
    [self.passView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(30);
        make.right.equalTo(wSelf.view.mas_right).offset(-30);
        make.top.equalTo(wSelf.nickName.mas_bottom).offset(10);
        make.height.offset(60);

    }];
//
//#warning 性别选择
//    
    _manView = [[GenderView alloc] init];
    [_manView.gdBuuton addTarget:self action:@selector(tapAction1) forControlEvents:(UIControlEventTouchUpInside)];
    _manView.gdLabel.text = @"Male";
    [self.view addSubview:_manView];
    [self.manView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(90);
        make.width.offset(80);
        make.top.equalTo(wSelf.passView.mas_bottom).offset(10);
        make.height.offset(20);
    }];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction1)];
    [_manView addGestureRecognizer:tap1];
    
    
    _womenView = [[GenderView alloc] init];
    [_womenView.gdBuuton addTarget:self action:@selector(tapAction2) forControlEvents:(UIControlEventTouchUpInside)];
    _womenView.gdLabel.text = @"Female";
    [self.view addSubview:_womenView];
    [self.womenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.view.mas_right).offset(-90);
        make.centerY.equalTo(wSelf.manView);
        make.width.offset(80);
        make.height.offset(20);
    }];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction2)];
    [_womenView addGestureRecognizer:tap2];
    
    
    _refereeId = [[loginView alloc] init];
    _refereeId.userLabel.text = @"Referee ID";
    [self.view addSubview:_refereeId];
    [self.refereeId mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(30);
        make.right.equalTo(wSelf.view.mas_right).offset(-30);
        make.top.equalTo(wSelf.manView.mas_bottom).offset(30);
        make.height.offset(60);
    }];


    _subButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _subButton.frame = CGRectMake(30, 430, kScreenWidth - 60, 45);
    _subButton.backgroundColor = RGB(122, 122, 122);
    _subButton.layer.masksToBounds = YES;
    _subButton.layer.cornerRadius = 10;
    [_subButton setTitle:@"Sign Up" forState:(UIControlStateNormal)];
    [_subButton addTarget:self action:@selector(subAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_subButton];
    [self.subButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(20);
        make.right.equalTo(wSelf.view.mas_right).offset(-20);
        make.top.equalTo(wSelf.refereeId.mas_bottom).offset(20);
        make.height.offset(40);
    }];

    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fwAction)];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ysAction)];
    FWandYSView *fsView = [[FWandYSView alloc] init];
    [fsView.fwLabel addGestureRecognizer:tap3];
    [fsView.ysLabel addGestureRecognizer:tap4];
    [self.view addSubview:fsView];
    [fsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.top.equalTo(wSelf.subButton.mas_bottom).offset(15);
        make.width.offset(270);
        make.height.offset(28);
    }];
    
    self.subButton.enabled = NO;
    RACSignal *signal = [RACSignal combineLatest:@[self.emailView.userText.rac_textSignal,self.nickName.userText.rac_textSignal,self.passView.userText.rac_textSignal]];
    [signal subscribeNext:^(RACTuple *x) {
        NSString *e = x.first;
        NSString *n = x.second;
        NSString *p = x.third;
  
        if (e.length > 0 && n.length != 0 && p.length != 0 && p.length > 3 && wSelf.genderStr != nil) {
            wSelf.subButton.backgroundColor = RGB(179, 45, 83);
        }else {
            wSelf.subButton.backgroundColor = RGB(122, 122, 122);
        }
        wSelf.subButton.enabled = e.length > 0 && n.length != 0 && p.length != 0;
    }];
    
}



#pragma mark --- viewAction
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;  //控制点击背景是否收起键盘

}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}






- (void)fwAction {
 
    NanpaaAboutController *vc = [[NanpaaAboutController alloc] init];
    vc.strDj = UserAgreementUrl;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)ysAction {
    NanpaaAboutController *vc = [[NanpaaAboutController alloc] init];
    vc.strDj = UserHelpMentUrl;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)textFileChangeVuale:(UITextField *)textFile{
    if (textFile.tag == 101) {
        if (textFile.text.length > 16) {
           textFile.text = [textFile.text substringToIndex:16];
        }
    }
    
   if(textFile.tag == 103){
        if (textFile.text.length > 20) {
           textFile.text = [textFile.text substringToIndex:20];
        }
    }
    
    if (textFile.tag == 102) {
        if (textFile.text.length > 30) {
          textFile.text = [textFile.text substringToIndex:30];
        }
    }
}


#pragma mark --- 自定义方法

- (void)tapAction2 {
    [self.view makeToast:@"Gender can not be modified"];
    [_manView.gdBuuton setBackgroundImage:[UIImage imageNamed:@"gendeNorm"] forState:(UIControlStateNormal)];
    [_womenView.gdBuuton setBackgroundImage:[UIImage imageNamed:@"gendeSelect"] forState:(UIControlStateNormal)];

    _genderStr = @"1";
    self.subButton.backgroundColor = RGB(179, 45, 83);
}


- (void)tapAction1 {
    [self.view makeToast:@"Gender can not be modified"];
    [_womenView.gdBuuton setBackgroundImage:[UIImage imageNamed:@"gendeNorm"] forState:(UIControlStateNormal)];
    [_manView.gdBuuton setBackgroundImage:[UIImage imageNamed:@"gendeSelect"] forState:(UIControlStateNormal)];
    _genderStr = @"0";
    self.subButton.backgroundColor = RGB(179, 45, 83);
}


- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)subAction {
    ______WS();
    DJHttpApi *httpRequest = [DJHttpApi shareInstance];
    NSDictionary *par = @{@"email":_emailView.userText.text,
                          @"gender":_genderStr,
                          @"mcc":[[NSUserDefaults standardUserDefaults] objectForKey:@"mcc"],
                          @"password":_passView.userText.text,
                          @"nickname":_nickName.userText.text,
                          @"recommend":_refereeId.userText.text};
    [httpRequest POST:RegistUrl dict:par succeed:^(id data) {
        if ([[NSString stringWithFormat:@"%@",data[@"rspCode" ]] isEqualToString:@"10000"]) {
            NSDictionary *userData = data[@"rspObject"];
            [[NSUserDefaults standardUserDefaults] setObject:userData forKey:@"user"];
            [[DJHManager shareManager] toastManager:@"registration success" superView:wSelf.view];
            PictrueController *picVC = [[PictrueController alloc] init];
            [self.navigationController pushViewController:picVC animated:YES];

        }else{
            NSLog(@"注册失败");
            [[DJHManager shareManager] toastManager:[NSString stringWithFormat:@"%@",data[@"rspMsg"]] superView:wSelf.view];
        }  
        // 注册失败处理
    } failure:^(NSError *error) {
    }];
}

@end
