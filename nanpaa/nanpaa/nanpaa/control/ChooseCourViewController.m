//
//  ChooseCourViewController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/24.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "ChooseCourViewController.h"
#import "CountryModel.h"
#import "ChooseCountryCell.h"
#import "NearbyView.h"
#import "SendUerViewController.h"
@interface ChooseCourViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation ChooseCourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(18, 21, 33);
    ______WS();
    _listTeamsArray = [NSMutableArray array];
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
    
    
    NearbyView *view = [[NearbyView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 60, 64)];
    view.searchText.delegate = self;
    [view.searchText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
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

    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = RGB(18, 21, 33);
    _tableView.rowHeight = 60;
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView registerClass:[ChooseCountryCell class] forCellReuseIdentifier:@"CellIdentifier"];
    [self.view addSubview:_tableView];
    
}



-(void)textFieldDidChange :(UITextField *)theTextField{
    ______WS();
    NSDictionary *messgeDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    // 请求数据
    NSDictionary *dict = @{@"searchText":theTextField.text,
                           @"token":messgeDic[@"token"],
                           @"userid":messgeDic[@"userid"]};
    [[DJHttpApi shareInstance] POST:searchCountryUrl dict:dict succeed:^(id data) {
        if ([[NSString stringWithFormat:@"%@",data[@"rspCode" ]] isEqualToString:@"10012"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOutNotic" object:self];
            NSLog(@"token错误");
        }else{
            [_listTeamsArray removeAllObjects];
            NSArray *arr = data[@"rspObject"];
            for (NSDictionary *dic in arr) {
                CountryModel *model = [[CountryModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [wSelf.listTeamsArray addObject:model];
            }
            [wSelf.tableView reloadData];
        }

        
    } failure:^(NSError *error) {
        
    }];
}


- (void)cancelAction {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listTeamsArray.count;
   
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseCountryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    cell.model = _listTeamsArray[indexPath.row];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CountryModel *model = _listTeamsArray[indexPath.row];
//    PositionCityUrl
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSDictionary *par = @{@"city":model.city,
                          @"country":model.country,
                          @"token":userDic[@"token"],
                          @"userid":userDic[@"userid"]};
    [[DJHttpApi shareInstance] POST:PositionCityUrl dict:par succeed:^(id data) {
        SendUerViewController *vc = [[SendUerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {
        
    }];

}







@end
