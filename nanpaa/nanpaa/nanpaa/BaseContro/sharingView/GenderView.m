//
//  GenderView.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/17.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "GenderView.h"

@implementation GenderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        ______WS();
        self.userInteractionEnabled = YES;
        _gdBuuton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_gdBuuton setBackgroundImage:[UIImage imageNamed:@"gendeNorm"] forState:(UIControlStateNormal)];
        [self addSubview:_gdBuuton];
        [self.gdBuuton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf).offset(0);
            make.top.equalTo(wSelf).offset(0);
            make.bottom.equalTo(wSelf.mas_bottom).offset(0);
            make.width.offset(18);
            wSelf.gdBuuton.layer.masksToBounds = YES;
            wSelf.gdBuuton.layer.cornerRadius = 9;
        }];
        
        
        _gdLabel = [[UILabel alloc] init];
        _gdLabel.textColor = [UIColor redColor];
        _gdLabel.font = [UIFont systemFontOfSize:15];
        _gdLabel.userInteractionEnabled = YES;
        [self addSubview:_gdLabel];
        [self.gdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.gdBuuton.mas_right).offset(5);
            make.right.equalTo(wSelf.mas_right).offset(0);
            make.centerY.equalTo(wSelf.gdBuuton);
        }];
        

    }
    return self;
}



@end
