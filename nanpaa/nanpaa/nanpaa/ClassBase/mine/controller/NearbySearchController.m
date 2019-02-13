//
//  NearbySearchController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/7.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "NearbySearchController.h"
#import "DynamicModel.h"
#import "SearchTabCell.h"
#import "HisViewController.h"
#import "NearbyView.h"
@interface NearbySearchController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIView *bgView;
@end

@implementation NearbySearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataArr = [NSMutableArray array];
    
    self.view.backgroundColor = RGB(18, 21, 33);
    ______WS();

    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = RGB(38, 42, 74);
    _bgView.userInteractionEnabled = YES;
    [self.view addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(0);
        make.width.offset(kScreenWidth);
        make.top.equalTo(wSelf.view).offset(0);
        make.height.offset(64);
    }];
    
    UITapGestureRecognizer *tapDelete = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDeleteAction)];
    NearbyView *view = [[NearbyView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 60, 64)];
    view.tag = 1005;
    view.searchText.delegate = self;
    view.searchText.userInteractionEnabled = YES;
    [view.searchText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [view.rightImg addGestureRecognizer:tapDelete];
    [self.bgView addSubview:view];
    
    _cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _cancelBtn.backgroundColor = RGB(38, 42, 74);
    [_cancelBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_cancelBtn setTitle:@"Cancel" forState:(UIControlStateNormal)];
    [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.bgView addSubview:_cancelBtn ];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.bgView.mas_right).offset(-10);
        make.height.offset(30);
        make.bottom.equalTo(wSelf.bgView.mas_bottom).offset(-8);

    }];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = RGB(18, 21, 33);
    _tableView.rowHeight = 60;
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView registerClass:[SearchTabCell class] forCellReuseIdentifier:@"searchCell"];
    [self.view addSubview:_tableView];
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    NearbyView *view = [self.view viewWithTag:1005];
    [view.searchText becomeFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NearbyView *view = [self.view viewWithTag:1005];
    view.titleLab.hidden = YES;
    view.iconImg.hidden = YES;
    view.leftImg.hidden = NO;
    view.rightImg.hidden = NO;
    return YES;
}


-(void)textFieldDidChange :(UITextField *)theTextField{
    ______WS();
    NSDictionary *messgeDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    // 请求数据
    NSDictionary *dict = @{@"searchText":theTextField.text,
                           @"token":messgeDic[@"token"],
                           @"userid":messgeDic[@"userid"]};
    [[DJHttpApi shareInstance] POST:Sear1chUrl dict:dict succeed:^(id data) {
        [_dataArr removeAllObjects];
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

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NearbyView *view = [self.view viewWithTag:1005];
    if (view.searchText.text == nil) {
        view.titleLab.hidden = NO;
        view.iconImg.hidden = NO;
        view.leftImg.hidden = YES;
    }
}


- (void)tapDeleteAction{
    NearbyView *view = [self.view viewWithTag:1005];
    view.searchText.text = @"";
}



#pragma mark ------- tableviewDelegate ------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell" forIndexPath:indexPath];
    cell.model = _dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.hidesBottomBarWhenPushed = YES;
    HisViewController *vc = [[HisViewController alloc] init];
    DynamicModel *model = _dataArr[indexPath.row];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}


- (void)cancelAction {
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)dealloc {
    NSLog(@"search没有消失");
}

@end
