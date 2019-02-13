//
//  HomeController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/9/20.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "HomeController.h"
#import "MeViewController.h"
#import "SetAppController.h"
#import "CeshiViewController.h"
#import "TKSegementedView.h"
#import "MessageController.h"
#import "DynamicModel.h"
#import "DynamicCell.h"
#import "VideoPlayController.h"
#import "RecommendModel.h"
#import "HisViewController.h"
#import "DanMuRemcoController.h"
#import "PayMentController.h"
#import "ChooseJNView.h"
#import "EmtyCell.h"
#import "BulletBackGroundView.h"
#import "LoginViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MARFaceBeautyController.h"
#import "WZLBadgeImport.h"

@interface HomeController ()<UITableViewDelegate, UITableViewDataSource, EMChatManagerDelegate, pushDelegate,CLLocationManagerDelegate,MKMapViewDelegate>

@property (nonatomic, strong) UIView *superView;
@property (nonatomic, strong) UIButton *qianBtn;
@property (nonatomic, strong) UITableView *iNtableView;
@property (nonatomic, strong) UITableView *rEtableView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *pointLab;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *recommArr;
@property (nonatomic, strong) NSMutableArray *replyArr;
@property (nonatomic, strong) UITapGestureRecognizer *tapCell;
@property (nonatomic, strong) NSDictionary *userDict;
@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, assign) NSInteger *modelNum;
@property (nonatomic, strong) NSMutableDictionary *modelDic;
//@property (nonatomic, strong) ChooseJNView *showView;
@property (nonatomic, strong) UIImagePickerController *pickContro;
@property (nonatomic, assign) BOOL plusButtnEnable;
@property (nonatomic, strong) BulletBackGroundView *bulletBgView;
@property (nonatomic, assign) NSInteger unReadCount;

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation HomeController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    //    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    _dataArr = [NSMutableArray array];
    _plusButtnEnable = YES;
    _recommArr = [NSMutableArray array];
    _replyArr = [NSMutableArray array];
    [self getUSerLocation];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"pushNoticHome" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationUpdate:) name:@"postUpdateMessage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPicPush:) name:@"pushPicHome" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tanchuan:) name:@"tanchuanHome" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOutAction:) name:@"loginOutNotic" object:nil];
    
    _modelDic = [NSMutableDictionary dictionary];
    _userDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    
    ______WS();
    NSDictionary *dict = @{@"token":_userDict[@"token"],
                           @"userid":_userDict[@"userid"]};
    [[DJHttpApi shareInstance] POST:GetUserInfo dict:dict succeed:^(id data) {
        
        if ([[NSString stringWithFormat:@"%@",data[@"rspCode" ]] isEqualToString:@"10012"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOutNotic" object:self];
            NSLog(@"token错误");
        }else{
            NSDictionary *user = data[@"rspObject"];
            NSDictionary *attr = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
//            if ([user[@"coin"] isEqualToString:@"0"]) {
//                
//            }
            CGFloat width = [[NSString stringWithFormat:@"%@",user[@"coin"]] sizeWithAttributes:attr].width;
            
            [[NSUserDefaults standardUserDefaults] setObject:user forKey:@"userInfo"];
            UITapGestureRecognizer *tapCZ = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightNavAction)];
            wSelf.pointLab = [[UILabel alloc] init];
            wSelf.pointLab.userInteractionEnabled = YES;
            wSelf.pointLab.textColor = RGB(212, 39, 82);
            [wSelf.pointLab addGestureRecognizer:tapCZ];
            wSelf.pointLab.font = [UIFont systemFontOfSize:13];
            wSelf.pointLab.textAlignment = NSTextAlignmentRight;
            [wSelf.bgView addSubview:wSelf.pointLab];
            [wSelf.pointLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(wSelf.bgView.mas_right).offset(-5);
                make.centerY.equalTo(wSelf.leftNavBtn);
                make.width.offset(width + 2);
                make.height.offset(24);
            }];
            wSelf.pointLab.text = [NSString stringWithFormat:@"%@",user[@"coin"]];
            
            
            wSelf.rightNavBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [ wSelf.rightNavBtn setImage:[UIImage imageNamed:@"jinbiTixian"]  forState:(UIControlStateNormal)];
            [ wSelf.rightNavBtn  addTarget:wSelf action:@selector(rightNavAction) forControlEvents:(UIControlEventTouchUpInside)];
            [wSelf.bgView addSubview: wSelf.rightNavBtn];
            [ wSelf.rightNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(wSelf.pointLab.mas_left).offset(-3);
                make.centerY.equalTo(wSelf.leftNavBtn);
                make.width.offset(16);
                make.height.offset(16);
            }];
            
        }
        
    } failure:^(NSError *error) {
    }];
    
    
    
    
