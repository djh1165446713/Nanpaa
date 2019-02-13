//
//  HisViewController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/9.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "HisViewController.h"
#import "OtherUserView.h"
#import "SendGandPController.h"
#import <MessageUI/MessageUI.h>
#import "CeshiViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "ShareHelpManage.h"
#import "MesonView.h"


@interface HisViewController ()<UIActionSheetDelegate,UIAlertViewDelegate,MFMailComposeViewControllerDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *bgNacView;
@property (nonatomic, strong) UIButton *leftNavBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *rightNavBtn;
@property (nonatomic, strong) UIButton *headImgBtn;

@property (nonatomic, strong) UIButton *gzBtn;
@property (nonatomic, strong) UIButton *fsBtn;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIButton *invitaBtn;
@property (nonatomic, strong) UIButton *recommFrieds;
@property (nonatomic, strong) UIImageView *btnBackImg;
@property (nonatomic, strong) UIButton *giftPointBtn;
@property (nonatomic, strong) UILabel *userNameLab;

@property (nonatomic, strong) NSDictionary *peopleDic;

@property (nonatomic, assign) NSNumber* isFollow;
@property (nonatomic, strong) MesonView *sonView;

@property (nonatomic, strong) UIImage *downImage;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) OtherUserView *viewOther;

@end

@implementation HisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _downImage = [UIImage new];
    [self loadData];
    [self initUI];

}


/*
    或者在跳转这个页面之前 将别人的个人信息存储并传过来
 */
- (void)loadData {
    if (self.model != nil) {
        self.userid = self.model.userid;
    }
    ______WS();
    NSDictionary *dic = userMessage;
    NSDictionary *par = @{@"targetId":self.userid,
                          @"token":dic[@"token"],
                          @"userid":dic[@"userid"]};
    
    [[DJHttpApi shareInstance] POST:OtherUserUrl dict:par succeed:^(id data) {
        wSelf.peopleDic = data[@"rspObject"];
        wSelf.isFollow = wSelf.peopleDic[@"isFollowing"];

        
        if ([wSelf.peopleDic[@"isFollower"] integerValue] == 0) {
            wSelf.viewOther.line2View.hidden = NO;
            wSelf.viewOther.giftAndPointsBtn.hidden = NO;
        }else{
            wSelf.viewOther.giftPointsBtn.hidden = NO;
            wSelf.viewOther.sendMessageBtn.hidden = NO;
            wSelf.viewOther.lineView.hidden = NO;
        }
        
        if ([wSelf.peopleDic[@"isFollowing"] integerValue] == 1) {
            [wSelf.viewOther.friendBtn setTitle:@"Following" forState:(UIControlStateNormal)];
            wSelf.viewOther.friendBtn.backgroundColor = RGB(212, 39, 82);
            
        }else{
            [wSelf.viewOther.friendBtn setTitle:@"+Follow" forState:(UIControlStateNormal)];
            wSelf.viewOther.friendBtn.backgroundColor = [UIColor whiteColor];
            [wSelf.viewOther.friendBtn setTitleColor:RGB(212, 39, 82) forState:(UIControlStateNormal)];
            wSelf.viewOther.friendBtn.layer.borderWidth = 1;
            [wSelf.viewOther.friendBtn.layer setBorderColor:RGB(212, 39, 82).CGColor];
        }
        
        [wSelf.bgNacView sd_setImageWithURL:[NSURL URLWithString:wSelf.peopleDic[@"backgroundUrl"]]  placeholderImage:[UIImage imageNamed:@"normorBGIMG"] options:(SDWebImageRefreshCached)];
        [wSelf.viewOther.headImgBtn sd_setImageWithURL:[NSURL URLWithString:wSelf.peopleDic[@"avatarUrl"]] forState:(UIControlStateNormal) placeholderImage:[UIImage imageNamed:@"placeholderImg"] options:(SDWebImageRefreshCached)];
        wSelf.viewOther.userNameLab.text = [NSString stringWithFormat:@"%@",wSelf.peopleDic[@"nickname"]];
        wSelf.viewOther.incomeNum.text = [NSString stringWithFormat:@"%@",wSelf.peopleDic[@"followingNum"]];
        wSelf.viewOther.pointNum.text = [NSString stringWithFormat:@"%@",wSelf.peopleDic[@"followerNum"]];
        wSelf.sonView.textView.text = [NSString stringWithFormat:@"%@",wSelf.peopleDic[@"introduce"]];

    } failure:^(NSError *error) {
        
    }];
}


