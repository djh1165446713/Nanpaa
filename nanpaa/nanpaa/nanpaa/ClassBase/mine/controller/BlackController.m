//
//  BlackController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/24.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "BlackController.h"
#import "BlackCell.h"
#import "BlackModel.h"

@interface BlackController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,lockDelegate>
@property(nonatomic, strong)UICollectionView *collectView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@end

@implementation BlackController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = [NSMutableArray array];
    self.titleLabel.text = @"BlackList";
//    self.titleLabel.text = CustomStr(@"showText");
    self.view.backgroundColor = RGB(49, 56, 93);

    [self initUI];
    [self loadData];
}

- (void)initUI{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) collectionViewLayout:flowLayout];
    _collectView.delegate = self;
    _collectView.dataSource = self;
    _collectView.backgroundColor = RGB(49, 56, 93);
    flowLayout.itemSize = CGSizeMake(70, 135);
    flowLayout.minimumInteritemSpacing = 30;
    flowLayout.minimumLineSpacing = 0;
    [self.view addSubview:_collectView];
    [_collectView registerClass:[BlackCell class] forCellWithReuseIdentifier:@"blackCell"];
}



- (void)loadData {
    ______WS();
    NSDictionary *par = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSDictionary *par1 =@{@"token":par[@"token"],
                          @"userid":par[@"userid"]};
    [[DJHttpApi shareInstance] POST:BlackListUrl dict:par1 succeed:^(id data) {
        if ([[NSString stringWithFormat:@"%@",data[@"rspCode" ]] isEqualToString:@"10012"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOutNotic" object:self];
            NSLog(@"token错误");
        }else{
            NSArray *arr = data[@"rspObject"];
            for (NSDictionary *dic in arr) {
                BlackModel *model = [[BlackModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [wSelf.dataArr addObject:model];
            }
            [wSelf.collectView reloadData];
        }

    } failure:^(NSError *error) {
        
    }];
}


-(void)lockOrUnlock:(NSIndexPath *)indexPath
{
    ______WS();
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    BlackModel *model = _dataArr[indexPath.row];
    NSDictionary *par = @{@"targetId":model.userid,
                          @"token":dic[@"token"],
                          @"userid":dic[@"userid"]};
    [[DJHttpApi shareInstance] POST:deleteBlackUrl dict:par succeed:^(id data) {
        NSLog(@"%@-----%@",self,data);
        if ([[NSString stringWithFormat:@"%@",data[@"rspCode" ]] isEqualToString:@"10012"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOutNotic" object:self];
            NSLog(@"token错误");
        }else{
            [self.dataArr removeObjectAtIndex:indexPath.row];
            [wSelf.collectView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
    
}



#pragma collectView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BlackCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"blackCell" forIndexPath:indexPath];
//    cell.model = _dataArr[indexPath.row];
    cell.delegate = self;
    [cell setCellWithModel:_dataArr[indexPath.row] indexPath:indexPath];
    return cell;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(2, 2, 2, 2);
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}





- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}



@end
