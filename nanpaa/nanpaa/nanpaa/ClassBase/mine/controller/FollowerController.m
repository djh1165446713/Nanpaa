//
//  FollowerController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/8.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "FollowerController.h"
#import "FollowerCell.h"
#import "DynamicModel.h"
#import "FollowSonView.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "HisViewController.h"
#import "ShareHelpManage.h"
#import "DanMuRemcoController.h"
@interface FollowerController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation FollowerController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = [NSMutableArray array];
    self.titleLabel.text = @"Follower";
    [self initUI];
    [self loadData];
}



- (void)initUI{
    FollowSonView *view = [[FollowSonView alloc] init];
    view.frame = CGRectMake(0, 0, kScreenWidth, 200);
    [view.shareButton addTarget:self action:@selector(shareAction) forControlEvents:(UIControlEventTouchUpInside)];
    [view.recommendButton addTarget:self action:@selector(recommendAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 60;
    _tableView.tableFooterView = view;
    [_tableView setSeparatorColor:RGB(102, 102, 102)];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[FollowerCell class] forCellReuseIdentifier:@"FollowerCell"];
}


- (void)loadData {
    ______WS();
    NSDictionary *par = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSDictionary *par1 =@{@"token":par[@"token"],
                          @"userid":par[@"userid"]};
    [[DJHttpApi shareInstance] POST:GetFollowIngUrl dict:par1 succeed:^(id data) {
        NSLog(@"%@:---%@",self,data);
        NSArray *arr = data[@"rspObject"];
        for (NSDictionary *dic in arr) {
            DynamicModel *model = [[DynamicModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [wSelf.dataArr addObject:model];
        }
        [wSelf.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}



#pragma mark --- tableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FollowerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FollowerCell" forIndexPath:indexPath];
    DynamicModel *model = _dataArr[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setSeparatorInset:UIEdgeInsetsZero];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DynamicModel *model = _dataArr[indexPath.row];
    self.hidesBottomBarWhenPushed = YES;
    HisViewController *vc = [[HisViewController alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;

}

#pragma mark -------------------自定义方法--------------------

- (void)shareAction{
    [[ShareHelpManage shareInstance] shareSDKarray:nil shareText:shareInput shareURLString:shareURL shareTitle:shareTitText];

}

- (void)recommendAction{
    self.hidesBottomBarWhenPushed = YES;
    DanMuRemcoController *vc = [[DanMuRemcoController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark --- view方法
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}



@end
