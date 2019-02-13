//
//  TjUserView.m
//  nanpaa
//
//  Created by bianKerMacBook on 17/1/17.
//  Copyright © 2017年 bianKerMacBookDJH. All rights reserved.
//

#import "TjUserView.h"

@implementation TjUserView
- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        ______WS();
//        self.layer.masksToBounds = YES;
        
        _isFollow = NO;
        self.bgView = [[UIView alloc] init];
        self.bgView.layer.cornerRadius = 8;
        self.bgView.backgroundColor = [UIColor whiteColor];
        self.bgView.userInteractionEnabled = YES;
        self.layer.borderWidth = 1;
        [self.bgView.layer setBorderColor:[UIColor whiteColor].CGColor];
        self.bgView.layer.shadowOpacity = 0.5;// 阴影透明度
        self.bgView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
        self.bgView.layer.shadowRadius = 4;// 阴影扩散的范围控制
        self.bgView.layer.shadowOffset = CGSizeMake(1, 4);// 阴影的范围
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf).offset(0);
            make.right.equalTo(wSelf.mas_right).offset(0);
            make.top.equalTo(wSelf.mas_top).offset(0);
            make.height.offset(190);
        }];
        
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = RGB(223, 63, 101);
        _nameLab.font = [UIFont systemFontOfSize:14];
        _nameLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nameLab];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(220);
            make.height.offset(15);
            make.centerX.equalTo(wSelf);
            make.top.equalTo(wSelf.mas_top).offset(28);
        }];
        
        _lineView = [[UIImageView alloc] init];
        _lineView.image = [UIImage imageNamed:@"xuxian"];
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(1);
            make.top.equalTo(wSelf.nameLab.mas_bottom).offset(30);
            make.left.equalTo(wSelf).offset(15);
            make.right.equalTo(wSelf.mas_right).offset(-15);

        }];
        
        
        _textView = [[UITextView alloc] init];
        _textView.textColor = [UIColor blackColor];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.editable = NO;
        _textView.textAlignment = NSTextAlignmentCenter;
        _textView.font = [UIFont systemFontOfSize:12];
        [self addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wSelf.lineView.mas_bottom).offset(20);
            make.bottom.equalTo(wSelf.mas_bottom).offset(-5);
            make.width.offset(kScreenWidth - 80);
            make.left.equalTo(wSelf).offset(15);
            make.right.equalTo(wSelf.mas_right).offset(-15);

        }];
        
        
        _followBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _followBtn.layer.masksToBounds = YES;
        _followBtn.layer.cornerRadius = 15;
        self.followBtn.layer.borderWidth = 1;
        [self.followBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
//        self.followBtn.layer.shadowRadius = -4;// 阴影扩散的范围控制
//        _followBtn.layer.shadowOffset =  CGSizeMake(4, 4);
//        _followBtn.layer.shadowOpacity = 0.8;
//        _followBtn.layer.shadowColor =  [UIColor blackColor].CGColor;
        [_followBtn setTitle:@"+Follow" forState:(UIControlStateNormal)];
        [_followBtn setTitleColor:RGB(223, 63, 101) forState:(UIControlStateNormal)];
        [self addSubview:_followBtn];
        
        [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wSelf.bgView.mas_bottom).offset(25);
            make.width.offset(115);
            make.centerX.equalTo(wSelf);
            make.height.offset(40);
        }];
    }
    return self;
}



@end
