//
//  FollowingCell.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/8.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "FollowingCell.h"

@implementation FollowingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        ______WS();
        _iconImage = [[UIImageView alloc] init];
        _iconImage.layer.masksToBounds = YES;
        _iconImage.layer.cornerRadius = 45 / 2;
        [self.contentView addSubview:_iconImage];
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.contentView).offset(16);
            make.centerY.equalTo(wSelf.contentView);
            make.width.height.offset(45);
        }];
        
        _userLabel = [[UILabel alloc] init];
        _userLabel.textColor = [UIColor blackColor];
        _userLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_userLabel];
        [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.iconImage.mas_right).offset(15);
            make.width.offset(200);
            make.height.offset(15);
            make.top.equalTo(wSelf.iconImage.mas_top).offset(0);
            
        }];
        
        _sighLabel = [[UILabel alloc] init];
        _sighLabel.font = [UIFont systemFontOfSize:14];
        _sighLabel.textColor = RGB(153, 153, 153);
        [self.contentView addSubview:_sighLabel];
        [_sighLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.iconImage.mas_right).offset(15);
            make.width.offset(200);
            make.height.offset(15);
            make.bottom.equalTo(wSelf.iconImage.mas_bottom).offset(0);
        }];
    }
    return self;
}


- (void)setModel:(DynamicModel *)model {
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl] placeholderImage:[UIImage imageNamed:@"placeholderImg"] options:(SDWebImageRefreshCached)];
    _userLabel.text = model.nickname;
    _sighLabel.text = model.introduce;
}

@end
