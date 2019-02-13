
//
//  FollowingController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/8.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "FollowingController.h"
#import "HisViewController.h"
#import "DynamicModel.h"
#import "FollowingCell.h"

@interface FollowingController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation FollowingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    [self loadData];
    _dataArr = [NSMutableArray array];
    self.titleLabel.text = @"Following";
    
}

- (void)initUI{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 60;
    [_tableView setSeparatorColor:RGB(102, 102, 102)];
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[FollowingCell class] forCellReuseIdentifier:@"FollowingCell"];
}


- (void)loadData {
    ______WS();
    NSDictionary *par = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSDictionary *par1 =@{@"token":par[@"token"],
                          @"userid":par[@"userid"]};
    [[DJHttpApi shareInstance] POST:GetFollowIngUrl dict:par1 succeed:^(id data) {
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
    FollowingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FollowingCell" forIndexPath:indexPath];
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


#pragma mark --- 自定义方法
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
