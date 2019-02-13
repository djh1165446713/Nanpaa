//
//  FWandYSView.m
//  nanpaa
//
//  Created by 杜建虎 on 2016/11/12.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "FWandYSView.h"

@implementation FWandYSView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        ______WS();

        _tit1Label = [[UILabel alloc] init];
        _tit1Label.text = @"Registration means agree the";
        NSDictionary *attr = @{NSFontAttributeName: [UIFont systemFontOfSize:12]};
        CGFloat width = [_tit1Label.text sizeWithAttributes:attr].width;
        [self addSubview:_tit1Label];
        _tit1Label.textColor = [UIColor whiteColor];
        _tit1Label.font = [UIFont systemFontOfSize:12];
        [_tit1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wSelf).offset(0);
            make.left.equalTo(wSelf).offset(0);
            make.height.offset(13);
            make.width.offset(width + 1);
        }];
        
        
        _fwLabel = [[UILabel alloc] init];
        _fwLabel.text = @" terms of service";
        _fwLabel.userInteractionEnabled = YES;
        [self addSubview:_fwLabel];
        _fwLabel.textColor = [UIColor redColor];
        _fwLabel.font = [UIFont systemFontOfSize:12];
        NSDictionary *attr1 = @{NSFontAttributeName: [UIFont systemFontOfSize:12]};
        CGFloat width1 = [_fwLabel.text sizeWithAttributes:attr1].width;
        [_fwLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wSelf).offset(0);
            make.left.equalTo(wSelf.tit1Label.mas_right).offset(1);
            make.height.offset(13);
            make.width.offset(width1 + 1);

        }];

        
        _ysLabel = [[UILabel alloc] init];
        _ysLabel.text = @" privacy policy";
        _ysLabel.userInteractionEnabled = YES;
        NSDictionary *attr3 = @{NSFontAttributeName: [UIFont systemFontOfSize:12]};
        CGFloat width3 = [_ysLabel.text sizeWithAttributes:attr3].width;
        [self addSubview:_ysLabel];
        _ysLabel.textColor = [UIColor redColor];
        _ysLabel.font = [UIFont systemFontOfSize:12];
        [_ysLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(wSelf.mas_bottom).offset(-1);
            make.centerX.equalTo(wSelf);
            make.height.offset(13);
            make.width.offset(width3 + 1);

        }];

        
        _tit2Label = [[UILabel alloc] init];
        _tit2Label.text = @"and";
        NSDictionary *attr2 = @{NSFontAttributeName: [UIFont systemFontOfSize:12]};
        CGFloat width2 = [_tit2Label.text sizeWithAttributes:attr2].width;
        _tit2Label.textColor = [UIColor whiteColor];
        [self addSubview:_tit2Label];
        _tit2Label.font = [UIFont systemFontOfSize:12];
        [_tit2Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(wSelf.ysLabel);
            make.right.equalTo(wSelf.ysLabel.mas_left).offset(-1);
            make.height.offset(13);
            make.width.offset(width2 + 1);
            
        }];
        
    }
   
    return self;
}



@end
