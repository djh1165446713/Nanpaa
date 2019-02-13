//
//  ChooseUserCell.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/27.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "ChooseUserCell.h"
@interface ChooseUserCell ()
{
    NSIndexPath *indexPt;
}
@end
@implementation ChooseUserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _isSelect = NO;
        ______WS();
        UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAction)];
        [self.contentView addGestureRecognizer:tap];
        self.contentView.userInteractionEnabled = YES;
        self.contentView.backgroundColor = RGB(18, 21, 33);
        _headImg = [[UIImageView alloc] init];
        _headImg.layer.masksToBounds = YES;
        _headImg.layer.cornerRadius = 35;
        [self.contentView addSubview:_headImg];
        [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.contentView).offset(10);
            make.centerY.equalTo(wSelf.contentView);
            make.width.height.offset(70);
        }];
        
        _nickName = [[UILabel alloc] init];
        _nickName.textColor = [UIColor whiteColor];
        _nickName.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_nickName];
        [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.headImg.mas_right).offset(15);
            make.centerY.equalTo(wSelf.headImg);
            make.width.offset(200);
            make.height.offset(25);
        }];
        
        
        _isSelectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_isSelectBtn setImage:[UIImage imageNamed:@"choosenor"] forState:(UIControlStateNormal)];
        [_isSelectBtn addTarget:self action:@selector(selectAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_isSelectBtn];
        [_isSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(wSelf.contentView.mas_right).offset(-32);
            make.centerY.equalTo(wSelf.contentView);
            make.width.height.offset(40);
        }];
        
    }
    return self;
}

- (void)setCellWithModel:(ChooserModel *)model indexPath:(NSIndexPath *)indexPath;
{
    [_headImg sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl] placeholderImage:[UIImage imageNamed:@"placeholderImg"] options:(SDWebImageRefreshCached)];
    _nickName.text = model.nickname;
    indexPt = indexPath;
}



- (void)selectAction {
    if (!_isSelect) {
        _isSelect = YES;
        [_isSelectBtn setImage:[UIImage imageNamed:@"chooseselect"] forState:(UIControlStateNormal)];
        if ([self.Delegate respondsToSelector:@selector(addArrayAtIndex:)]) { // 如果协议响应了sendValue:方法
            [self.Delegate addArrayAtIndex:indexPt];
        }
    }else {
        _isSelect = NO;
        [_isSelectBtn setImage:[UIImage imageNamed:@"choosenor"] forState:(UIControlStateNormal)];
        if ([self.Delegate respondsToSelector:@selector(deleteArrayAtIndex:)]) { // 如果协议响应了sendValue:方法
            [self.Delegate deleteArrayAtIndex:indexPt];
        }
    }
}


@end
