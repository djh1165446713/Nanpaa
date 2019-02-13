//
//  PointTopView.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/15.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "PointTopView.h"

@implementation PointTopView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        ______WS();
        
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:20];
        _titleLab.textColor = RGB(223, 63, 101);
        _titleLab.text = @"Your Point";
        NSDictionary *attr = @{NSFontAttributeName: [UIFont systemFontOfSize:22]};
        CGFloat width = [_titleLab.text sizeWithAttributes:attr].width;
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf).offset(0);
            make.top.equalTo(wSelf).offset(0);
            make.width.offset(width);
            make.height.offset(22);
        }];
        

        
        _imgIcon = [[UIImageView alloc] init];
        _imgIcon.image = [UIImage imageNamed:@"jinbiTixian"];
        [self addSubview:_imgIcon];
        [_imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.titleLab.mas_right).offset(13);
            make.width.height.offset(24);
            make.centerY.equalTo(wSelf.titleLab);
        }];
        
        _numPoints = [[UILabel alloc] init];
        _numPoints.font = [UIFont systemFontOfSize:20];
        _numPoints.textColor = RGB(223, 63, 101);
        _numPoints.text = @"00000";
        NSDictionary *attr1 = @{NSFontAttributeName: [UIFont systemFontOfSize:22]};
        CGFloat width1 = [_numPoints.text sizeWithAttributes:attr1].width;
        [self addSubview:_numPoints];
        [_numPoints mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.imgIcon.mas_right).offset(9);
            make.centerY.equalTo(wSelf.titleLab);
            make.width.offset(width1);
            make.height.offset(22);
        }];
    }
    return self;
}


@end
