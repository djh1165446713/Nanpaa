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
//        self.bgView.userInteractionEnabled = NO;
        [self.bgView.layer setBorderColor:[UIColor whiteColor].CGColor];
        self.bgView.layer.shadowOpacity = 0.5;// 阴影透明度
        self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;// 阴影的颜色
        self.bgView.layer.shadowRadius = 4;// 阴影扩散的范围控制
        self.bgView.layer.shadowOffset = CGSizeMake(1, 4);// 阴影的范围
        self.bgView.alpha = 0.8;
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf).offset(0);
            make.right.equalTo(wSelf.mas_right).offset(0);
            make.top.equalTo(wSelf.mas_top).offset(0);
            make.height.offset(160);
        }];
        
        _headIconImg = [[UIImageView alloc] init];
        _headIconImg.userInteractionEnabled = YES;
        _headIconImg.layer.borderWidth = 1.f;
        [_headIconImg.layer setBorderColor:RGB(255, 255, 255).CGColor];
        _headIconImg.layer.cornerRadius = 41;
        _headIconImg.layer.masksToBounds = YES;
        [self addSubview:_headIconImg];
        [_headIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wSelf);
            make.width.height.offset(82);
            make.bottom.equalTo(wSelf.bgView.mas_top).offset(26);
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
            make.top.equalTo(wSelf.headIconImg.mas_bottom).offset(12);
        }];
        
        
        _followLab = [[UILabel alloc] init];
        _followLab.textColor = RGB(102, 102, 102);
        _followLab.font = [UIFont systemFontOfSize:14];
        _followLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_followLab];
        [_followLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(110);
            make.height.offset(15);
            make.left.equalTo(wSelf.mas_left).offset(25);
            make.bottom.equalTo(wSelf.bgView.mas_bottom).offset(-67);
        }];
        
        
        _lineView2 = [[UIImageView alloc] init];
        //        _lineView2.backgroundColor = [UIColor redColor];
        _lineView2.image = [UIImage imageNamed:@"xuxian2"];
        [self addSubview:_lineView2];
        [_lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wSelf);
            make.width.offset(2);
            make.height.offset(14);
            make.centerY.equalTo(wSelf.followLab);
        }];
        
        _fowllowingLab = [[UILabel alloc] init];
        _fowllowingLab.textColor = RGB(102, 102, 102);
        _fowllowingLab.font = [UIFont systemFontOfSize:14];
        _fowllowingLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_fowllowingLab];
        [_fowllowingLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(110);
            make.height.offset(15);
            make.right.equalTo(wSelf.mas_right).offset(-25);
            make.bottom.equalTo(wSelf.bgView.mas_bottom).offset(-67);
        }];
        
        
        
        _lineView = [[UIImageView alloc] init];
        _lineView.image = [UIImage imageNamed:@"xuxian"];
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(1);
            make.top.equalTo(wSelf.fowllowingLab.mas_bottom).offset(12);
            make.left.equalTo(wSelf).offset(15);
            make.right.equalTo(wSelf.mas_right).offset(-15);

        }];
        
        
        _textView = [[UITextView alloc] init];
        _textView.textColor = RGB(51, 51, 51);
        _textView.backgroundColor = [UIColor clearColor];
        _textView.editable = NO;
        _textView.textAlignment = NSTextAlignmentCenter;
        _textView.font = [UIFont systemFontOfSize:12];
        [self addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wSelf.lineView.mas_bottom).offset(13);
            make.bottom.equalTo(wSelf.bgView.mas_bottom).offset(-5);
            make.width.offset(kScreenWidth - 80);
            make.left.equalTo(wSelf).offset(15);
            make.right.equalTo(wSelf.mas_right).offset(-15);

        }];
        
        
        _followBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _followBtn.backgroundColor = [UIColor whiteColor];
        _followBtn.layer.masksToBounds = YES;
        _followBtn.layer.cornerRadius = 15;
        _followBtn.layer.borderWidth = 1;
        [_followBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
//        _followBtn.layer.shadowOpacity = 0.8;// 阴影透明度
//        _followBtn.layer.shadowColor = [UIColor blackColor].CGColor;// 阴影的颜色
//        _followBtn.layer.shadowRadius = 20;// 阴影扩散的范围控制
//        _followBtn.layer.shadowOffset = CGSizeMake(20, 20);// 阴影的范围
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


- (void)setModel:(RecommendModel *)model{
    if (_isFollow) {
        [self.followBtn setTitle:@"Following" forState:(UIControlStateNormal)];
        [self.followBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        self.followBtn.backgroundColor = RGB(223, 63, 101);
    }else{
        [self.followBtn setTitle:@"+Follow" forState:(UIControlStateNormal)];
        [self.followBtn setTitleColor:RGB(223, 63, 101) forState:(UIControlStateNormal)];
        self.followBtn.backgroundColor = [UIColor whiteColor];
    }
    
    [_headIconImg sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl] placeholderImage:nil];
}


@end
