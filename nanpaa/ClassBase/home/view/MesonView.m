//
//  MesonView.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/20.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "MesonView.h"
@implementation MesonView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    ______WS();
    _setImg = [[UIImageView alloc] init];
    _setImg.userInteractionEnabled = YES;
    _setImg.image = [UIImage imageNamed:@"setmessage_one"];
    [self addSubview:_setImg];
    [_setImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.mas_top).offset(0);
        make.right.equalTo(wSelf.mas_right).offset(0);
        make.width.offset(35);
        make.height.offset(35);
        
    }];
    
    _upImg = [[UIImageView alloc] init];
    _upImg.image = [UIImage imageNamed:@"up_jiantou"];
    [self addSubview:_upImg];
    [_upImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.mas_top).offset(0);
        make.centerX.equalTo(wSelf);
        make.width.offset(40);
        make.height.offset(25);
        
    }];
    
    _aboutLab = [[UILabel alloc] init];
    _aboutLab.text = @"About me";
    _aboutLab.font = [UIFont systemFontOfSize:11];
    _aboutLab.textColor = RGB(206, 206, 206);
    [self addSubview:_aboutLab];
    [_aboutLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.mas_left).offset(16);
        make.top.equalTo(wSelf.mas_top).offset(16);
        make.height.offset(12);
        make.width.offset(100);
    }];
    
    
    _view = [[VideoView alloc] init];
    _view.hidden = YES;
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf);
        make.width.offset(200);
        make.top.equalTo(wSelf.aboutLab.mas_bottom).offset(10);
        make.height.offset(20);
    }];
    
    
    // 已关注
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = RGB(153, 153, 153);
    _lineView.hidden = YES;
    [self addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.view.mas_bottom).offset(16);
        make.left.equalTo(wSelf.mas_left).offset(36);
        make.right.equalTo(wSelf.mas_right).offset(-36);
        make.height.offset(1);
    }];

    
    _textView = [[UITextView alloc] init];
    _textView.textColor = [UIColor blackColor];
    _textView.textAlignment = NSTextAlignmentCenter;
    _textView.font = [UIFont systemFontOfSize:14];
    [self addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.lineView.mas_top).offset(16);
        make.left.equalTo(wSelf.mas_left).offset(36);
        make.right.equalTo(wSelf.mas_right).offset(-36);
        make.bottom.equalTo(wSelf.mas_bottom).offset(-15);
    }];
    
}

@end
