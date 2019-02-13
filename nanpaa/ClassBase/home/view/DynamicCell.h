//
//  DynamicCell.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/21.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicModel.h"

@protocol pushDelegate <NSObject>

-(void)setViewControl:(NSIndexPath *)indexPath;//定义setViewControl方法


@end

@interface DynamicCell : UITableViewCell

@property (nonatomic, strong) UIView *bgView;

@property(nonatomic, strong) UIImageView *headImg;
@property(nonatomic, strong) UILabel *nickName;
@property(nonatomic, strong) UIImageView *timeImg;
@property(nonatomic, strong) UILabel *moreLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property(nonatomic, strong) UIImageView *moneyImg;
@property (nonatomic, strong) UIImageView *playImg;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) DynamicModel *model;

@property (nonatomic, weak) id<pushDelegate>Delegate;


- (void)setInboxCellWithModel:(DynamicModel *)model indexPath:(NSIndexPath *)indexPath;
- (void)setRelpyCellWithModel:(DynamicModel *)model indexPath:(NSIndexPath *)indexPath;

@end
