//
//  RecommCell.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/19.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "RecommCell.h"

@implementation RecommCell

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        _isFollow = [NSNumber numberWithInteger:1];
        [self initUI];
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
    
    
    _followBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _followBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    _followBtn.layer.masksToBounds = YES;
    _followBtn.layer.cornerRadius = 10;
    [_followBtn.layer setBorderWidth:1.0];
    if ([_isFollow integerValue] == 0) {
        [self.followBtn setTitle:@"Following" forState:(UIControlStateNormal)];
        self.followBtn.backgroundColor = RGB(212, 39, 82);
        self.isFollow = [NSNumber numberWithInteger:1];
        
    }else {
        [self.followBtn setTitle:@"Follow" forState:(UIControlStateNormal)];
        self.followBtn.backgroundColor = [UIColor clearColor];
        self.isFollow = [NSNumber numberWithInteger:0];
        
    }
    [_followBtn addTarget:self action:@selector(followAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:_followBtn];
    [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.headImg);
        make.top.equalTo(wSelf.headImg.mas_bottom).offset(5);
        make.height.offset(25);
        make.width.offset(60);
    }];
    
    
    
    _userName = [[UILabel alloc] init];
    _userName.textAlignment = NSTextAlignmentCenter;
    _userName.font = [UIFont systemFontOfSize:12];
    _userName.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_userName];
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.headImg);
        make.top.equalTo(wSelf.followBtn.mas_bottom).offset(5);
        make.height.offset(15);
        make.width.offset(60);
    }];
    
}

- (void)followAction{

    if ([_isFollow integerValue] == 0) {
        [self.followBtn setTitle:@"Following" forState:(UIControlStateNormal)];
        self.followBtn.backgroundColor = RGB(212, 39, 82);
        self.isFollow = [NSNumber numberWithInteger:1];
        NSLog(@"%@",_model.userid);
        NSDictionary *userDic = @{@"userid":_model.userid};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addUserPost" object:self userInfo:userDic];
        
    }else {
        [self.followBtn setTitle:@"Follow" forState:(UIControlStateNormal)];
        self.followBtn.backgroundColor = [UIColor clearColor];
        self.isFollow = [NSNumber numberWithInteger:0];
        NSLog(@"%@",_model.userid);
        NSDictionary *userDic = @{@"userid":_model.userid};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelUserPost" object:self userInfo:userDic];
        
    }
}



- (void)setModel:(RecommendModel *)model {
    self.userid = model.userid;
    _model = model;
    [_headImg sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl] placeholderImage:[UIImage imageNamed:@"placeholderImg"]];
    _userName.text = model.nickname;
}

- (void)dealloc{
}

@end
