//
//  DynamicCell.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/21.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "DynamicCell.h"
@interface DynamicCell ()
{
    NSIndexPath *indexPt;
}
@end

@implementation DynamicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];

        ______WS();
        _headImg = [[UIImageView alloc] init];
        [_headImg addGestureRecognizer:tap];
        _headImg.layer.masksToBounds = YES;
        _headImg.layer.cornerRadius = 45 / 2;
        _headImg.userInteractionEnabled = YES;
        [self.contentView addSubview:_headImg];
        [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.contentView).offset(16);
            make.centerY.equalTo(wSelf);
            make.width.offset(45);
            make.height.offset(45);

        }];
        
        _nickName = [[UILabel alloc] init];
        _nickName.textColor = [UIColor blackColor];
        _nickName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_nickName];
        [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.headImg.mas_right).offset(15);
            make.top.equalTo(wSelf.headImg.mas_top).offset(0);
            make.width.offset(200);
            make.height.offset(15);
        }];
        
        _moreLabel = [[UILabel alloc] init];
        _moreLabel.textColor = RGB(102, 102, 102);
        _moreLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_moreLabel];
        [_moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.headImg.mas_right).offset(15);
            make.bottom.equalTo(wSelf.headImg.mas_bottom).offset(0);
            make.width.offset(200);
            make.height.offset(15);
        }];
        
        _playImg = [[UIImageView alloc] init];
        [self.contentView addSubview:_playImg];
        [_playImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(wSelf.contentView.mas_right).offset(-12);
            make.centerY.equalTo(wSelf.contentView);
            make.width.offset(21);
            make.height.offset(20);

        }];
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:14];
        _priceLabel.textColor = RGB(223, 63, 101);
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.hidden = YES;
        [self.contentView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(wSelf.playImg.mas_left).offset(-12);
            make.centerY.equalTo(wSelf.playImg);
            make.width.offset(40);
            make.height.offset(15);
        }];
        
        _moneyImg = [[UIImageView alloc] init];
        _moneyImg.hidden = YES;
        _moneyImg.image = [UIImage imageNamed:@"mainPoint"];
        [self.contentView addSubview:_moneyImg];
        [_moneyImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(wSelf.priceLabel.mas_left).offset(-9);
            make.centerY.equalTo(wSelf.playImg);
            make.width.offset(16);
            make.height.offset(16);
        }];
        
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(102, 102, 102);
        _lineView.alpha = 0.3;
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(1);
            make.left.equalTo(wSelf.contentView.mas_left).offset(16);
            make.bottom.equalTo(wSelf.contentView.mas_bottom).offset(0);
            make.right.equalTo(wSelf.contentView.mas_right).offset(0);

        }];
    }
    return  self;
}


- (void)setInboxCellWithModel:(DynamicModel *)model indexPath:(NSIndexPath *)indexPath
{
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl] placeholderImage:[UIImage imageNamed:@"placeholderImg"] options:(SDWebImageRefreshCached)];
    self.nickName.text = model.nickname;
    self.moreLabel.text = model.inputText;
    indexPt = indexPath;
    if ([model.price isEqualToString:@"0"]) {
        self.priceLabel.font = [UIFont systemFontOfSize:12];
        self.priceLabel.text = @"Free";
    }else{
        self.priceLabel.font = [UIFont systemFontOfSize:14];
        self.priceLabel.text = model.price;
    }
    
    if (model.isRead) {
        if ([model.messageType isEqualToString:@"video"]) {
            self.playImg.image = [UIImage imageNamed:@"videoYes"];
            self.moneyImg.hidden = YES;
            self.priceLabel.hidden = YES;
        }
        else if ([model.messageType isEqualToString:@"image"]) {
            self.playImg.image = [UIImage imageNamed:@"cameraYes"];
            self.moneyImg.hidden = YES;
            self.priceLabel.hidden = YES;
        }else{
            self.playImg.image = [UIImage imageNamed:@"giftReadYes"];
            self.moneyImg.hidden = YES;
            self.priceLabel.hidden = YES;
        }
    }else{
        if ([model.messageType isEqualToString:@"video"]) {
            self.playImg.image = [UIImage imageNamed:@"videoNo"];
            self.moneyImg.hidden = NO;
            self.priceLabel.hidden = NO;
        }
        else if ([model.messageType isEqualToString:@"image"]) {
            self.playImg.image = [UIImage imageNamed:@"cameraNo"];
            self.moneyImg.hidden = NO;
            self.priceLabel.hidden = NO;
        }else{
            self.playImg.image = [UIImage imageNamed:@"giftReadNo"];
            self.moneyImg.hidden = NO;
            self.priceLabel.hidden = NO;
        }
    }
}


- (void)setRelpyCellWithModel:(DynamicModel *)model indexPath:(NSIndexPath *)indexPath
{
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl] placeholderImage:[UIImage imageNamed:@"placeholderImg"]];
    self.nickName.text = model.nickname;
    self.moreLabel.text = model.inputText;
    indexPt = indexPath;
    if ([model.price isEqualToString:@"0"]) {
        self.priceLabel.font = [UIFont systemFontOfSize:12];
        self.priceLabel.text = @"Free";
    }else{
        self.priceLabel.font = [UIFont systemFontOfSize:14];
        self.priceLabel.text = model.price;
    }
    
    if (model.isRead) {
        if ([model.messageType isEqualToString:@"video"]) {
            self.playImg.image = [UIImage imageNamed:@"videoYes"];
            self.moneyImg.hidden = YES;
            self.priceLabel.hidden = YES;
        }
        else if ([model.messageType isEqualToString:@"image"]) {
            self.playImg.image = [UIImage imageNamed:@"cameraYes"];
            self.moneyImg.hidden = YES;
            self.priceLabel.hidden = YES;
        }else{
            self.playImg.image = [UIImage imageNamed:@"giftReadYes"];
            self.moneyImg.hidden = YES;
            self.priceLabel.hidden = YES;
        }
    }else{
        if ([model.messageType isEqualToString:@"video"]) {
            self.playImg.image = [UIImage imageNamed:@"videoNo"];
            self.moneyImg.hidden = NO;
            self.priceLabel.hidden = NO;
        }
        else if ([model.messageType isEqualToString:@"image"]) {
            self.playImg.image = [UIImage imageNamed:@"cameraNo"];
            self.moneyImg.hidden = NO;
            self.priceLabel.hidden = NO;
        }else{
            self.playImg.image = [UIImage imageNamed:@"giftReadNo"];
            self.moneyImg.hidden = NO;
            self.priceLabel.hidden = NO;
        }
    }

}


- (void)tapAction{
     // 如果协议响应了sendValue:方法
    if ([self.Delegate respondsToSelector:@selector(setViewControl:)]) {
        [self.Delegate setViewControl:indexPt];
    }
}


@end
