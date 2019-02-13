
//
//  VideoView.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/5.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "VideoView.h"

@implementation VideoView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        ______WS();
        self.userInteractionEnabled = YES;
        _videoImg = [[UIImageView alloc] init];
        _videoImg.image = [UIImage imageNamed:@"videoNo"];
        [self addSubview:_videoImg];
        [_videoImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf).offset(0);
            make.width.height.offset(20);
            make.centerY.equalTo(wSelf);
        }];
        
        _talkLabel = [[UILabel alloc] init];
        _talkLabel.text = @"Say something to your friends";
        _talkLabel.font = [UIFont systemFontOfSize:13];
        _talkLabel.textColor = RGB(219, 39, 82);
        [self addSubview:_talkLabel];
        [_talkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(wSelf.videoImg);
            make.height.offset(20);
            make.width.offset(200);
            make.left.equalTo(wSelf.videoImg.mas_right).offset(10);
        }];
    }
    return self;
}

@end
