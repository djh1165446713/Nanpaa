

//
//  MeViewController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/9/22.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "MeViewController.h"
#import "MesonView.h"
#import "SetAppController.h"
#import "FollowerController.h"
#import "FollowingController.h"
#import "UserPaiSheController.h"
#import "TransaHistoryController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "ShareHelpManage.h"
#import "MyinformationView.h"
#import "PayMentController.h"
#import "MyindexAvController.h"
//#import "UIScrollView+TouchAction.h"
#import "DMPagingScrollView.h"
#import "SaveMyVideoController.h"
#import "EditMessageController.h"
#import "UserBeautyController.h"

#define MAX_INPUT_LENGTH 50

@interface MeViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *bgNacView;

@property (nonatomic, strong) UIButton *leftNavBtn;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *rightNavBtn;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIScrollView *sonScrollView;

@property (nonatomic, strong) MyinformationView *myView;

@property (nonatomic, strong) MyinformationView *myShadowView;

@property (nonatomic, strong) UILabel *userNameLab;

@property (nonatomic, strong) UIButton *replacementBtn;


@property (nonatomic, strong) UIImagePickerController *pickContro;

@property (nonatomic, strong) NSDictionary *userif;

@property (nonatomic, assign) BOOL backAndHeadImage;

@property (nonatomic, strong) MesonView *sonView;

@property (nonatomic, strong) NSDictionary *userlIST;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gerenVideoAction:) name:@"postPaishe" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticChangeText:) name:@"editIntroPost" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeheadImg:) name:@"changeheadImg" object:nil];

    [self initUI];
    [self laodData];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"one_guide"]) {
        UIImageView *guideView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        guideView.userInteractionEnabled = YES;
        guideView.tag = 10001;
        guideView.image = [UIImage imageNamed:@"newGuideImg"];
        [self.view addSubview:guideView];
        
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"one_guide"]);
        
        UITapGestureRecognizer *guideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeGuideViewAction)];
        [guideView addGestureRecognizer:guideTap];
        double delayInSeconds = 3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [guideView removeFromSuperview];
        });
    }
 
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"one_guide"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)laodData{
    ______WS();
    NSDictionary *userDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSDictionary *dict = @{@"token":userDict[@"token"],
                           @"userid":userDict[@"userid"]};
    [[DJHttpApi shareInstance] POST:GetUserInfo dict:dict succeed:^(id data) {
        if ([[NSString stringWithFormat:@"%@",data[@"rspCode" ]] isEqualToString:@"10012"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOutNotic" object:wSelf];
            NSLog(@"token错误");
            return;
        }
        wSelf.userif = data[@"rspObject"];
        [wSelf.myView.gzBtn setTitle:[NSString stringWithFormat:@"%@",wSelf.userif[@"followerNum"]] forState:(UIControlStateNormal)];
        [wSelf.myView.fsBtn setTitle:[NSString stringWithFormat:@"%@",wSelf.userif[@"followingNum"]] forState:(UIControlStateNormal)];

        [wSelf.bgNacView sd_setImageWithURL:[NSURL URLWithString:wSelf.userif[@"backgroundUrl"]]  placeholderImage: [UIImage imageNamed:@"normorBGIMG"] options:(SDWebImageRefreshCached)];
//        [wSelf.myView.headImgBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:wSelf.userif[@"avatarUrl"]] forState:(UIControlStateNormal) placeholderImage:[UIImage imageNamed:@"placeholderImg"] options:(SDWebImageRefreshCached)];
        [wSelf.myView.headImg sd_setImageWithURL:[NSURL URLWithString:wSelf.userif[@"avatarUrl"]] placeholderImage:[UIImage imageNamed:@"placeholderImg"] options:(SDWebImageRefreshCached)];

        wSelf.myView.userNameLab.text = [NSString stringWithFormat:@"%@",wSelf.userif[@"nickname"]];
        
        wSelf.myView.incomeNum.text = [NSString stringWithFormat:@"%@",wSelf.userif[@"income"]];
        wSelf.myView.pointNum.text = [NSString stringWithFormat:@"%@",wSelf.userif[@"coin"]];
        wSelf.sonView.textView.text = wSelf.userif[@"introduce"];
        
        wSelf.myShadowView.userNameLab.text = [NSString stringWithFormat:@"%@",wSelf.userif[@"nickname"]];
//        [wSelf.myShadowView.headImgBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:wSelf.userif[@"avatarUrl"]] forState:(UIControlStateNormal) placeholderImage:[UIImage imageNamed:@"placeholderImg"] options:(SDWebImageRefreshCached)];
        
        [wSelf.myShadowView.headImg sd_setImageWithURL:[NSURL URLWithString:wSelf.userif[@"avatarUrl"]] placeholderImage:[UIImage imageNamed:@"placeholderImg"] options:(SDWebImageRefreshCached)];
        
        wSelf.myShadowView.incomeNum.text = [NSString stringWithFormat:@"%@",wSelf.userif[@"income"]];
        wSelf.myShadowView.pointNum.text = [NSString stringWithFormat:@"%@",wSelf.userif[@"coin"]];
        [wSelf.myShadowView.gzBtn setTitle:[NSString stringWithFormat:@"%@",wSelf.userif[@"followerNum"]] forState:(UIControlStateNormal)];
        [wSelf.myShadowView.fsBtn setTitle:[NSString stringWithFormat:@"%@",wSelf.userif[@"followingNum"]] forState:(UIControlStateNormal)];

        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

- (void)initUI {
    ______WS();
    _bgNacView = [[UIImageView alloc] init];
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
    [self.view addSubview:_sonScrollView];

    
    _replacementBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_replacementBtn setTitle:@"Change the photo wall >" forState:(UIControlStateNormal)];
    [_replacementBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_replacementBtn addTarget:self action:@selector(tapBackImageAction) forControlEvents:(UIControlEventTouchUpInside)];
    _replacementBtn.alpha = 0.0;
    [self.sonScrollView addSubview:_replacementBtn];
    [_replacementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.scrollView.mas_top).offset(kScreenHeight - 48);
        make.centerX.equalTo(wSelf.scrollView);
        make.height.offset(24);
        make.width.offset(kScreenWidth);
    }];
    
    
    // 导航栏背景
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
    _leftNavBtn.exclusiveTouch = YES;
    [_leftNavBtn  addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_lineView addSubview:_leftNavBtn];
    [_leftNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.bgNacView).offset(0);
        make.top.equalTo(wSelf.bgNacView).offset(25);
        make.width.offset(50);
        make.height.offset(24);
    }];
    
    
    _rightNavBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_rightNavBtn setImage:[UIImage imageNamed:@"shezhi"] forState:(UIControlStateNormal)];
    [_rightNavBtn  addTarget:self action:@selector(shezhiAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_lineView addSubview:_rightNavBtn];
    [_rightNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.bgNacView.mas_right).offset(0);
        make.top.equalTo(wSelf.bgNacView).offset(25);
        make.width.offset(50);
        make.height.offset(24);
    }];
    
    
    UITapGestureRecognizer *incomeNumTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(incomeNumTapAction)];
    UITapGestureRecognizer *pointNumTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pointNumTapAction)];
    UITapGestureRecognizer *shareImgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(invitaAciton)];
    UITapGestureRecognizer *shareImgTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(invitaAciton)];
    UITapGestureRecognizer *ImgTapHead = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setHeadImgAction)];

    UITapGestureRecognizer *ImgTapHead2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setHeadImgAction)];

    _myView = [[MyinformationView alloc] init];
    _myView.userInteractionEnabled = YES;