- (void)initUI {
    ______WS();
    _bgNacView = [[UIImageView alloc] init];
    _bgNacView.exclusiveTouch = YES;
    _bgNacView.image = [UIImage imageNamed:@"normorBGIMG"];
    _bgNacView.userInteractionEnabled = YES;
    _bgNacView.contentMode = UIViewContentModeScaleAspectFill;
    _bgNacView.clipsToBounds = YES;
    [self.view addSubview:_bgNacView];
    [_bgNacView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(0);
        make.width.offset(kScreenWidth);
        make.top.equalTo(wSelf.view).offset(0);
        make.height.offset(kScreenHeight);
    }];
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.userInteractionEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.contentOffset = CGPointMake(0, kScreenHeight);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight * 2);
    _scrollView.bounces = YES;
    [self.view addSubview:_scrollView];

    _lineView = [[UIView alloc] init];
    [self.view addSubview:_lineView];
    _lineView.backgroundColor = [UIColor clearColor];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.view).offset(0);
        make.centerX.equalTo(wSelf.view);
        make.height.offset(64);
        make.width.offset(kScreenWidth);
    }];
    
    
    _leftNavBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_leftNavBtn setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
    [_leftNavBtn  addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_lineView addSubview:_leftNavBtn];
    [_leftNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.bgNacView).offset(0);
        make.top.equalTo(wSelf.bgNacView).offset(25);
        make.width.offset(50);
        make.height.offset(24);
    }];
    
    
    _rightNavBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_rightNavBtn setImage:[UIImage imageNamed:@"shareYuan"] forState:(UIControlStateNormal)];
    [_rightNavBtn  addTarget:self action:@selector(shezhiAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_lineView addSubview:_rightNavBtn];
    [_rightNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.bgNacView.mas_right).offset(0);
        make.top.equalTo(wSelf.bgNacView).offset(25);
        make.width.offset(50);
        make.height.offset(24);
    }];
    

    
    UITapGestureRecognizer *shareImgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(invitaAciton)];
    self.viewOther = [[OtherUserView alloc] init];
    self.viewOther.headImgBtn.userInteractionEnabled = NO;
    [self.viewOther.giftPointsBtn addTarget:self action:@selector(sendGiftAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.viewOther.sendMessageBtn addTarget:self action:@selector(sendMessageAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.viewOther.giftAndPointsBtn addTarget:self action:@selector(sendGiftAction) forControlEvents:(UIControlEventTouchUpInside)];

    [_viewOther.shareIcon addGestureRecognizer:shareImgTap];
    [_viewOther.friendBtn addTarget:self action:@selector(initaBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.scrollView addSubview:self.viewOther];
    [self.viewOther mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.scrollView.mas_top).offset(58 + kScreenHeight);
        make.centerX.equalTo(wSelf.scrollView);
        make.height.offset(260);
        make.width.offset(350);
    }];
    
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    _sonView = [[MesonView alloc] init];
    _sonView.setImg.hidden = YES;
    _sonView.userInteractionEnabled = YES;
    //    [_sonView.view addGestureRecognizer:tap];
    _sonView.layer.masksToBounds = YES;
    _sonView.layer.cornerRadius = 8;
    [self.scrollView addSubview:_sonView];
    _sonView.textView.editable = NO;
    [_sonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.viewOther.mas_bottom).offset(10);
        make.left.equalTo(wSelf.viewOther.mas_left).offset(0);
        make.right.equalTo(wSelf.viewOther.mas_right).offset(0);
        make.height.offset(250);
    }];
    
}



#pragma mark --- 自定义方法

- (void)invitaAciton {
    [[ShareHelpManage shareInstance] shareSDKarray:nil shareText:shareInput shareURLString:shareURL shareTitle:shareTitText];
}

