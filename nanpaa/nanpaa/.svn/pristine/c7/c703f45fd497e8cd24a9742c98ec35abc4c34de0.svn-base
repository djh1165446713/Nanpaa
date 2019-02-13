/*!
 @header WMPlayer.h
 
 @author   Created by zhengwenming on  16/1/24
 
 @version 1.00 16/1/24 Creation(版本信息)
 
   Copyright © 2016年 郑文明. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import "Masonry.h"

@import MediaPlayer;
@import AVFoundation;

/**
 *  注意⚠：本人把属性都公开到.h文件里面了，为了适配广大开发者，不同的需求可以修改属性东西，也可以直接修改源代码。
 */
@interface WMPlayer : UIView
/**
 *  播放器player
 */
@property(nonatomic,retain) AVPlayer *player;
/**
 *playerLayer,可以修改frame
 */
@property(nonatomic,retain) AVPlayerLayer *playerLayer;
/**
 *  底部操作工具栏
 */
@property(nonatomic,retain) UIView      *bottomView;
@property(nonatomic,retain) UISlider    *progressSlider;
@property(nonatomic,retain) UISlider    *volumeSlider;
@property(nonatomic,copy  ) NSString    *videoURLStr;

@property(nonatomic,retain) UILabel     *timeCurrentLabel;  //当前的时间进度
@property(nonatomic,retain) UILabel     *timeMaxLabel;      //视频总时间
/**
 *  控制全屏的按钮
 */
@property(nonatomic,retain) UIButton    *fullScreenBtn;
/**
 *  播放暂停按钮
 */
@property(nonatomic,retain) UIButton    *playOrPauseBtn;

/**
 *  菊花（加载框）
 */
@property (nonatomic,strong) UIActivityIndicatorView *loadingView;

/* playItem */
@property(nonatomic,retain) AVPlayerItem *currentItem;
/**
 *  初始化WMPlayer的方法
 *
 *  @param frame       frame
 *  @param videoURLStr URL字符串，包括网络的和本地的URL
 *
 *  @return id类型，实际上就是WMPlayer的一个对象
 */
- (id)initWithFrame:(CGRect)frame videoURLStr:(NSString *)videoURLStr;
@end
