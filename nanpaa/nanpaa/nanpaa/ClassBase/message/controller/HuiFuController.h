//
//  HuiFuController.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/14.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicModel.h"

@interface HuiFuController : UIViewController
// 视图
@property (nonatomic, strong) UILabel *messageLab;                      // 信息Label
@property (nonatomic, strong) UIImageView *messageImg;                  // 背景图片


// 底部视图
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *coinButton;



// 传值
@property (nonatomic, strong) NSString *textStr;


@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *headImgUrl;
@property (nonatomic, strong) NSString *coin;
@property (nonatomic, strong) NSString *videoRemote;  //视频远程路径
@property (nonatomic, strong) NSString *imageRomote;  //缩略图远程路径

@property (nonatomic, strong) DynamicModel *model;
@end
