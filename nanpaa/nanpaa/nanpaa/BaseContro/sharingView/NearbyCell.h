//
//  NearbyCell.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/7.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicModel.h"
@interface NearbyCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) DynamicModel *model;

@end