//    self.myView.layer.shadowOpacity = 0.5;// 阴影透明度
//    self.myView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
//    self.myView.layer.shadowRadius = 4;// 阴影扩散的范围控制
//    self.myView.layer.shadowOffset = CGSizeMake(1, 4);// 阴影的范围
    [_myView.incomeNum addGestureRecognizer:incomeNumTap];
    [_myView.pointNum addGestureRecognizer:pointNumTap];
    [_myView.shareIcon addGestureRecognizer:shareImgTap];
    [_myView.headImg addGestureRecognizer:ImgTapHead2];
    [_myView.buyBtn addTarget:self action:@selector(pointNumTapAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_myView.gzBtn addTarget:self action:@selector(gzAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_myView.fsBtn addTarget:self action:@selector(fsAction) forControlEvents:(UIControlEventTouchUpInside)];
    _myView.hidden = YES;
    [self.myView.fsBtn setTitle:@"0" forState:(UIControlStateNormal)];
    [self.myView.gzBtn setTitle:@"0" forState:(UIControlStateNormal)];
    [self.scrollView addSubview:_myView];
    [_myView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.scrollView.mas_top).offset(58 + kScreenHeight);
        make.centerX.equalTo(wSelf.scrollView);
        make.height.offset(270);
        make.left.equalTo(wSelf.view.mas_left).offset(16);
        make.right.equalTo(wSelf.view.mas_right).offset(-16);

    }];

    
    _myShadowView = [[MyinformationView alloc] init];
    _myShadowView.userInteractionEnabled = YES;