#pragma mark --- 登录环信
    [[EMClient sharedClient] loginWithUsername:_userDict[@"hxAccount"]
                                      password:_userDict[@"hxPassword"]
                                    completion:^(NSString *aUsername, EMError *aError) {
                                        if (!aError) {
                                            NSLog(@"登陆成功");
                                            NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
                                            NSTimeInterval intervalbefore = interval - 24 * 60 * 60 * 2 * 1000;
                                            NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
                                            for (EMConversation *conv in conversations) {
                                                [conv loadMessagesFrom:intervalbefore to:interval count:200 completion:^(NSArray *aMessages, EMError *aError) {
                                                    [wSelf didReceiveMessages:aMessages];
                                                }];
                                            }
                                        }else {
                                            NSLog(@"登陆失败");
                                        }
                                    }];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
}

- (void)initUI {
    ______WS();
    _bgImg = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds ];
    _bgImg.image = [UIImage imageNamed:@"bcg"];
    _bgImg.userInteractionEnabled = YES;
    [self.view addSubview:_bgImg];
    
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = RGB(49, 56, 93);
    
    [self.view addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(0);
        make.width.offset(kScreenWidth);
        make.top.equalTo(wSelf.view).offset(0);
        make.height.offset(64);
    }];
    
    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeight - 110)];
    _bgScrollView.contentSize = CGSizeMake(kScreenWidth * 2, kScreenHeight - 110);
    _bgScrollView.contentOffset = CGPointMake(0, 0);
    _bgScrollView.bounces = NO;
    //    _bgScrollView.backgroundColor = [UIColor blueColor];
    _bgScrollView.pagingEnabled = NO;
    _bgScrollView.delegate = self;
    _bgScrollView.tag = 99;
    _bgScrollView.scrollEnabled = NO;
    [_bgImg addSubview:_bgScrollView];
    
    [self setInboxUI];
    _manager = [[BulletManager alloc] init];
    self.manager.generateViewBlock = ^(BulletView *view) {
        [wSelf addBulletView:view];
    };
    
    [self setRelpyUI];
    
    UIFont *titleFont = [UIFont systemFontOfSize:17];
    TKSegementedItemStatus *compositeNormal = [TKSegementedItemStatus statusWithTitle:@"Inbox" titleColor:[UIColor whiteColor] titleFont:titleFont image:nil backgroundImage:nil becomeCurrentStatusBlock:^{
        NSLog(@"Inbox默认状态");
    }];
    TKSegementedItemStatus *compositeSelected = [TKSegementedItemStatus statusWithTitle:@"Inbox" titleColor:RGB(212, 39, 82)  titleFont:titleFont image:nil backgroundImage:nil becomeCurrentStatusBlock:^{
        NSLog(@"Inbox刚刚被选中");
        
        [wSelf.bgScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        [wSelf.iNtableView reloadData];
    }];
    TKSegementedItem *compositeItem = [TKSegementedItem itemWithNormalStatus:compositeNormal selectedStatus:compositeSelected otherStatus:nil];
    
    TKSegementedItemStatus *volumeNormal = [TKSegementedItemStatus statusWithTitle:@"Reply" titleColor:[UIColor whiteColor] titleFont:titleFont image:nil backgroundImage:nil becomeCurrentStatusBlock:^{
        NSLog(@"Reply默认状态");
    }];
    TKSegementedItemStatus *volumeSelected = [TKSegementedItemStatus statusWithTitle:@"Reply" titleColor:RGB(212, 39, 82) titleFont:titleFont image:nil backgroundImage:nil becomeCurrentStatusBlock:^{
        NSLog(@"Reply刚刚被选中");
        
        [wSelf.bgScrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:NO];
        [wSelf.rEtableView reloadData];
        
    }];
    TKSegementedItem *volumeItem = [TKSegementedItem itemWithNormalStatus:volumeNormal selectedStatus:volumeSelected otherStatus:nil];
    
    // 分节view
    TKSegementedView *view = [TKSegementedView segementedViewWithSegementedItem:compositeItem, volumeItem, nil];
    view.verticalDividerInset = UIEdgeInsetsMake(10, 0, 10, 0);
    [self.bgView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wSelf.bgView.mas_bottom).offset(0);
        make.centerX.equalTo(wSelf.bgView);
        make.width.offset(140);
        make.height.offset(44);
    }];
    
    _leftNavBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_leftNavBtn setImage:[UIImage imageNamed:@"home-my"] forState:(UIControlStateNormal)];
    [_leftNavBtn  addTarget:self action:@selector(leftNavAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_bgView addSubview:_leftNavBtn];
    [_leftNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.bgView).offset(10);
        make.centerY.equalTo(wSelf.bgView.mas_top).offset(42);
        make.width.offset(28);
        make.height.offset(30);
    }];
    
    
    
    //    _showView = [[ChooseJNView alloc] init];
    //    _showView.alpha = 1;
    //    _showView.hidden = YES;
    //    [_showView.pictureButton addTarget:self action:@selector(picActionPlay) forControlEvents:(UIControlEventTouchUpInside)];
    //    [_showView.videoButton addTarget:self action:@selector(videoActionPlay) forControlEvents:(UIControlEventTouchUpInside)];
    //    [self.view addSubview:_showView];
    //    [_showView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.bottom.equalTo(wSelf.view.mas_bottom).offset(-50);
    //        make.centerX.equalTo(wSelf.view);
    //        make.height.offset(kScreenHeight);
    //        make.width.offset(kScreenWidth);
    //
    //    }];
}

