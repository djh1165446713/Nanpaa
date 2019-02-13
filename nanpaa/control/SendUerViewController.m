//
//  SendUerViewController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/19.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "SendUerViewController.h"
#import "ColleView.h"
#import "KBTabbarController.h"
#import "RecommendModel.h"

@interface SendUerViewController ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *leftNavBtn;
@property (nonatomic, strong) UILabel *titleLabel;;
@property (nonatomic, strong) UIImageView *bgImg;
@property (nonatomic, strong) UIButton *overButton;
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) ColleView *cView;
@property (nonatomic, strong) UIButton *allFowlloBtn;
@property (nonatomic, strong) UIButton *okButton;

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *idDataArr;

@end

@implementation SendUerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"sendUser_success"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(delectUserAction:) name:@"cancelUserPost" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addUserAction:) name:@"addUserPost" object:nil];
    
    _dataArr = [NSMutableArray array];
    _idDataArr = [NSMutableArray array];
    
    [self initUI];
    [self loadData];
}


- (void)initUI {
    ______WS();
    _bgImg = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds ];
    _bgImg.image = [UIImage imageNamed:@"bigpic"];
    [self.view addSubview:_bgImg];
    
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
    _titleLabel.font = [UIFont systemFontOfSize:20];
    _titleLabel.text = @"Recommend";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.bgView);
        make.centerY.equalTo(wSelf.bgView);
        make.top.equalTo(wSelf.bgView).offset(15);
        make.width.offset(100);
        make.height.offset(34);
    }];
    
    _leftNavBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_leftNavBtn setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
    [_leftNavBtn  addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_bgView addSubview:_leftNavBtn];
    [_leftNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.bgView).offset(15);
        make.centerY.equalTo(wSelf.bgView);
        make.width.offset(15);
        make.height.offset(20);
    }];
    
    
    _iconImg = [[UIImageView alloc] init];
    _iconImg.image = [UIImage imageNamed:@"NANPAA"];
    [self.view addSubview:_iconImg];
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.top.equalTo(wSelf.bgView.mas_bottom).offset(10);
        make.height.offset(80);
        make.width.offset(100);
    }];
    
    
    _cView = [[ColleView alloc] initWithFrame:CGRectMake(12, 200, kScreenWidth - 24, kScreenHeight - 249)];
    [self.view addSubview:_cView];
    
    
    _allFowlloBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _allFowlloBtn.layer.masksToBounds = YES;
    _allFowlloBtn.layer.cornerRadius = 10;
    [_allFowlloBtn addTarget:self action:@selector(allFowllowAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_allFowlloBtn setTitle:@"Follow All" forState:(UIControlStateNormal)];
    _allFowlloBtn.backgroundColor = RGB(209, 38, 71);
    [self.view addSubview:_allFowlloBtn];
    [_allFowlloBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.iconImg);
        make.bottom.equalTo(wSelf.cView.mas_top).offset(20);
        make.height.equalTo(@40);
        make.width.offset(wSelf.cView.width / 3);
    }];
    
    
    _okButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_okButton setTitle:@"OK" forState:(UIControlStateNormal)];
    [_okButton addTarget:self action:@selector(getMainContro) forControlEvents:(UIControlEventTouchUpInside)];
    _okButton.backgroundColor = RGB(209, 38, 71);
    [self.view addSubview:_okButton];
    [_okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.iconImg);
        make.bottom.equalTo(wSelf.view.mas_bottom).offset(0);
        make.height.equalTo(@50);
        make.width.offset(kScreenWidth);
    }];
}


- (void)loadData {
    ______WS();
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSDictionary *dict = @{@"token":userDic[@"token"],
                           @"userid":userDic[@"userid"]};
    
    [[DJHttpApi shareInstance] POST:recommenUrl dict:dict succeed:^(id data) {
        if (data[@"rspObject"] != nil) {
            for (NSDictionary *dic in data[@"rspObject"]) {
                RecommendModel *model = [[RecommendModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                model.isFollow = YES;
                [wSelf.dataArr addObject:model];
                [wSelf.idDataArr addObject:model.userid];
            }
            wSelf.cView.arrData = wSelf.dataArr;
            [wSelf.cView.collectView reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark --- 通知
- (void)delectUserAction:(NSNotification *)notfic{
    
    NSDictionary *dic = notfic.userInfo;
    NSString *userid = [NSString stringWithFormat:@"%@",dic[@"userid"]];
    
    for (int i = 0; i < self.idDataArr.count; i++) {
        if ([userid isEqualToString:self.idDataArr[i]]) {
            [self.idDataArr removeObjectAtIndex:i];
            break;
        }
    }
}


- (void)addUserAction:(NSNotification *)notfic{
    
    NSDictionary *dic = notfic.userInfo;
    NSString *userid = [NSString stringWithFormat:@"%@",dic[@"userid"]];
    for (int i = 0; i < self.idDataArr.count; i++) {
        if ([userid isEqualToString:self.idDataArr[i]]) {
        }else{
            [self.idDataArr addObject:userid];
            break;
        }
    }
    
}



#pragma mark --- 自定义方法
- (void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)getMainContro {
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSDictionary *par = @{@"targetIds":_idDataArr,
                          @"token":userDic[@"token"],
                          @"userid":userDic[@"userid"]};
    
    [[DJHttpApi shareInstance] POST:AddFollowersUrl dict:par succeed:^(id data) {
        
        KBTabbarController *mainVC = [[KBTabbarController alloc] init];
        self.view.window.rootViewController = mainVC;
        
        //        [self.navigationController pushViewController:mainVC animated:YES];
        
    } failure:^(NSError *error) {
    }];
    
}

- (void)allFowllowAction {
    
    
}


#pragma mark --- 控制器方法

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:@"cancelUserPost"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"addUserPost"];
    NSLog(@"推荐的人 vc 已经销毁");
}




@end
