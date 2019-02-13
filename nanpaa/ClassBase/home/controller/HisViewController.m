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
#import "MessageController.h"
#import "MARFaceBeautyController.h"
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
@property (nonatomic, strong) UIScrollView *sonScrollView;

@property (nonatomic, strong) OtherUserView *viewOther;
@property (nonatomic, strong) OtherUserView *view2Other;

@property (nonatomic, strong) NSDictionary *userDict;

@property (nonatomic, strong) UIImagePickerController *pickContro;

@end

@implementation HisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"postSendOne" object:nil];

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
        
        [[NSUserDefaults standardUserDefaults] setObject:wSelf.peopleDic[@"hxAccount"] forKey:@"hxAcount"];
        if ([wSelf.peopleDic[@"isFollower"] integerValue] == 0) {
            wSelf.viewOther.line2View.hidden = NO;
            wSelf.viewOther.giftAndPointsBtn.hidden = NO;
            wSelf.view2Other.line2View.hidden = NO;
            wSelf.view2Other.giftAndPointsBtn.hidden = NO;
        }else{
            wSelf.viewOther.giftPointsBtn.hidden = NO;
            wSelf.viewOther.sendMessageBtn.hidden = NO;
            wSelf.viewOther.lineView.hidden = NO;
            wSelf.view2Other.giftPointsBtn.hidden = NO;
            wSelf.view2Other.sendMessageBtn.hidden = NO;
            wSelf.view2Other.lineView.hidden = NO;
        }
        
        if ([wSelf.peopleDic[@"isFollowing"] integerValue] == 1) {
            [wSelf.viewOther.friendBtn setTitle:@"Following" forState:(UIControlStateNormal)];
            wSelf.viewOther.friendBtn.backgroundColor = RGB(212, 39, 82);
            [wSelf.view2Other.friendBtn setTitle:@"Following" forState:(UIControlStateNormal)];
            wSelf.view2Other.friendBtn.backgroundColor = RGB(212, 39, 82);
            
        }else{
            [wSelf.viewOther.friendBtn setTitle:@"+Follow" forState:(UIControlStateNormal)];
            wSelf.viewOther.friendBtn.backgroundColor = [UIColor whiteColor];
            [wSelf.viewOther.friendBtn setTitleColor:RGB(212, 39, 82) forState:(UIControlStateNormal)];
            wSelf.viewOther.friendBtn.layer.borderWidth = 1;
            [wSelf.viewOther.friendBtn.layer setBorderColor:RGB(212, 39, 82).CGColor];
            
            [wSelf.view2Other.friendBtn setTitle:@"+Follow" forState:(UIControlStateNormal)];
            wSelf.view2Other.friendBtn.backgroundColor = [UIColor whiteColor];
            [wSelf.view2Other.friendBtn setTitleColor:RGB(212, 39, 82) forState:(UIControlStateNormal)];
            wSelf.view2Other.friendBtn.layer.borderWidth = 1;
            [wSelf.view2Other.friendBtn.layer setBorderColor:RGB(212, 39, 82).CGColor];
        }
        
        [wSelf.bgNacView sd_setImageWithURL:[NSURL URLWithString:wSelf.peopleDic[@"backgroundUrl"]]  placeholderImage:[UIImage imageNamed:@"normorBGIMG"] options:(SDWebImageRefreshCached)];
        [wSelf.viewOther.headImgBtn sd_setImageWithURL:[NSURL URLWithString:wSelf.peopleDic[@"avatarUrl"]] forState:(UIControlStateNormal) placeholderImage:[UIImage imageNamed:@"placeholderImg"] options:(SDWebImageRefreshCached)];
        wSelf.viewOther.userNameLab.text = [NSString stringWithFormat:@"%@",wSelf.peopleDic[@"nickname"]];
        wSelf.viewOther.incomeNum.text = [NSString stringWithFormat:@"%@",wSelf.peopleDic[@"followingNum"]];
        wSelf.viewOther.pointNum.text = [NSString stringWithFormat:@"%@",wSelf.peopleDic[@"followerNum"]];
        
        [wSelf.view2Other.headImgBtn sd_setImageWithURL:[NSURL URLWithString:wSelf.peopleDic[@"avatarUrl"]] forState:(UIControlStateNormal) placeholderImage:[UIImage imageNamed:@"placeholderImg"] options:(SDWebImageRefreshCached)];
        wSelf.view2Other.userNameLab.text = [NSString stringWithFormat:@"%@",wSelf.peopleDic[@"nickname"]];
        wSelf.view2Other.incomeNum.text = [NSString stringWithFormat:@"%@",wSelf.peopleDic[@"followingNum"]];
        wSelf.view2Other.pointNum.text = [NSString stringWithFormat:@"%@",wSelf.peopleDic[@"followerNum"]];
        
        wSelf.sonView.textView.text = [NSString stringWithFormat:@"%@",wSelf.peopleDic[@"introduce"]];
        
    } failure:^(NSError *error) {
        
    }];
    
    
    NSDictionary *dict = @{@"token":dic[@"token"],
                           @"userid":dic[@"userid"]};
    [[DJHttpApi shareInstance] POST:GetUserInfo dict:dict succeed:^(id data) {
        
        if ([[NSString stringWithFormat:@"%@",data[@"rspCode" ]] isEqualToString:@"10012"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOutNotic" object:self];
            NSLog(@"token错误");
        }else{
            NSDictionary *user = data[@"rspObject"];
            [[NSUserDefaults standardUserDefaults] setObject:user forKey:@"userInfo"];
        }
        
    } failure:^(NSError *error) {
    }];
    
}


