//
//  BlackCell.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/24.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "BlackCell.h"
@interface BlackCell ()
{
    NSIndexPath *indexPt;
}

@end


@implementation BlackCell
- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = RGB(49, 56, 93);
        [self initUI];
    }
    return self;
}

- (void)initUI {
    ______WS();
    _headImg = [[UIImageView alloc] init];
    _headImg.layer.masksToBounds = YES;
    _headImg.layer.cornerRadius = 45 / 2;
    [self.contentView addSubview:_headImg];
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.contentView).offset(16);
        make.centerX.equalTo(wSelf);
        make.width.height.offset(45);
    }];
    
    

    _userName = [[UILabel alloc] init];
    _userName.textAlignment = NSTextAlignmentCenter;
    _userName.font = [UIFont systemFontOfSize:13];
    _userName.textColor = RGB(179, 45, 83);
    [self.contentView addSubview:_userName];
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.headImg);
        make.top.equalTo(wSelf.headImg.mas_bottom).offset(12);
        make.height.offset(15);
        make.width.offset(50);
    }];
    
    
    _lockBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _lockBtn.layer.masksToBounds = YES;
    _lockBtn.layer.cornerRadius = 6;
    [_lockBtn.layer setBorderWidth:1.0];
    _lockBtn.layer.borderColor = RGB(179, 45, 83).CGColor;
    [_lockBtn setTitle:@"Unlock" forState:(UIControlStateNormal)];
    [_lockBtn setTitleColor:RGB(179, 45, 83) forState:(UIControlStateNormal)];
    [_lockBtn addTarget:self action:@selector(lockOrUnlockAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:_lockBtn];
    [_lockBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.headImg);
        make.top.equalTo(wSelf.userName.mas_bottom).offset(12);
        make.height.offset(26);
        make.width.offset(66);
    }];
    
    
}

- (void)setCellWithModel:(BlackModel *)model indexPath:(NSIndexPath *)indexPath {
    [_headImg sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl] placeholderImage:nil];
    [_lockBtn setTitle:@"unlock" forState:(UIControlStateNormal)];
    _userName.text = model.nickname;
    indexPt = indexPath;

}

- (void)lockOrUnlockAction {

    if ([self.delegate respondsToSelector:@selector(lockOrUnlock:)]) { // 如果协议响应了sendValue:方法
        [self.delegate lockOrUnlock:indexPt];
    }
    
}

- (void)setModel:(BlackModel *)model {
    [_headImg sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl] placeholderImage:nil];
    [_lockBtn setTitle:@"unlock" forState:(UIControlStateNormal)];
    _userName.text = model.nickname;
    
}

@end
