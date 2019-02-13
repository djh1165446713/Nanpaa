//
//  HomeController.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/9/20.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BulletManager.h"
#import "BulletView.h"

@interface HomeController : UIViewController
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *leftNavBtn;
@property (nonatomic, strong) UIButton *rightNavBtn;
@property (nonatomic, strong) UIImageView *bgImg;



@property (nonatomic, strong) NSString *videoRemote;  //视频远程路径
@property (nonatomic, strong) NSString *videoImgRomote;  //缩略图远程路径
@property (nonatomic, strong) NSString *location;  //缩略图本地路径


@property (nonatomic, strong) NSString *imageRemote;  //图片远程路径
@property (nonatomic, strong) NSString *imagelocation;  //缩略图远程路径

// 控制弹幕是否隐藏
@property (nonatomic, assign) BOOL danMuPlay;

@property (nonatomic, strong) BulletManager *manager;







@end