- (void)initUI {
    ______WS();
    _bgNacView = [[UIImageView alloc] init];
    _bgNacView.exclusiveTouch = YES;
    //    _bgNacView.image = [UIImage imageNamed:@"normorBGIMG"];
    _bgNacView.backgroundColor = RGB(216, 216, 216);
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
    
    
//    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    _scrollView.backgroundColor = [UIColor clearColor];
//    _scrollView.userInteractionEnabled = YES;
//    self.scrollView.layer.shadowOpacity = 0.5;// 阴影透明度
//    self.scrollView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
//    self.scrollView.layer.shadowRadius = 4;// 阴影扩散的范围控制
//    self.scrollView.layer.shadowOffset = CGSizeMake(1, 4);// 阴影的范围
//    _scrollView.delegate = self;
//    _scrollView.contentOffset = CGPointMake(0, kScreenHeight);
//    self.scrollView.showsHorizontalScrollIndicator = NO;
//    self.scrollView.showsVerticalScrollIndicator = NO;
//    self.scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight * 2);
//    _scrollView.bounces = YES;
//    [self.view addSubview:_scrollView];
    
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight / 2)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.userInteractionEnabled = YES;
    _scrollView.delegate = self;
    //    _scrollView.alwaysBounceVertical = YES;
    _scrollView.layer.shadowOpacity = 0.5;// 阴影透明度
    _scrollView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    _scrollView.layer.shadowRadius = 4;// 阴影扩散的范围控制
    _scrollView.layer.shadowOffset = CGSizeMake(1, 4);// 阴影的范围
    _scrollView.bounces = YES;
    _scrollView.clipsToBounds = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentOffset = CGPointMake(0, kScreenHeight / 2);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight / 2 * 3);
    _scrollView.bounces = YES;
    [self.view addSubview:_scrollView];
    
    
    _sonScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kScreenHeight / 2, kScreenWidth, kScreenHeight / 2)];
    _sonScrollView.backgroundColor = [UIColor clearColor];
    _sonScrollView.userInteractionEnabled = YES;
    _sonScrollView.delegate = self;
    _sonScrollView.layer.shadowOpacity = 0.5;// 阴影透明度
    _sonScrollView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    _sonScrollView.layer.shadowRadius = 4;// 阴影扩散的范围控制
    _sonScrollView.layer.shadowOffset = CGSizeMake(1, 4);// 阴影的范围
    //    _scrollView.alwaysBounceVertical = YES;
    _sonScrollView.bounces = YES;
    _sonScrollView.clipsToBounds = NO;
    _sonScrollView.pagingEnabled = YES;
    _sonScrollView.contentOffset = CGPointMake(0, kScreenHeight / 2);
    self.sonScrollView.showsHorizontalScrollIndicator = NO;
    self.sonScrollView.showsVerticalScrollIndicator = NO;
    self.sonScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight / 2 * 3);
    _sonScrollView.bounces = YES;
    [self.view addSubview:_sonScrollView];
    
    
    
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
//    self.viewOther.layer.shadowOpacity = 0.5;// 阴影透明度
//    self.viewOther.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
//    self.viewOther.layer.shadowRadius = 4;// 阴影扩散的范围控制
//    self.viewOther.layer.shadowOffset = CGSizeMake(1, 4);// 阴影的范围
    self.viewOther.headImgBtn.userInteractionEnabled = NO;
    [self.viewOther.giftPointsBtn addTarget:self action:@selector(sendGiftAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.viewOther.sendMessageBtn addTarget:self action:@selector(sendMessageAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.viewOther.giftAndPointsBtn addTarget:self action:@selector(sendGiftAction) forControlEvents:(UIControlEventTouchUpInside)];
//    self.viewOther.hidden = YES;
    [self.viewOther.shareIcon addGestureRecognizer:shareImgTap];
    [self.viewOther.friendBtn addTarget:self action:@selector(initaBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.scrollView addSubview:self.viewOther];
    [self.viewOther mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.scrollView.mas_top).offset(58 + kScreenHeight);
        make.centerX.equalTo(wSelf.scrollView);
        make.height.offset(260);
        make.left.equalTo(wSelf.view.mas_left).offset(16);
        make.right.equalTo(wSelf.view.mas_right).offset(-16);
    }];
    
    UITapGestureRecognizer *shareImg2Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(invitaAciton)];
    self.view2Other = [[OtherUserView alloc] init];
    //    self.viewOther.layer.shadowOpacity = 0.5;// 阴影透明度
    //    self.viewOther.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    //    self.viewOther.layer.shadowRadius = 4;// 阴影扩散的范围控制
    //    self.viewOther.layer.shadowOffset = CGSizeMake(1, 4);// 阴影的范围
    self.view2Other.headImgBtn.userInteractionEnabled = NO;
    [self.view2Other.giftPointsBtn addTarget:self action:@selector(sendGiftAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view2Other.sendMessageBtn addTarget:self action:@selector(sendMessageAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view2Other.giftAndPointsBtn addTarget:self action:@selector(sendGiftAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view2Other.shareIcon addGestureRecognizer:shareImg2Tap];
    [self.view2Other.friendBtn addTarget:self action:@selector(initaBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.sonScrollView addSubview:self.view2Other];
    [self.view2Other mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.sonScrollView.mas_top).offset(58 + kScreenHeight / 2);
        make.height.offset(260);
        make.centerX.equalTo(wSelf.sonScrollView);
        make.left.equalTo(wSelf.view.mas_left).offset(16);
        make.right.equalTo(wSelf.view.mas_right).offset(-16);
    }];
    
    
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    _sonView = [[MesonView alloc] init];
//    self.sonView.layer.shadowOpacity = 0.5;// 阴影透明度
//    self.sonView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
//    self.sonView.layer.shadowRadius = 4;// 阴影扩散的范围控制
//    self.sonView.layer.shadowOffset = CGSizeMake(1, 4);// 阴影的范围
//    _sonView.setImg.hidden = YES;
    _sonView.userInteractionEnabled = YES;
    //    [_sonView.view addGestureRecognizer:tap];
    _sonView.layer.masksToBounds = YES;
    _sonView.layer.cornerRadius = 8;
    [self.sonScrollView addSubview:_sonView];
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
                            cancelButtonTitle:@"Cancel"
                            destructiveButtonTitle:nil
                            otherButtonTitles:@"Report",@"Add BlackList", nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    sheet.tag = 10001;
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
            [wSelf.view2Other.friendBtn setTitle:@"Following" forState:(UIControlStateNormal)];
            wSelf.view2Other.friendBtn.backgroundColor = RGB(212, 39, 82);
            [wSelf.view2Other.friendBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
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
            
            [wSelf.view2Other.friendBtn setTitle:@"+Follow" forState:(UIControlStateNormal)];
            wSelf.view2Other.friendBtn.backgroundColor = [UIColor whiteColor];
            [wSelf.view2Other.friendBtn setTitleColor:RGB(212, 39, 82) forState:(UIControlStateNormal)];
            wSelf.view2Other.friendBtn.layer.borderWidth = 1;
            [wSelf.view2Other.friendBtn.layer setBorderColor:RGB(212, 39, 82).CGColor];
            [[DJHManager shareManager] toastManager:@"Unfollow" superView:wSelf.view];
            
        } failure:^(NSError *error) {
            
        }];
    }
}
#pragma mark --- scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    NSLog(@"%f",_scrollView.contentOffset.y);
    
    if (contentOffsetY > kScreenHeight / 2) {
        _viewOther.hidden = YES;
        _view2Other.hidden = NO;
    }
    if (contentOffsetY >= kScreenHeight) {
        _viewOther.hidden = NO;
        _view2Other.hidden = YES;
    }
    
    if(scrollView == _sonScrollView)
    {
        _scrollView.delegate =nil;
        [_scrollView setContentOffset:_sonScrollView.contentOffset];
        _scrollView.delegate =self;
        
    }else {
        _sonScrollView.delegate =nil;
        [_sonScrollView setContentOffset:_scrollView.contentOffset];
        _sonScrollView.delegate =self;
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
//    UIActionSheet *sheet = [[UIActionSheet alloc]
//                            initWithTitle:nil
//                            delegate:self
//                            cancelButtonTitle:@"Cancel"
//                            destructiveButtonTitle:nil
//                            otherButtonTitles:@"Take Photo",@"Take Video", nil];
//    sheet.tag = 10002;
//    [sheet showInView:self.view];
    self.hidesBottomBarWhenPushed = YES;
    MARFaceBeautyController *vc = [[MARFaceBeautyController alloc] init];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}


