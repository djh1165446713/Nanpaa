//
//  TransaHistoryCell.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/4.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "TransaHistoryCell.h"

@implementation TransaHistoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        ______WS();
        self.contentView.backgroundColor = RGB(23, 27, 44);
        _iconImg = [[UIImageView alloc] init];
        _iconImg.layer.masksToBounds = YES;
        _iconImg.backgroundColor = RGB(212, 39, 82);
        _iconImg.layer.cornerRadius = 10;
        [self.contentView addSubview:_iconImg];
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.contentView).offset(32);
            make.top.equalTo(wSelf.contentView.mas_top).offset(2);
            make.width.height.offset(20);
        }];
        
        
        
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(212, 39, 82);
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wSelf.iconImg);
            make.top.equalTo(wSelf.iconImg.mas_bottom).offset(2);
            make.bottom.equalTo(wSelf.contentView.mas_bottom).offset(-2);
            make.width.offset(1);
        }];
        
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.iconImg.mas_right).offset(18);
            make.right.equalTo(wSelf.contentView.mas_right).offset(-2);
            make.centerY.equalTo(wSelf.iconImg);
            make.height.offset(15);
        }];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = RGB(138, 138, 138);
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(wSelf.contentView.mas_right).offset(-20);
            make.bottom.equalTo(wSelf.contentView.mas_bottom).offset(-12);
            make.width.offset(200);
            make.height.offset(13);
        }];
        
    }
    return self;
}


- (void)setModel:(HistoryCoinModel *)model {
    _titleLabel.text = [NSString stringWithFormat:@"%@ viewed you %@ points",model.nickname,model.coin];
    _timeLabel.text = model.time;
}

@end
