//
//  SetAppCell.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/24.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetAppCell : UITableViewCell

@property (nonatomic, strong) UISwitch *swit;
@property (nonatomic, strong) UILabel       *lblTitle;
@property (nonatomic, strong) UILabel *centerLabel;;
@property (nonatomic, assign) BOOL isSwitOn;
@end
