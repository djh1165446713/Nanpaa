//
//  TransaHistoryCell.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/4.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryCoinModel.h"
@interface TransaHistoryCell : UITableViewCell


@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) HistoryCoinModel *model;
@end
