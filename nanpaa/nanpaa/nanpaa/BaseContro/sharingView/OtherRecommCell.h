//
//  OtherRecommCell.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/20.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"
@interface OtherRecommCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UIButton *followBtn;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) RecommendModel *model;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, assign) NSNumber* isFollow;
@end
