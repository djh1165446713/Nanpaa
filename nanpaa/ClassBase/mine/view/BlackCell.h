//
//  BlackCell.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/24.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlackModel.h"
@protocol lockDelegate <NSObject>

-(void)lockOrUnlock:(NSIndexPath *)indexPath;//定义setViewControl方法


@end

@interface BlackCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UIButton *lockBtn;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) BlackModel *model;

@property (nonatomic, strong) id<lockDelegate>delegate;
- (void)setCellWithModel:(BlackModel *)model indexPath:(NSIndexPath *)indexPath;

@end