- (void)setInboxUI{
    
    ______WS();
    
  
    
    _iNtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 110) style:(UITableViewStyleGrouped)];
    //    _iNtableView.userInteractionEnabled = YES;
    _iNtableView.backgroundColor = [UIColor clearColor];
    _iNtableView.delegate = self;
    _iNtableView.dataSource = self;
    _iNtableView.tag = 100;
    [_iNtableView setSeparatorColor:[UIColor clearColor]];
    _iNtableView.tableFooterView = [[UIView alloc] init];
    [_bgScrollView addSubview:_iNtableView];
    
//    _imgView = [[UIImageView alloc] init];
//    //        _imgView.frame = CGRectMake(0, 400, kScreenWidth, 200);
//    //    _imgView.image = [UIImage imageNamed:@"banner"];
//    _imgView.userInteractionEnabled = YES;
//    [self.iNtableView addSubview:_imgView];
//    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        //        make.left.equalTo(wSelf.bgView).offset(10);
//        make.bottom.equalTo(wSelf.view.mas_bottom).offset(-59);
//        make.width.offset(kScreenWidth);
//        make.height.offset(200);
//        //        ma
//    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    tap.cancelsTouchesInView = NO;
    
    
    _bulletBgView = [[BulletBackGroundView alloc] init];
    _bulletBgView.userInteractionEnabled = YES;
//    _bulletBgView.frame = CGRectMake(0, 0, kScreenWidth, 200);
    [self.iNtableView addSubview:_bulletBgView];
    [_bulletBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(0);
        make.right.equalTo(wSelf.view.mas_right).offset(0);
        make.bottom.equalTo(wSelf.view.mas_bottom).offset(-44);
        make.height.offset(200);
    }];
    
    [_bulletBgView addGestureRecognizer:tap];

    
    [_iNtableView registerClass:[DynamicCell class] forCellReuseIdentifier:@"inboxCell"];
    [_iNtableView registerClass:[EmtyCell class] forCellReuseIdentifier:@"emtyCell"];
    
}


- (void)setRelpyUI {
    _rEtableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - 110) style:(UITableViewStyleGrouped)];
    _rEtableView.delegate = self;
    _rEtableView.dataSource = self;
    [_rEtableView setSeparatorColor:[UIColor clearColor]];
    _rEtableView.backgroundColor = [UIColor clearColor];
    _rEtableView.tag = 101;
    _rEtableView.tableFooterView = [[UIView alloc] init];
    [_bgScrollView addSubview:_rEtableView];
    [_rEtableView registerClass:[DynamicCell class] forCellReuseIdentifier:@"replyCell"];
    [_rEtableView registerClass:[EmtyCell class] forCellReuseIdentifier:@"emtyCell"];
    
}


