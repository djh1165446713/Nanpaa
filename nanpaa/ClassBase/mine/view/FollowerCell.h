//
//  FollowerCell.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/24.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicModel.h"

@interface FollowerCell : UITableViewCell

@property (nonatomic, strong)UIImageView *iconImage;
@property (nonatomic, strong)UILabel *userLabel;
@property (nonatomic, strong)UILabel *sighLabel;  //个人简介
@property (nonatomic, strong)DynamicModel *model;
@end
