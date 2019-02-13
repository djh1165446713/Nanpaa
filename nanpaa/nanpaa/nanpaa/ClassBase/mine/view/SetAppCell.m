//
//  SetAppCell.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/24.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "SetAppCell.h"

@implementation SetAppCell


- (UILabel*)lblTitle {
    if (!_lblTitle) {
        _lblTitle = [UILabel new];
        _lblTitle.textColor = [UIColor whiteColor];
        _lblTitle.font = [UIFont systemFontOfSize:20];
    }
    return _lblTitle;
}

- (UILabel *)centerLabel {
    if (!_centerLabel) {
        _centerLabel = [UILabel new];
        _centerLabel.textColor = RGB(213, 39, 82);
        _centerLabel.font = [UIFont systemFontOfSize:20];
        _centerLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _centerLabel;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        ______WS();
        
        self.contentView.backgroundColor = RGB(49, 56, 93);
        _swit = [[UISwitch alloc] init];
        _swit.layer.masksToBounds = YES;
        _swit.layer.cornerRadius = 10;
        _swit.onTintColor = RGB(212, 39, 82);
        _swit.tintColor = [UIColor whiteColor];
        [self.contentView addSubview:_swit];
        [_swit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(wSelf.contentView);
            make.right.equalTo(wSelf.mas_right).offset(-10);
            make.size.mas_equalTo(CGSizeMake(60, 30));
        }];
        [self.contentView addSubview:self.lblTitle];
        [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(wSelf.contentView);
            make.height.offset(20);
            make.width.offset(kScreenWidth / 2);
            make.left.equalTo(wSelf.contentView).offset(15);
        }];
        
        
        [self.contentView addSubview:self.centerLabel];
        [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wSelf.contentView);
            make.centerY.equalTo(wSelf.contentView);
            make.height.offset(20);
            make.width.offset(kScreenWidth / 2);            
        }];
    }
    
    return self;
}



@end
