//
//  EmtyCell.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/12/12.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "EmtyCell.h"

@implementation EmtyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        ______WS();
        _iconImg = [[UIImageView alloc] init];
        _iconImg.layer.masksToBounds = YES;
        _iconImg.layer.cornerRadius = 20;
        _iconImg.image = [UIImage imageNamed:@"emtyImg"];
        [self.contentView addSubview:_iconImg];
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wSelf.contentView);
            make.width.offset(150);
            make.height.offset(80);
            make.centerY.equalTo(wSelf.contentView);
        }];
        
        
        _tishiLab= [[UILabel alloc] init];
        _tishiLab.font = [UIFont systemFontOfSize:16];
        _tishiLab.textAlignment = NSTextAlignmentCenter;
        _tishiLab.textColor = RGB(212, 39, 82);
        _tishiLab.text = @"Try to follow more people";
        [self.contentView addSubview:_tishiLab];
        [_tishiLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wSelf.contentView);
            make.top.equalTo(wSelf.iconImg.mas_bottom).offset(15);
            make.width.offset(kScreenWidth);
            make.height.offset(16);
        }];
    }
    return  self;
}


@end
