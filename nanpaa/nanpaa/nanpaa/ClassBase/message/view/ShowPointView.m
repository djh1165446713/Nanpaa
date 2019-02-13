//
//  ShowPointView.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/14.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "ShowPointView.h"
@interface ShowPointView()<KVTimerDelegate>


@end

@implementation ShowPointView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {
        ______WS();
        self.backgroundColor = RGB(36, 40, 73);
        self.alpha = 0.8;
        
        _timer = [[KVTimer alloc] init];
        _timer.delegate = self;
        [_timer setShowTimerLabel:YES];
        [_timer setInterval:KVIntervalHour];
        [_timer setKofString:@""];
        [_timer setMaxTime:161 minTime:0];
        [self addSubview:_timer];
        [_timer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.offset(200);
            make.centerX.equalTo(wSelf);
            make.centerY.equalTo(wSelf);
            
        }];
        
        _topLab = [[UILabel alloc] init];
        _topLab.textColor = [UIColor whiteColor];
        _topLab.text = @"Gift more Nanpaa Points?";
        _topLab.textAlignment = NSTextAlignmentCenter;
        _topLab.font = [UIFont systemFontOfSize:20];
        [self addSubview:_topLab];
        [_topLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wSelf);
            make.top.equalTo(wSelf.mas_top).offset(34);
            make.width.offset(300);
            make.bottom.equalTo(wSelf.timer.mas_top).offset(-20);
        }];
        
        
        _bottomLab = [[UILabel alloc] init];
        _bottomLab.textColor = RGB(27, 197, 174);
        _bottomLab.text = @"People love receiving Nanpaa Points!";
        _bottomLab.textAlignment = NSTextAlignmentCenter;
        _bottomLab.font = [UIFont systemFontOfSize:15];
        [self addSubview:_bottomLab];
        [_bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wSelf);
            make.bottom.equalTo(wSelf.mas_bottom).offset(-24);
            make.width.offset(300);
            make.top.equalTo(wSelf .timer.mas_bottom).offset(24);
        }];
    }
    return self;
}

@end
