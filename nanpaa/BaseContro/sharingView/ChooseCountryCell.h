//
//  ChooseCountryCell.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/30.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryModel.h"
@interface ChooseCountryCell : UITableViewCell
@property (nonatomic, strong) UIImageView *locationImg;
@property (nonatomic, strong) UILabel *cityNameLab;
@property (nonatomic, strong) CountryModel *model;

@end