- (void)shezhiAction {
    
    UIActionSheet *sheet = [[UIActionSheet alloc]
                            initWithTitle:nil
                            delegate:self
                            cancelButtonTitle:@"cancel"
                            destructiveButtonTitle:nil
                            otherButtonTitles:@"Report",@"Add BlackList", nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [sheet showInView:self.view];
    
}


- (void)initaBtnAction {
    ______WS();
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSDictionary *parDic = @{@"targetId":_model.userid,
                             @"token":userDic[@"token"],
                             @"userid":userDic[@"userid"]};
    if ([_isFollow integerValue] == 0) {
        [[DJHttpApi shareInstance] POST:AddFollowUrl dict:parDic succeed:^(id data) {
            NSLog(@"HisViewController ----- %@ ----关注",data);
            [wSelf.viewOther.friendBtn setTitle:@"Following" forState:(UIControlStateNormal)];
            wSelf.viewOther.friendBtn.backgroundColor = RGB(212, 39, 82);
            [wSelf.viewOther.friendBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            wSelf.isFollow = [NSNumber numberWithInteger:1];
            [[DJHManager shareManager] toastManager:@"following" superView:wSelf.view];
        } failure:^(NSError *error) {
            
        }];

        
    }else {
        [[DJHttpApi shareInstance] POST:deleteFollowUrl dict:parDic succeed:^(id data) {
            NSLog(@"HisViewController ----- %@ ----取消关注",data);
            [wSelf.viewOther.friendBtn setTitle:@"+Follow" forState:(UIControlStateNormal)];
            wSelf.viewOther.friendBtn.backgroundColor = [UIColor whiteColor];
            wSelf.isFollow = [NSNumber numberWithInteger:0];
            [wSelf.viewOther.friendBtn setTitleColor:RGB(212, 39, 82) forState:(UIControlStateNormal)];
            wSelf.viewOther.friendBtn.layer.borderWidth = 1;
            [wSelf.viewOther.friendBtn.layer setBorderColor:RGB(212, 39, 82).CGColor];
            [[DJHManager shareManager] toastManager:@"Unfollow" superView:wSelf.view];

        } failure:^(NSError *error) {
            
        }];
    }
}


- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sendGiftAction {
    self.hidesBottomBarWhenPushed = YES;
    SendGandPController *vc = [[SendGandPController alloc] init];
    if (_model != nil) {
        vc.model = _model;

    }else{
        vc.userid = self.userid;
    }
    [self.navigationController pushViewController:vc animated:YES];
  
}


- (void)sendMessageAction {
    
    self.hidesBottomBarWhenPushed = YES;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"huiFu"];
    CeshiViewController *vc = [[CeshiViewController alloc] init];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
    
}


#pragma mark --- 其他方法的处理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
       
        if ([MFMailComposeViewController canSendMail]) { // 用户已设置邮件账户
            [self sendEmailAction]; // 调用发送邮件的代码
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Mail Accounts" message:@"Please set up Mail account in order to send email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            alert.tag = 101;
            [alert show];
        }
        
        
    }else if (buttonIndex == 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Sure Add BlackList" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        alert.tag = 102;

        [alert show];
        
    }else if(buttonIndex == 2) {
        
    }

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 101) {
        
    }else{
        if (buttonIndex == 0) {
            NSLog(@"HisViewController ---取消 ---- 拉黑");
        }else {
            NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
            NSDictionary *parDic = @{@"targetId":_model.userid,
                                     @"token":userDic[@"token"],
                                     @"userid":userDic[@"userid"]};
            [[DJHttpApi shareInstance] POST:AddBlacktUrl dict:parDic succeed:^(id data) {
                NSLog(@"HisViewController ----- %@ ---- 拉黑",data);
                
            } failure:^(NSError *error) {
                
            }];
        }
    }
}


-(void)sendEmailAction {
    
    // 邮件服务器
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    // 设置邮件代理
    [mailCompose setMailComposeDelegate:self];
    // 设置邮件主题
    [mailCompose setSubject:@"New mail"];
    // 设置收件人
    [mailCompose setToRecipients:@[@"nanpaa-report@nanpaa.com"]];
    /**
     *  设置邮件的正文内容
     */
    NSString *emailContent = @"";
    // 是否为HTML格式
    [mailCompose setMessageBody:emailContent isHTML:NO];
    
    [self.navigationController presentViewController:mailCompose animated:YES completion:nil];

}


#pragma mark ---- MFMailComposeViewControllerDelegate Action
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled: // 用户取消编辑
            NSLog(@"Mail send canceled...");
            break;
        case MFMailComposeResultSaved: // 用户保存邮件
            NSLog(@"Mail saved...");
            break;
        case MFMailComposeResultSent: // 用户点击发送
            NSLog(@"Mail sent...");
            break;
        case MFMailComposeResultFailed: // 用户尝试保存或发送邮件失败
            NSLog(@"Mail send errored: %@...", [error localizedDescription]);
            break;
    }
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark --- view方法
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"huiFu"];

}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

@end
