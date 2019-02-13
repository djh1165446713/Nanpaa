//
//  NearbyCell.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/7.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "NearbyCell.h"

@implementation NearbyCell


- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initUI {
    ______WS();
    _headImg = [[UIImageView alloc] init];
    _headImg.layer.masksToBounds = YES;
    _headImg.layer.cornerRadius = 45;
    [self.contentView addSubview:_headImg];
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.contentView).offset(10);
        make.centerX.equalTo(wSelf);
        make.width.height.offset(90);
    }];
    
    
    _userName = [[UILabel alloc] init];
    _userName.textAlignment = NSTextAlignmentCenter;
    _userName.font = [UIFont systemFontOfSize:16];
    _userName.layer.masksToBounds = YES;
    _userName.layer.cornerRadius = 10;
    _userName.textColor = [UIColor whiteColor];
    _userName.backgroundColor = RGB(193, 37, 75);
    [self.contentView addSubview:_userName];
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.headImg);
        make.top.equalTo(wSelf.headImg.mas_bottom).offset(5);
        make.height.offset(25);
        make.width.offset(60);
    }];
    
    
    _distanceLabel = [[UILabel alloc] init];
    _distanceLabel.font = [UIFont systemFontOfSize:12];
    _distanceLabel.textColor = [UIColor blackColor];
    _distanceLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_distanceLabel];
    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.headImg);
        make.top.equalTo(wSelf.userName.mas_bottom).offset(5);
        make.height.offset(12);
        make.width.offset(60);
    }];
    

}


- (void)setModel:(DynamicModel *)model {
    [_headImg sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl] placeholderImage:[UIImage imageNamed:@"placeholderImg"] options:(SDWebImageRefreshCached)];
    _userName.text = model.nickname;
    _distanceLabel.text = [NSString stringWithFormat:@"%ldkm",(long)model.distance];
}

@end
