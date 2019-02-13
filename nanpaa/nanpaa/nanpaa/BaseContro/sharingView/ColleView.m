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
@end

@implementation ColleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 24, self.frame.size.height) collectionViewLayout:flowLayout];
    _collectView.delegate = self;
    _collectView.dataSource = self;
    _collectView.backgroundColor = RGB(91, 96, 122);
    _collectView.layer.masksToBounds = YES;
    _collectView.layer.cornerRadius = 8;
    [_collectView registerClass:[RecommCell class] forCellWithReuseIdentifier:@"recomm"];
    [_collectView registerClass:[OtherRecommCell class] forCellWithReuseIdentifier:@"otherecomm"];
    flowLayout.itemSize = CGSizeMake(100, 150);
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
        cellOther.model = _arrData[indexPath.row];
        return cellOther;

    }else {
        RecommCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"recomm" forIndexPath:indexPath];
        cell.model = _arrData[indexPath.row];
        return cell;
    }
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(2, 2, 2, 2);
    
}

@end
