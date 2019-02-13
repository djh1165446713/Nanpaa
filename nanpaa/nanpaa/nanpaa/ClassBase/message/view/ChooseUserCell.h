//
//  ChooseUserCell.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/27.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooserModel.h"
@protocol deleteChooseUserDelegate <NSObject>
- (void)deleteArrayAtIndex:(NSIndexPath *)indexPath;
- (void)addArrayAtIndex:(NSIndexPath *)indexPath;
@end

@interface ChooseUserCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UIButton *isSelectBtn;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, weak) id<deleteChooseUserDelegate>Delegate;
@property (nonatomic, strong) ChooserModel *model;

- (void)setCellWithModel:(ChooserModel *)model indexPath:(NSIndexPath *)indexPath;

@end