#pragma mark --- 其他方法的处理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (actionSheet.tag == 10002) {
//        if (buttonIndex == 0) {
//            _pickContro = [[UIImagePickerController alloc] init];
//            _pickContro.sourceType = UIImagePickerControllerSourceTypeCamera;
//            _pickContro.delegate = self;
//            _pickContro.allowsEditing = NO;
//            [self presentViewController:_pickContro animated:YES completion:nil];
//            
//        }else if (buttonIndex == 1) {
////            self.hidesBottomBarWhenPushed = YES;
//            MARFaceBeautyController *vc = [[MARFaceBeautyController alloc] init];
//            [self.navigationController presentViewController:vc animated:YES completion:nil];
//        }else if(buttonIndex == 2) {
//            
//        }
//    }else{
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
        
//    }
    
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
//
//
//#pragma mark ---- UIImagePickerControllerDelegate Action
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
//    NSData *imageData = [NSKeyedArchiver archivedDataWithRootObject:image];
//    //    NSDictionary *dic = @{@"img":imageData};
//    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"picVideoContro" object:self userInfo:dic];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//    self.hidesBottomBarWhenPushed = YES;
//    MessageController *messVC = [[MessageController alloc] init];
//    messVC.data = imageData;
//    [self.navigationController pushViewController:messVC animated:NO];
//    
//    
//}


- (void)notificationAction:(NSNotification *)notiction{
    if (notiction.userInfo) {
        UIImage *data = notiction.userInfo[@"img"];
        self.hidesBottomBarWhenPushed = YES;
        MessageController *messVC = [[MessageController alloc] init];
        messVC.image = data;
        [self.navigationController pushViewController:messVC animated:NO];
    }else{
        self.hidesBottomBarWhenPushed = YES;
        MessageController *messVC = [[MessageController alloc] init];
        [self.navigationController pushViewController:messVC animated:YES];
    }
}


//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//}



#pragma mark --- view方法
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSUserDefaults standardUserDefaults] setObject:@"send" forKey:@"typeBrod"];
    [[NSUserDefaults standardUserDefaults] setObject:@"postSendOne" forKey:@"postHome"];

}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


- (void)dealloc{
    NSLog(@"%@ 销毁了",self);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
