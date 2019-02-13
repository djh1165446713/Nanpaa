
//
//  ChooseJNView.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/12/1.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "ChooseJNView.h"

@implementation ChooseJNView
- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        ______WS();
        _pictureButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _pictureButton.layer.masksToBounds = YES;
        _pictureButton.layer.cornerRadius = 40;
        [_pictureButton setBackgroundImage:[UIImage imageNamed:@"picImg"] forState:(UIControlStateNormal)];
        [self addSubview:_pictureButton];
        [_pictureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.mas_left).offset(94);
            make.width.height.offset(80);
            make.bottom.equalTo(wSelf.mas_bottom).offset(-20);
        }];
        
        _videoButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _videoButton.layer.masksToBounds = YES;
        [_videoButton setBackgroundImage:[UIImage imageNamed:@"videoImg"] forState:(UIControlStateNormal)];
        _videoButton.layer.cornerRadius = 40;
        [self addSubview:_videoButton];
        [_videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(wSelf.mas_right).offset(-94);
            make.width.height.offset(80);
            make.bottom.equalTo(wSelf.mas_bottom).offset(-20);
        }];
        
        
    }
    return self;
}



@end
