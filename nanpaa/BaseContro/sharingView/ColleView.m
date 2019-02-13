//
//  ColleView.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/19.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "ColleView.h"
#import "RecommCell.h"
#import "OtherRecommCell.h"
@interface ColleView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, assign) CGFloat itemWithBtnWidth;

@property (nonatomic, assign) CGFloat itemWithBtnHeight;   // item高度,暂时先放着

@end

@implementation ColleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(delectUserAction:) name:@"cancelUserPost" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addUserAction:) name:@"addUserPost" object:nil];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    if (kScreenWidth < 375) {
        self.itemWithBtnWidth = 80;
    }else{
        self.itemWithBtnWidth = 100;
    }
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 24, self.frame.size.height) collectionViewLayout:flowLayout];
    _collectView.delegate = self;
    _collectView.dataSource = self;
    _collectView.backgroundColor = RGB(91, 96, 122);
    _collectView.layer.masksToBounds = YES;
    _collectView.layer.cornerRadius = 8;
    [_collectView registerClass:[RecommCell class] forCellWithReuseIdentifier:@"recomm"];
    [_collectView registerClass:[OtherRecommCell class] forCellWithReuseIdentifier:@"otherecomm"];
    flowLayout.itemSize = CGSizeMake(self.itemWithBtnWidth, 150);
    flowLayout.minimumInteritemSpacing = (kScreenWidth - 24 - 100 * 3 - 12) / 2;
    flowLayout.minimumLineSpacing = 0;
    [self addSubview:_collectView];
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 3 == 1) {
        OtherRecommCell *cellOther = [collectionView dequeueReusableCellWithReuseIdentifier:@"otherecomm" forIndexPath:indexPath];
        RecommendModel *model = self.arrData[indexPath.row];
        [cellOther makeModel1:model indexPath:indexPath];
        return cellOther;

    }else {
        RecommCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"recomm" forIndexPath:indexPath];
        RecommendModel *model = self.arrData[indexPath.row];
        [cell makeModel1:model indexPath:indexPath];
        return cell;
    }
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(2, 2, 2, 2);
    
}

- (void)followBtnAction:(NSIndexPath*)index{
    
}


#pragma mark --- 通知
- (void)delectUserAction:(NSNotification *)notfic{
    NSDictionary *dic = notfic.userInfo;
    NSIndexPath *indexPath = dic[@"indexPath"];
    RecommendModel *model = self.arrData[indexPath.row];
    model.isFollow = NO;
    [self.arrData replaceObjectAtIndex:indexPath.row withObject:model];
}


- (void)addUserAction:(NSNotification *)notfic{
    NSDictionary *dic = notfic.userInfo;
    NSIndexPath *indexPath = dic[@"indexPath"];
    RecommendModel *model = self.arrData[indexPath.row];
    model.isFollow = YES;
    [self.arrData replaceObjectAtIndex:indexPath.row withObject:model];
    
}

#pragma mark --- 控制器方法

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:@"cancelUserPost"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"addUserPost"];
    
}

@end
