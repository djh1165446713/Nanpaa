
//
//  PayMentView.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/15.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "PayMentView.h"

@implementation PayMentView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        ______WS();
        
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 10;
        self.layer.borderWidth = 1;
        [self.layer setBorderColor:RGB(223, 63, 101).CGColor];
        self.backgroundColor = RGB(23, 26, 44);
        self.userInteractionEnabled = YES;
        
        
        
        _iconImg = [[UIImageView alloc] init];
        _iconImg.image = [UIImage imageNamed:@"jinbiTixian"];
        [self addSubview:_iconImg];
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wSelf);
            make.width.height.offset(30);
            make.top.equalTo(wSelf).offset(24);
        }];
        
        _pointNumLab = [[UILabel alloc] init];
        _pointNumLab.font = [UIFont systemFontOfSize:20];
        _pointNumLab.textAlignment = NSTextAlignmentCenter;
        _pointNumLab.textColor = [UIColor whiteColor];
        [self addSubview:_pointNumLab];
        [_pointNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wSelf);
            make.top.equalTo(wSelf.iconImg.mas_bottom).offset(14);
            make.width.offset(150);
            make.height.offset(20);
        }];

        
        _priceLab = [[UILabel alloc] init];
        _priceLab.font = [UIFont systemFontOfSize:20];
        _priceLab.textAlignment = NSTextAlignmentCenter;
        _priceLab.textColor = [UIColor whiteColor];
        [self addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wSelf);
            make.top.equalTo(wSelf.pointNumLab.mas_bottom).offset(20);
            make.width.offset(150);
            make.height.offset(20);
        }];
    }
    return self;
}


@end