#pragma mark --- 弹幕数据 And 个人信息数据
- (void)loadData {
    ______WS();
    
    NSDictionary *dictDM = @{@"token":_userDict[@"token"],
                             @"userid":_userDict[@"userid"]};
    [[DJHttpApi shareInstance] POST:recommenUrl dict:dictDM succeed:^(id data) {
        if ([[NSString stringWithFormat:@"%@",data[@"rspCode" ]] isEqualToString:@"10012"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOutNotic" object:self];
            NSLog(@"token错误");
        }else{
            if (data[@"rspObject"] != nil) {
                for (NSDictionary *dic in data[@"rspObject"]) {
                    DynamicModel *model = [[DynamicModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    [wSelf.recommArr addObject:model];
                }
                //                NSArray *arrRemmUser = data[@"rspObject"];
                if (wSelf.recommArr.count != 0) {
                    [wSelf.manager.dataSouce removeAllObjects];
                    [wSelf.manager.dataSouce addObjectsFromArray:wSelf.recommArr];
                    [wSelf.manager start];
                }
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)loadGrRenData{
    ______WS();
    _userDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSDictionary *dict = @{@"token":_userDict[@"token"],
                           @"userid":_userDict[@"userid"]};
    [[DJHttpApi shareInstance] POST:GetUserInfo dict:dict succeed:^(id data) {
        
        if ([[NSString stringWithFormat:@"%@",data[@"rspCode" ]] isEqualToString:@"10012"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOutNotic" object:self];
            NSLog(@"token错误");
        }else{
            NSDictionary *user = data[@"rspObject"];
            NSDictionary *attr = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
            CGFloat width = [[NSString stringWithFormat:@"%@",user[@"coin"]] sizeWithAttributes:attr].width;
            
            [wSelf.pointLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(wSelf.bgView.mas_right).offset(-5);
                make.centerY.equalTo(wSelf.leftNavBtn);
                make.width.offset(width + 2);
                make.height.offset(24);
            }];
            wSelf.pointLab.text = [NSString stringWithFormat:@"%@",user[@"coin"]];
            
            
            [ wSelf.rightNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(wSelf.pointLab.mas_left).offset(-3);
                make.centerY.equalTo(wSelf.leftNavBtn);
                make.width.offset(16);
                make.height.offset(16);
            }];
            
        }
        
    } failure:^(NSError *error) {
    }];
    
}



#pragma mark --- 通知处理
- (void)loginOutAction:(NSNotification *)notic{
    
    LoginViewController *logVC = [[LoginViewController alloc] init];
    UINavigationController *vc = [[UINavigationController alloc] initWithRootViewController:logVC];
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        [[DJHManager shareManager] toastManager:@"This account login in other equipment" superView:windowKey];
    }
    [self.navigationController presentViewController:vc animated:YES completion:nil];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


- (void)tanchuan:(NSNotification *)notic{
    //    if (_plusButtnEnable) {
    //        _showView.hidden = NO;
    //        _plusButtnEnable = NO;
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"changePlusBtnImg" object:@"Yes"];
    //        //        [NSNotificationCenter defaultCenter]  post
    //    }else{
    //        _showView.hidden = YES;
    //        _plusButtnEnable = YES;
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"changePlusBtnImg" object:@"No"];
    //    }
    MARFaceBeautyController *marVC = [[MARFaceBeautyController alloc] init];
    [self.navigationController presentViewController:marVC animated:YES completion:nil];
    
}

- (void)notificationAction:(NSNotification *)notiction{
    if (notiction.userInfo) {
        UIImage *data = notiction.userInfo[@"img"];
        self.hidesBottomBarWhenPushed = YES;
        MessageController *messVC = [[MessageController alloc] init];
        messVC.image = data;
        [self.navigationController pushViewController:messVC animated:NO];
        self.hidesBottomBarWhenPushed = NO;
    }else{
        self.hidesBottomBarWhenPushed = YES;
        MessageController *messVC = [[MessageController alloc] init];
        [self.navigationController pushViewController:messVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}

- (void)notificationUpdate:(NSNotification *)notiction{
    NSDictionary *dicMessage = notiction.userInfo;
    [dicMessage setValue:@"text" forKey:@"messageType"];
    NSString *title = [NSString stringWithFormat:@"我向%@赠送了%@金币",dicMessage[@"targetname"],dicMessage[@"price"]];
    [dicMessage setValue:title forKey:@"nickname"];
    DynamicModel *model = [[DynamicModel alloc] init];
    [model setValuesForKeysWithDictionary:dicMessage];
    [_replyArr insertObject:dicMessage atIndex:0];
    //    [_replyArr addObject:model];
    [_rEtableView reloadData];
}


- (void)notificationPicPush:(NSNotification *)notiction{
    NSData *data = notiction.userInfo[@"img"];
    self.hidesBottomBarWhenPushed = YES;
    MessageController *messVC = [[MessageController alloc] init];
    messVC.data = data;
    [self.navigationController pushViewController:messVC animated:NO];
    self.hidesBottomBarWhenPushed = NO;
}


- (void)dealloc {
    NSLog(@"%@ : 控制器已经销毁",self);
    [[NSNotificationCenter defaultCenter] removeObserver:@"pushNoticHome"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"postUpdateMessage"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"pushPicHome"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"tanchuanHome"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"loginOutNotic"];
}



#pragma mark --- 其他___
- (void)tapHandler:(UITapGestureRecognizer *)gesture {
    [self.bulletBgView dealTapGesture:gesture block:^(BulletView *bulletView){
        self.hidesBottomBarWhenPushed = YES;
        DanMuRemcoController *vc = [[DanMuRemcoController alloc] init];
        for (int i = 0; i < self.recommArr.count; i++) {
            DynamicModel *model = _recommArr[i];
            if ([bulletView.lbNickname.text isEqualToString:model.nickname]) {
                vc.iCarouselindex = i;
            }
        }
        vc.dataArr = _recommArr;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }];
}


- (void)addBulletView: (BulletView *)view {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    view.frame = CGRectMake(width,  view.trajectory * 49,CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    [_bulletBgView addSubview:view];
    [view startANnimation];
}



//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
//    NSData *imageData = [NSKeyedArchiver archivedDataWithRootObject:image];
//    NSDictionary *dic = @{@"img":imageData};
//    [[NSNotificationCenter defaultCenter] postNotificationName:[[NSUserDefaults standardUserDefaults] objectForKey:@"postPic"] object:self userInfo:dic];
//    [self dismissViewControllerAnimated:YES completion:nil];
//
//}



//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//
//    [self dismissViewControllerAnimated:YES completion:nil];
//
//}


#pragma mark ---- 自定义 Delegate

//- (void)jumpAction{
//
//    self.hidesBottomBarWhenPushed = YES;
//    DanMuRemcoController *vc = [[DanMuRemcoController alloc] init];
//    vc.dataArr = _recommArr;
//    [self.navigationController pushViewController:vc animated:YES];
//    self.hidesBottomBarWhenPushed = NO;
//
//}



-(void)setViewControl:(NSIndexPath *)indexPath
{
    self.hidesBottomBarWhenPushed=YES;
    HisViewController *vc = [[HisViewController alloc] init];
    if (_bgScrollView.contentOffset.x == kScreenWidth) {
        vc.model = _replyArr[indexPath.section];
        
    }else{
        vc.model = _dataArr[indexPath.section];
        
    }
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}


#pragma mark ---- tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ((tableView.tag == 100)) {
        if (_dataArr.count == 0) {
            return 1;
        }else{
            return 1;
        }
    }else{
        if (_replyArr.count == 0) {
            return 1;
        }else{
            return 1;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ((tableView.tag == 100)) {
        //        if (_dataArr.count == 0) {
        
        return _dataArr.count;
        //        }
    }else{
        //        if (_replyArr.count == 0) {
        return _replyArr.count;
        
        //        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 7;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    //    return 12;//这个方法不写，或者return 0跟return 12的效果一样
    return 0.00001;//把高度设置很小，效果可以看成footer的高度等于0
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 100) {
        if (_dataArr.count == 0) {
            EmtyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"emtyCell" forIndexPath:indexPath];
            tableView.separatorStyle = NO;
            cell.userInteractionEnabled = NO;
            return cell;
        }else{
            DynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inboxCell" forIndexPath:indexPath];
            cell.headImg.userInteractionEnabled = YES;
            cell.Delegate = self;
            if (_dataArr.count > 0) {
                [cell setInboxCellWithModel:_dataArr[indexPath.section] indexPath:indexPath];
                
            }
            return cell;
        }
        
    }else {
        if (_replyArr.count == 0) {
            EmtyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"emtyCell" forIndexPath:indexPath];
            tableView.separatorStyle = NO;
            cell.userInteractionEnabled = NO;
            return cell;
        }else{
            DynamicCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"replyCell" forIndexPath:indexPath];
            cell.headImg.userInteractionEnabled = YES;
            cell.Delegate = self;
            if (_replyArr.count > 0) {
                [cell setRelpyCellWithModel:_replyArr[indexPath.section] indexPath:indexPath];
                
            }
            return cell;
        }
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((tableView.tag == 100)) {
        if (_dataArr.count == 0) {
            return 300;
        }
        else{
            return 64;
        }
    }else{
        if (_replyArr.count == 0) {
            return 300;
        }
        else{
            return 64;
        }
    }
}

//- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewRowAction *likeAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"喜欢" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        // 实现相关的逻辑代码
//        // ...
//        // 在最后希望cell可以自动回到默认状态，所以需要退出编辑模式
//        tableView.editing = NO;
//    }];
//
////    likeAction.
//
//    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        // 首先改变model
////        [self.books removeObjectAtIndex:indexPath.row];
//        // 接着刷新view
////        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        // 不需要主动退出编辑模式，上面更新view的操作完成后就会自动退出编辑模式
//    }];
//
//    return @[deleteAction, likeAction];
//}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 100) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            DynamicModel *model = _dataArr[indexPath.section];
            [_dataArr removeObjectAtIndex:indexPath.section];
            [[EMClient sharedClient].chatManager deleteConversation:model.conversationId isDeleteMessages:YES completion:^(NSString *aConversationId, EMError *aError){
                //code
                EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:aConversationId type:EMConversationTypeChat createIfNotExist:YES];
                [conversation deleteMessageWithId:model.messageId error:nil];
                
            }];
            
            //            [_iNtableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [_iNtableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
            //            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationLeft];
        }
        [_iNtableView reloadData];
        
    }else{
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            DynamicModel *model = _replyArr[indexPath.section];
            [_replyArr removeObjectAtIndex:indexPath.section];
            //            [_rEtableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [[EMClient sharedClient].chatManager deleteConversation:model.conversationId isDeleteMessages:YES completion:^(NSString *aConversationId, EMError *aError){
                //code
                EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:aConversationId type:EMConversationTypeChat createIfNotExist:YES];
                [conversation deleteMessageWithId:model.messageId error:nil];
                
            }];
            [_rEtableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
            //            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationLeft];
        }
        [_rEtableView reloadData];
    }
}


