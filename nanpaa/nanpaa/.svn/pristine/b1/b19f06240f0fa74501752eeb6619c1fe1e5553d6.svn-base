//
//  ChooseCountryCell.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/30.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "ChooseCountryCell.h"

@implementation ChooseCountryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        ______WS();
        
        self.contentView.backgroundColor = RGB(38, 42, 74);
        
        _locationImg = [[UIImageView alloc] init];
        _locationImg.image = [UIImage imageNamed:@"location-1"];
        _locationImg.layer.masksToBounds = YES;
        [self.contentView addSubview:_locationImg];
        [_locationImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(wSelf.contentView);
            make.width.offset(10);
            make.height.offset(25);
            make.left.equalTo(wSelf.contentView.mas_left).offset(16);
        }];
        
        _cityNameLab = [[UILabel alloc] init];
        _cityNameLab.font = [UIFont systemFontOfSize:20];
        _cityNameLab.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_cityNameLab];
        [_cityNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(wSelf.locationImg);
            make.height.offset(20);
            make.width.offset(150);
            make.left.equalTo(wSelf.locationImg.mas_right).offset(10);
        }];
    }
    return self;
}

- (void)setModel:(CountryModel *)model {
    _locationImg.image = [UIImage imageNamed:@"location"];
    _cityNameLab.text = model.city;
}

@end
