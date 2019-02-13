//
//  TransaView.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/10.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "TransaView.h"

@implementation TransaView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        ______WS();
        self.backgroundColor = RGB(23, 27, 44);
        _iconImg = [[UIImageView alloc] init];
        _iconImg.layer.masksToBounds = YES;
        _iconImg.image = [UIImage imageNamed:@"jinbiTixian"];
        _iconImg.layer.cornerRadius = 15;
        [self addSubview:_iconImg];
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf).offset(28);
            make.top.equalTo(wSelf).offset(20);
            make.width.height.offset(30);
        }];
        
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(212, 39, 82);
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wSelf.iconImg);
            make.top.equalTo(wSelf.iconImg.mas_bottom).offset(1);
            make.bottom.equalTo(wSelf.mas_bottom).offset(-1);
            make.width.offset(1);
        }];
        
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = RGB(212, 39, 82);;
        _titleLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.iconImg.mas_right).offset(18);
            make.right.equalTo(wSelf.mas_right).offset(-2);
            make.centerY.equalTo(wSelf.iconImg);
            make.height.offset(20);
        }];
        
        
        _drawButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _drawButton.backgroundColor = [UIColor clearColor];
        [_drawButton.layer setBorderWidth:1.0];
        [_drawButton setTitle:@"Withdraw" forState:(UIControlStateNormal)];
        [_drawButton setTitleColor:RGB(212, 39, 80) forState:(UIControlStateNormal)];
        _drawButton.layer.borderColor = RGB(212, 39, 82).CGColor;
        [self addSubview:_drawButton];
        [self.drawButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(wSelf.mas_right).offset(-20);
            make.centerY.equalTo(wSelf.iconImg);
            make.width.offset(86);
            make.height.offset(40);
            wSelf.drawButton.layer.masksToBounds = YES;
            wSelf.drawButton.layer.cornerRadius = 10;
        }];
    }
    return self;
}
@end
