//
//  FollowingCell.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/8.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicModel.h"
@interface FollowingCell : UITableViewCell
@property (nonatomic, strong)UIImageView *iconImage;
@property (nonatomic, strong)UILabel *userLabel;
@property (nonatomic, strong)UILabel *sighLabel;  //个人简介
@property (nonatomic, strong)DynamicModel *model;

@end
