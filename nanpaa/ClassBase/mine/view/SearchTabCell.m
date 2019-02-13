
//
//  SearchTabCell.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/7.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "SearchTabCell.h"

@implementation SearchTabCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        ______WS();
        self.contentView.backgroundColor = RGB(38, 42, 74);

        _headImg = [[UIImageView alloc] init];
        _headImg.layer.masksToBounds = YES;
        _headImg.layer.cornerRadius = 45 / 2;
        [self.contentView addSubview:_headImg];
        [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.contentView).offset(20);
            make.centerY.equalTo(wSelf);
            make.width.offset(45);
            make.height.offset(45);

        }];
        
        
        _nickName = [[UILabel alloc] init];
        _nickName.textColor = [UIColor whiteColor];
        _nickName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_nickName];
        [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.headImg.mas_right).offset(15);
            make.top.equalTo(wSelf.headImg.mas_top).offset(0);
            make.width.offset(200);
            make.height.offset(14);
        }];
        
        
        _moreLabel = [[UILabel alloc] init];
        _moreLabel.textColor = [UIColor whiteColor];
        _moreLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_moreLabel];
        [_moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.headImg.mas_right).offset(15);
            make.bottom.equalTo(wSelf.headImg.mas_bottom).offset(0);
            make.width.offset(200);
            make.height.offset(15);
        }];
    }
    return  self;
}


- (void)setModel:(DynamicModel *)model {

    [_headImg sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl] placeholderImage:[UIImage imageNamed:@"placeholderImg"] options:(SDWebImageRefreshCached)];
    _nickName.text = model.nickname;
    _moreLabel.text = model.introduce;
}

@end
