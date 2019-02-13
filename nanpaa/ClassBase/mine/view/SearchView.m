//
//  SearchView.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/7.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        ______WS();
        self.backgroundColor =  RGB(38, 42, 74);
        
        _searchText = [[UITextField alloc] init];
        [_searchText.layer setBorderColor:[UIColor redColor].CGColor];
        _searchText.layer.borderWidth = 1;
        _searchText.layer.masksToBounds = YES;
        _searchText.layer.cornerRadius = 12;
        [self addSubview:_searchText];
        [_searchText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf).offset(20);
            make.right.equalTo(wSelf.mas_right).offset(-100);
            make.height.offset(35);
            make.bottom.equalTo(wSelf.mas_bottom).offset(-8);
        }];
        
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = RGB(185, 34, 71);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text = @"Search";
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wSelf);
            make.centerY.equalTo(wSelf.searchText);
            make.height.offset(35 / 2);
            make.width.offset(80);
        }];
        
        
        _iconImg = [[UIImageView alloc] init];
        _iconImg.image = [UIImage imageNamed:@"search top"];
        [self addSubview:_iconImg];
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(wSelf.titleLab.mas_left).offset(-5);
            make.width.height.offset(35 / 2);
            make.centerY.equalTo(wSelf.searchText);
        }];
    }
    return self;
}

@end