-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"Delete";
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 100) {
        
        DynamicModel *model = _dataArr[indexPath.section];
        self.hidesBottomBarWhenPushed=YES;
        VideoPlayController *videoVC = [[VideoPlayController alloc] init];
        videoVC.model = model;
        [self.navigationController pushViewController:videoVC animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }else {
        
        DynamicModel *model = _replyArr[indexPath.section];
        self.hidesBottomBarWhenPushed=YES;
        VideoPlayController *videoVC = [[VideoPlayController alloc] init];
        videoVC.model = model;
        [self.navigationController pushViewController:videoVC animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
}


#pragma mark ---- 自定义方法
//- (void)picActionPlay{
//    NSLog(@"--------打开拍照--------");
//    _pickContro = [[UIImagePickerController alloc] init];
//    _pickContro.sourceType = UIImagePickerControllerSourceTypeCamera;
//    _pickContro.delegate = self;
//    _pickContro.allowsEditing = NO;
//    [self presentViewController:_pickContro animated:YES completion:nil];
//}
//
//- (void)videoActionPlay{
//    NSLog(@"--------打开拍摄--------");
//    CeshiViewController *vc = [[CeshiViewController alloc] init];
//    //    NSLog(@"%@",self.navigationController);
//    [self presentViewController:vc animated:YES completion:nil];
//}



- (void)rightNavAction {
    
    self.hidesBottomBarWhenPushed=YES;
    PayMentController *vc = [[PayMentController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed=NO;
    
}

- (void)leftNavAction {
    self.hidesBottomBarWhenPushed=YES;
    MeViewController *me = [[MeViewController alloc] init];
    [self.navigationController pushViewController:me animated:YES];
    self.hidesBottomBarWhenPushed=NO;
    
}

#pragma mark --- ------定位方法------

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *currLocation=[locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];//反向解析，根据及纬度反向解析出地址
    CLLocation *location = [locations objectAtIndex:0];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        for(CLPlacemark *place in placemarks)
        {
            //取出当前位置的坐标
            NSLog(@"latitude : %f,longitude: %f",currLocation.coordinate.latitude,currLocation.coordinate.longitude);
            NSString *latStr = [NSString stringWithFormat:@"%f",currLocation.coordinate.latitude];
            NSString *lngStr = [NSString stringWithFormat:@"%f",currLocation.coordinate.longitude];
            NSDictionary *dict = [place addressDictionary];
            NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] init];
            [resultDic setObject:dict[@"SubLocality"] forKey:@"xian"];
            [resultDic setObject:dict[@"City"] forKey:@"shi"];
            [resultDic setObject:latStr forKey:@"wei"];
            [resultDic setObject:lngStr forKey:@"jing"];
            [resultDic setObject:dict[@"State"] forKey:@"sheng"];
            [resultDic setObject:dict[@"Name"] forKey:@"all"];
            NSLog(@"------addressDictionary-%@------",dict);
            [[NSUserDefaults standardUserDefaults] setObject:dict[@"SubLocality"] forKey:@"XianUser"];
            [[NSUserDefaults standardUserDefaults] setObject:resultDic forKey:@"LocationInfo"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
    }];
    
    
    [_locationManager stopUpdatingLocation];
    
}
#pragma mark - 检测应用是否开启定位服务
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [manager stopUpdatingLocation];
    switch([error code]) {
        case kCLErrorDenied:
            break;
        case kCLErrorLocationUnknown:
            break;
        default:
            break;
    }
}