//    self.myShadowView.layer.shadowOpacity = 0.5;// 阴影透明度
//    self.myShadowView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
//    self.myShadowView.layer.shadowRadius = 4;// 阴影扩散的范围控制
//    self.myShadowView.layer.shadowOffset = CGSizeMake(1, 4);// 阴影的范围
    [_myShadowView.incomeNum addGestureRecognizer:incomeNumTap];
    [_myShadowView.pointNum addGestureRecognizer:pointNumTap];
    [_myShadowView.shareIcon addGestureRecognizer:shareImgTap2];
    [_myShadowView.headImg addGestureRecognizer:ImgTapHead];
    [_myShadowView.buyBtn addTarget:self action:@selector(pointNumTapAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_myShadowView.gzBtn addTarget:self action:@selector(gzAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_myShadowView.fsBtn addTarget:self action:@selector(fsAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.myShadowView.fsBtn setTitle:@"0" forState:(UIControlStateNormal)];
    [self.myShadowView.gzBtn setTitle:@"0" forState:(UIControlStateNormal)];
    [self.sonScrollView addSubview:_myShadowView];
    [_myShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.sonScrollView.mas_top).offset(58 + kScreenHeight / 2);
        make.centerX.equalTo(wSelf.sonScrollView);
        make.height.offset(270);
        make.left.equalTo(wSelf.view.mas_left).offset(16);
        make.right.equalTo(wSelf.view.mas_right).offset(-16);
        
    }];
    

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    UITapGestureRecognizer *tapEdit = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEditAction)];

    _sonView = [[MesonView alloc] init];
//    _sonView.layer.shadowOpacity = 0.5;// 阴影透明度
//    _sonView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
//    _sonView.layer.shadowRadius = 4;// 阴影扩散的范围控制
//    _sonView.layer.shadowOffset = CGSizeMake(1, 4);// 阴影的范围
    _sonView.userInteractionEnabled = YES;
    _sonView.textView.delegate = self;
    _sonView.view.hidden = NO;
    _sonView.lineView.hidden = NO;
    [_sonView.view addGestureRecognizer:tap];
    [_sonView.setImg addGestureRecognizer:tapEdit];
    _sonView.layer.masksToBounds = YES;
    _sonView.layer.cornerRadius = 8;
    [self.sonScrollView addSubview:_sonView];
    [_sonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.myView.mas_bottom).offset(10);
        make.left.equalTo(wSelf.myView.mas_left).offset(0);
        make.right.equalTo(wSelf.myView.mas_right).offset(0);
        make.height.offset(270);
    }];

    
}