//获取定位信息
-(void)getUSerLocation{
    //初始化定位管理类
    _locationManager = [[CLLocationManager alloc] init];
    //delegate
    _locationManager.delegate = self;
    //The desired location accuracy.//精确度
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //Specifies the minimum update distance in meters.
    //距离
    _locationManager.distanceFilter = 10;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager requestAlwaysAuthorization];
        
    }
    //开始定位
    [_locationManager startUpdatingLocation];
    
    
}



#pragma mark ------- 环信接收信息,处理信息方法
- (void)didReceiveMessages:(NSArray *)aMessages {
    
    
    for (EMMessage *message in aMessages) {
        EMMessageBody *msgBody = message.body;
        NSDictionary *ext = message.ext;
        switch (msgBody.type) {
            case EMMessageBodyTypeText:
            {
                // 收到的文字消息
                EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
                NSString *txt = textBody.text;
                NSLog(@"收到的文字是 ----- %@",txt);
                [_modelDic setObject:@"text" forKey:@"messageType"];
                [_modelDic setObject:message.messageId forKey:@"messageId"];
                [_modelDic setObject:message.conversationId forKey:@"conversationId"];
                
            }
                break;
            case EMMessageBodyTypeImage:
            {
                // 得到一个图片消息body
                EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
                _imageRemote = body.remotePath;
                _imagelocation = body.localPath;
                //                NSLog(@"大图remote路径 -- %@"   ,body.remotePath);
                //                NSLog(@"大图local路径 -- %@"    ,body.localPath); // // 需要使用sdk提供的下载方法后才会存在
                //                NSLog(@"大图的secret -- %@"    ,body.secretKey);
                //                NSLog(@"大图的W -- %f ,大图的H -- %f",body.size.width,body.size.height);
                //                NSLog(@"大图的下载状态 -- %u",body.downloadStatus);
                // 缩略图sdk会自动下载
                //                NSLog(@"小图remote路径 -- %@"   ,body.thumbnailRemotePath);
                //                NSLog(@"小图local路径 -- %@"    ,body.thumbnailLocalPath);
                //                NSLog(@"小图的secret -- %@"    ,body.thumbnailSecretKey);
                //                NSLog(@"小图的W -- %f ,大图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height);
                //                NSLog(@"小图的下载状态 -- %u",body.thumbnailDownloadStatus);
                // 加入到model字典中
                [_modelDic setObject:_imageRemote forKey:@"imageRemote"];
                [_modelDic setObject:_imagelocation forKey:@"localPath"];
                [_modelDic setObject:@"image" forKey:@"messageType"];
                [_modelDic setObject:message.messageId forKey:@"messageId"];
                [_modelDic setObject:message.conversationId forKey:@"conversationId"];
                
            }
                break;
            case EMMessageBodyTypeLocation:
            {
                EMLocationMessageBody *body = (EMLocationMessageBody *)msgBody;
                //                NSLog(@"纬度-- %f",body.latitude);
                //                NSLog(@"经度-- %f",body.longitude);
                //                NSLog(@"地址-- %@",body.address);
            }
                break;
            case EMMessageBodyTypeVoice:
            {
                // 音频sdk会自动下载
                //                EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
                //                NSLog(@"音频remote路径 -- %@"      ,body.remotePath);
                //                NSLog(@"音频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在（音频会自动调用）
                //                NSLog(@"音频的secret -- %@"        ,body.secretKey);
                //                NSLog(@"音频文件大小 -- %lld"       ,body.fileLength);
                //                NSLog(@"音频文件的下载状态 -- %u"   ,body.downloadStatus);
                //                NSLog(@"音频的时间长度 -- %d"      ,body.duration);
            }
                break;
            case EMMessageBodyTypeVideo:
            {
                EMVideoMessageBody *body = (EMVideoMessageBody *)msgBody;
                _videoRemote = body.remotePath;
                _videoImgRomote = body.thumbnailRemotePath;
                _location = body.localPath;
                //                NSLog(@"视频local路径 -- %@",body.localPath); // 需要使用sdk提供的下载方法后才会存在
                //                NSLog(@"视频remote路径 -- %@"      ,body.remotePath);
                //                NSLog(@"视频的secret -- %@"        ,body.secretKey);
                //                NSLog(@"视频文件大小 -- %lld"       ,body.fileLength);
                //                NSLog(@"视频文件的下载状态 -- %u"   ,body.downloadStatus);
                //                NSLog(@"视频的时间长度 -- %d"      ,body.duration);
                //                NSLog(@"视频的W -- %f ,视频的H -- %f", body.thumbnailSize.width, body.thumbnailSize.height);
                
                // 缩略图sdk会自动下载
                //                NSLog(@"缩略图的remote路径 -- %@"     ,body.thumbnailRemotePath);
                //                NSLog(@"缩略图的local路径 -- %@"      ,body.thumbnailLocalPath);
                //                NSLog(@"缩略图的secret -- %@"        ,body.thumbnailSecretKey);
                //                NSLog(@"缩略图的下载状态 -- %u"      ,body.thumbnailDownloadStatus);
                [_modelDic setObject:_videoRemote forKey:@"videoRemote"];
                [_modelDic setObject:_videoImgRomote forKey:@"imageRemote"];
                [_modelDic setObject:_location forKey:@"localPath"];
                [_modelDic setObject:@"video" forKey:@"messageType"];
                [_modelDic setObject:message.messageId forKey:@"messageId"];
                [_modelDic setObject:message.conversationId forKey:@"conversationId"];
            }
                break;
            case EMMessageBodyTypeFile:
            {
                EMFileMessageBody *body = (EMFileMessageBody *)msgBody;
                NSLog(@"文件remote路径 -- %@"      ,body.remotePath);
                NSLog(@"文件local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
                NSLog(@"文件的secret -- %@"        ,body.secretKey);
                NSLog(@"文件文件大小 -- %lld"       ,body.fileLength);
                NSLog(@"文件文件的下载状态 -- %u"   ,body.downloadStatus);
            }
                break;
            default:
                break;
        }
        [_modelDic setObject:message forKey:@"message"];
        
        // 消息中的扩展属性
        [_modelDic addEntriesFromDictionary:ext];
        //NSLog(@"%@",modelDic);
        DynamicModel *model = [[DynamicModel alloc] init];
        [model setValuesForKeysWithDictionary:_modelDic];
        model.isRead = message.isRead;
        if (!message.isRead) {
            self.unReadCount = self.unReadCount+1;
        }
        if ([model.typeMessage isEqualToString:@"1"]) {
            if (message.direction == EMMessageDirectionReceive) {
                [_replyArr addObject:model];
                NSLog(@"%@",model.hxAccount);
                [_rEtableView reloadData];
            }
        }else{
            if (message.direction == EMMessageDirectionReceive) {
                [_dataArr addObject:model];
                NSLog(@"%@",model.hxAccount);
                
                [_iNtableView reloadData];
            }
        }
    }
    [self setupUnreadMessageCount];
}

// 环信方法
// 统计未读消息数
- (void)setupUnreadMessageCount {
    //    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    //    NSInteger unreadCount = 0;
    //    for (EMConversation *conv in conversations) {
    //        unreadCount += conv.unreadMessagesCount;
    //    }
    //    if (unreadCount > 0 && _dataArr.count > 0) {
    //        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",(int)unreadCount];
    //    }else {
    //        self.tabBarItem.badgeValue = nil;
    //    }
    if (self.unReadCount != 0) {
        //        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",(int)self.unReadCount];
        [self.tabBarItem showBadge];
        //        self.tabBarItem.badgeColor = [UIColor redColor];
    }else{
        self.tabBarItem.badgeValue = nil;
        //        [self.tabBarItem clearBadge];
        
    }
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:self.unReadCount];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    //    if (!_plusButtnEnable) {
    //        _showView.hidden = YES;
    //        _plusButtnEnable = YES;
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"changePlusBtnImg" object:@"No"];
    //    }
}

#pragma mark --- View 视图出现
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ______WS();
    [[NSUserDefaults standardUserDefaults] setObject:@"home" forKey:@"typeBrod"];
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    NSTimeInterval intervalbefore = interval - 24 * 60 * 60 * 2 * 1000;
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    self.unReadCount = 0;
    [_replyArr removeAllObjects];
    [_dataArr removeAllObjects];
    for (EMConversation *conv in conversations) {
        
        [conv loadMessagesFrom:intervalbefore to:interval count:200 completion:^(NSArray *aMessages, EMError *aError) {
            [wSelf didReceiveMessages:aMessages];
            
        }];
    }
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@"pushNoticHome" forKey:@"postHome"];
    [[NSUserDefaults standardUserDefaults] setObject:@"pushPicHome" forKey:@"postPic"];
    [[NSUserDefaults standardUserDefaults] setObject:@"tanchuanHome" forKey:@"tanchuan"];
    self.navigationController.navigationBar.hidden = YES;
    self.hidesBottomBarWhenPushed = NO;
    
    [self.recommArr removeAllObjects];
    [self loadData];
    [self loadGrRenData];
    
}

- (void)tapCellDIY{
    NSLog(@"点击了cell");
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.manager stop];
    
}

@end