#pragma mark --- scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    NSLog(@"%f",_scrollView.contentOffset.y);
    if (contentOffsetY < 16) {
        _replacementBtn.hidden = NO;
        _replacementBtn.alpha = 1 - contentOffsetY / 16;
        self.leftNavBtn.hidden = YES;
        self.rightNavBtn.hidden = YES;
    }
    if (contentOffsetY > 16) {
        _replacementBtn.hidden = YES;
        self.leftNavBtn.hidden = NO;
        self.rightNavBtn.hidden = NO;
    }
    
    if (contentOffsetY > kScreenHeight / 2) {
        _myView.hidden = YES;
        _myShadowView.hidden = NO;
    }
    if (contentOffsetY >= kScreenHeight) {
        _myView.hidden = NO;
        _myShadowView.hidden = YES;
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



#pragma mark --- 自定义方法
// 分享
- (void)invitaAciton {
    [[ShareHelpManage shareInstance] shareSDKarray:nil shareText:shareInput shareURLString:shareURL shareTitle:shareTitText];
}


- (void)shezhiAction {
    self.hidesBottomBarWhenPushed=YES;
    SetAppController *vc = [[SetAppController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//    self.hidesBottomBarWhenPushed=NO;
}

// 更换背景图
- (void)tapBackImageAction {
    _backAndHeadImage = YES;
    [[NSUserDefaults standardUserDefaults] setObject:@"changeHeadIcon" forKey:@"headIcon"];
    UIActionSheet *sheet = [[UIActionSheet alloc]
                            initWithTitle:nil
                            delegate:self
                            cancelButtonTitle:@"Cancel"
                            destructiveButtonTitle:nil
                            otherButtonTitles:@"Take Photo",@"Select from album", nil];
    sheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    [sheet showInView:self.view];
    
}



// 更换头像方法
- (void)setHeadImgAction {
    _backAndHeadImage = NO;
    [[NSUserDefaults standardUserDefaults] setObject:@"changeHeadIcon" forKey:@"headIcon"];
    UIActionSheet *sheet = [[UIActionSheet alloc]
                            initWithTitle:nil
                            delegate:self
                            cancelButtonTitle:@"Cancel"
                            destructiveButtonTitle:nil
                            otherButtonTitles:@"Take Photo",@"Select from album", nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [sheet showInView:self.view];

}

// 拍摄个人视频简介
- (void)tapAction {
    
    NSString *indexVideoUrl = [NSString stringWithFormat:@"%@",self.userlIST[@"indexVideoUrl"]];
    if ([indexVideoUrl isEqualToString:@""]) {
//        self.hidesBottomBarWhenPushed = YES;
//        [[NSUserDefaults standardUserDefaults] setObject:@"alive" forKey:@"indexVideo"];
//        UserPaiSheController *vc = [[UserPaiSheController alloc] init];
//        [self.navigationController presentViewController:vc animated:YES completion:nil];
        UserBeautyController *marVC = [[UserBeautyController alloc] init];
        [self.navigationController presentViewController:marVC animated:YES completion:nil];

    }else{
        self.hidesBottomBarWhenPushed = YES;
        MyindexAvController *vc = [[MyindexAvController alloc] init];
        vc.videoUrlStr = indexVideoUrl;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

// 金币点击
- (void)incomeNumTapAction {
    self.hidesBottomBarWhenPushed = YES;
    TransaHistoryController *vc = [[TransaHistoryController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pointNumTapAction{
    self.hidesBottomBarWhenPushed = YES;
    PayMentController *vc = [[PayMentController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)gzAction {
    self.hidesBottomBarWhenPushed = YES;
    FollowerController *vc = [[FollowerController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//    self.hidesBottomBarWhenPushed = NO;

}


- (void)fsAction {
    self.hidesBottomBarWhenPushed = YES;
    FollowingController *vc = [[FollowingController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//    self.hidesBottomBarWhenPushed = NO;
}


// 删除引导页
- (void)removeGuideViewAction{
    UIImageView *guideView = [self.view viewWithTag:10001];
    [guideView removeFromSuperview];
}

#pragma mark ---- 其他代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        _pickContro = [[UIImagePickerController alloc] init];
        _pickContro.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        _pickContro.delegate = self;
        _pickContro.allowsEditing = NO;
        [self presentViewController:_pickContro animated:YES completion:nil];


    }else if (buttonIndex == 0) {
        if ([self isCameraAvailable]) {
//            _pickContro = [[UIImagePickerController alloc] init];
//            _pickContro.sourceType = UIImagePickerControllerSourceTypeCamera;
//            _pickContro.delegate = self;
//            _pickContro.allowsEditing = NO;
//            float aspectRatio = 4.0/3.0;
//            float scale = kScreenHeight/kScreenWidth * aspectRatio;
//
//            _pickContro.cameraViewTransform =  CGAffineTransformMakeScale(scale, scale);
//            
//            [self presentViewController:_pickContro animated:YES completion:nil];
            UserBeautyController *marVC = [[UserBeautyController alloc] init];
            [[NSUserDefaults standardUserDefaults] setObject:@"userHeadIconYES" forKey:@"userHeadIconBOOL"];
            [self.navigationController presentViewController:marVC animated:YES completion:nil];
        }
    }else if(buttonIndex == 2) {
        
    }
    
}


#pragma mark --- UIImagePickerController Delegate
// 判断设备是否有摄像头
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

// 前面的摄像头是否可用
- (BOOL) isFrontCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

// 后面的摄像头是否可用
- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    
    if (_backAndHeadImage) {
        UIImage *imageAfter = [self compressImage:image newWidth:400];
        _bgNacView.image = imageAfter;
        [self dismissViewControllerAnimated:YES completion:nil];
        [self urlWithImage:BackImgURL image:imageAfter str:@"background"];
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _scrollView.contentOffset =  CGPointMake(0, kScreenHeight - 300);
            
        } completion:^(BOOL finished) {
            
        }];
        
    }else {
        UIImage *imageAfter = [self compressImage:image newWidth:200];
//        [_myView.headImgBtn setImage:imageAfter forState:(UIControlStateNormal)];
        _myView.headImg.image = imageAfter;
        _myShadowView.headImg.image = imageAfter;
//        [_myShadowView.headImgBtn setImage:imageAfter forState:(UIControlStateNormal)];
        [self dismissViewControllerAnimated:YES completion:nil];
        [self urlWithImage:AvatarURL image:imageAfter str:@"avatar"];
    }
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
 
}

- (void)urlWithImage:(NSString *)url image:(UIImage *)image str:(NSString *)str{


    NSDictionary *userData = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    //1。创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *URL = [NSString stringWithFormat:@"%@%@",URLdomain,url];
    [manager POST:URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传文件参数
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil) {
            
            data = UIImageJPEGRepresentation(image, 0.5);
            
        } else {
            
            data = UIImagePNGRepresentation(image);
        }
        
        //这个就是参数
        
        [formData appendPartWithFileData:data name:str fileName:@"headIcon.jpg" mimeType:@"image/jpg"];
        [formData appendPartWithFormData:[userData[@"token"] dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"token"];
        [formData appendPartWithFormData:[@".jpg" dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"type"];
        [formData appendPartWithFormData:[userData[@"userid"] dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"userid"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        [[DJHManager shareManager] toastManager:@"Saved successfully" superView:self.view];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败  处理
        NSLog(@"请求失败：%@",error);
    }];
    
    
}


/**
 *  等比缩放本图片大小
 *
 *  @param newImageWidth 缩放后图片宽度，像素为单位
 *
 *  @return self-->(image)
 */
- (UIImage *)compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth
{
    if (!image) return nil;
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = newImageWidth;
    float height = image.size.height/(image.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

#pragma mark ---- 通知 Action
- (void)noticChangeText:(NSNotification *)notic{
    NSDictionary *dic = notic.userInfo;
    self.sonView.textView.text = [NSString stringWithFormat:@"%@",dic[@"text"]];
}



- (void)gerenVideoAction:(NSNotification *)notic{
    self.hidesBottomBarWhenPushed = YES;
    SaveMyVideoController *messVC = [[SaveMyVideoController alloc] init];
    [self.navigationController pushViewController:messVC animated:YES];
}

-(void)changeheadImg:(NSNotification *)notic{
    UIImage *image = notic.userInfo[@"img"];
    if (_backAndHeadImage) {
        UIImage *imageAfter = [self compressImage:image newWidth:400];
        _bgNacView.image = imageAfter;
        [self dismissViewControllerAnimated:YES completion:nil];
        [self urlWithImage:BackImgURL image:imageAfter str:@"background"];
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _scrollView.contentOffset =  CGPointMake(0, kScreenHeight - 300);
            
        } completion:^(BOOL finished) {
            
        }];
        
    }else {
        UIImage *imageAfter = [self compressImage:image newWidth:200];
        //        [_myView.headImgBtn setImage:imageAfter forState:(UIControlStateNormal)];
        _myView.headImg.image = imageAfter;
        _myShadowView.headImg.image = imageAfter;
        //        [_myShadowView.headImgBtn setImage:imageAfter forState:(UIControlStateNormal)];
        [self dismissViewControllerAnimated:YES completion:nil];
        [self urlWithImage:AvatarURL image:imageAfter str:@"avatar"];
    }
}

#pragma mark ---- TextViewDelegate Action
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.hidesBottomBarWhenPushed = YES;
    EditMessageController *editVC = [[EditMessageController alloc] init];
    editVC.text = textView.text;
    [self.navigationController pushViewController:editVC animated:YES];
}

#pragma mark --- view方法
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ______WS();
    NSDictionary *userDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSDictionary *dict = @{@"token":userDict[@"token"],
                           @"userid":userDict[@"userid"]};
    [[DJHttpApi shareInstance] POST:GetUserInfo dict:dict succeed:^(id data) {
        
        if ([[NSString stringWithFormat:@"%@",data[@"rspCode" ]] isEqualToString:@"10012"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOutNotic" object:self];
            NSLog(@"token错误");
            return;
        }
        wSelf.userlIST = data[@"rspObject"];

    } failure:^(NSError *error) {
            NSLog(@"%@",error);
    }];
//    [[IQKeyboardManager sharedManager] setEnable:YES];
//    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;  //控制点击背景是否收起键盘
    
}

- (void)dealloc{
    NSLog(@"%@ : 控制器已退出",self);
    [[NSNotificationCenter defaultCenter] removeObserver:@"postPaishe"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"editIntroPost"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"changeheadImg"];

}

- (void)tapEditAction{
    self.hidesBottomBarWhenPushed = YES;
    EditMessageController *editVC = [[EditMessageController alloc] init];
    editVC.text = _sonView.textView.text;
    [self.navigationController pushViewController:editVC animated:YES];

}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.sonView.textView resignFirstResponder];
}


@end
