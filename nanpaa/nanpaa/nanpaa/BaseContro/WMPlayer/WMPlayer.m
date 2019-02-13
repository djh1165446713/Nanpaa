
/*!
 @header WMPlayer.m
 
 @author   Created by zhengwenming on  16/1/24
 
 @version 1.00 16/1/24 Creation(版本信息)
 
   Copyright © 2016年 郑文明. All rights reserved.
 */

#import "WMPlayer.h"
#define WMVideoSrcName(file) [@"WMPlayer.bundle" stringByAppendingPathComponent:file]
#define WMVideoFrameworkSrcName(file) [@"Frameworks/WMPlayer.framework/WMPlayer.bundle" stringByAppendingPathComponent:file]


static void *PlayViewCMTimeValue = &PlayViewCMTimeValue;

static void *PlayViewStatusObservationContext = &PlayViewStatusObservationContext;

@interface WMPlayer ()
@property (nonatomic, assign) CGPoint           firstPoint;
@property (nonatomic, assign) CGPoint           secondPoint;
@property (nonatomic, retain) NSTimer           *durationTimer;
@property (nonatomic, retain) NSTimer           *autoDismissTimer;
@property (nonatomic, retain) NSDateFormatter   *dateFormatter;

@end


@implementation WMPlayer
{
    UISlider    *systemSlider;
    CGRect      m_frameInCell;      //老的加载在Cell上的frame
    CGRect      m_frameInWindow;    //老的加载在Window上的frame
    UIView      *ui_viewSuper;      //老的super View 即Cell的contentView
}

-(AVPlayerItem *)getPlayItemWithURLString:(NSString *)urlString
{
    if ([urlString containsString:@"http"])
    {
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        return playerItem;
    }
    else
    {
        AVAsset *movieAsset         = [[AVURLAsset alloc]initWithURL:[NSURL fileURLWithPath:urlString] options:nil];
        AVPlayerItem *playerItem    = [AVPlayerItem playerItemWithAsset:movieAsset];
        return playerItem;
    }
}

- (instancetype)initWithFrame:(CGRect)frame videoURLStr:(NSString *)videoURLStr
{
    self = [super init];
    if (self)
    {
        m_frameInCell           = frame;
        ui_viewSuper            = self.superview;
        __weak typeof(self) wSelf = self;
        
        self.frame              = frame;
        self.backgroundColor    = [UIColor blackColor];
        self.currentItem        = [self getPlayItemWithURLString:videoURLStr];
        
        self.player             = [AVPlayer playerWithPlayerItem:self.currentItem];
        self.playerLayer        = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.frame  = self.layer.bounds;
//        self.playerLayer.videoGravity = AVLayerVideoGravityResize;
        [self.layer addSublayer:_playerLayer];
        
        if([self.player respondsToSelector:@selector(setAllowsAirPlay:)])
        {
            self.player.allowsAirPlayVideo                              = NO;
            self.player.usesExternalPlaybackWhileExternalScreenIsActive = NO;
        }
        
        [self performSelector:@selector(hidAriDrope) withObject:nil afterDelay:0.1];
        
        
        
        //bottomView
        self.bottomView = [[UIView alloc]init];
        self.bottomView.hidden = YES;
        [self addSubview:self.bottomView];
        //autoLayout bottomView
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf).with.offset(0);
            make.right.equalTo(wSelf).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wSelf).with.offset(0);
            
        }];
        [self setAutoresizesSubviews:NO];
        
        self.playOrPauseBtn         = [UIButton buttonWithType:UIButtonTypeCustom];
        self.playOrPauseBtn.hidden = YES;
        self.playOrPauseBtn.frame   = CGRectMake(0, 0, 44, 44);
        self.playOrPauseBtn.showsTouchWhenHighlighted = YES;
        [self.playOrPauseBtn addTarget:self action:@selector(PlayOrPause:) forControlEvents:UIControlEventTouchUpInside];
        [self.playOrPauseBtn setImage:[UIImage imageNamed:WMVideoSrcName(@"pause")] ?: [UIImage imageNamed:WMVideoFrameworkSrcName(@"pause")] forState:UIControlStateNormal];
        [self.playOrPauseBtn setImage:[UIImage imageNamed:WMVideoSrcName(@"play")]  ?: [UIImage imageNamed:WMVideoFrameworkSrcName(@"play")]  forState:UIControlStateSelected];
//        [self.playOrPauseBtn setImage:[UIImage imageNamed:WMVideoSrcName(@"play")] ?: [UIImage imageNamed:WMVideoFrameworkSrcName(@"play")] forState:UIControlStateNormal];
//        [self.playOrPauseBtn setImage:[UIImage imageNamed:WMVideoSrcName(@"pause")]  ?: [UIImage imageNamed:WMVideoFrameworkSrcName(@"pause")]  forState:UIControlStateSelected];
        self.playOrPauseBtn.center  = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
        [self addSubview:self.playOrPauseBtn];
        
        
        MPVolumeView *volumeView = [[MPVolumeView alloc]init];
        volumeView.hidden = YES;
        [self addSubview:volumeView];
        [volumeView sizeToFit];
        
        
        systemSlider = [[UISlider alloc]init];
        systemSlider.hidden = YES;
        systemSlider.backgroundColor = [UIColor clearColor];
        for (UIControl *view in volumeView.subviews) {
            if ([view.superclass isSubclassOfClass:[UISlider class]]) {
                NSLog(@"1");
                systemSlider = (UISlider *)view;
            }
        }
        systemSlider.autoresizesSubviews = NO;
        systemSlider.autoresizingMask = UIViewAutoresizingNone;
        [self addSubview:systemSlider];
        systemSlider.hidden = YES;
        
        
        self.volumeSlider               = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.volumeSlider.hidden = YES;
        self.volumeSlider.tag           = 1000;
        self.volumeSlider.hidden        = YES;
        self.volumeSlider.minimumValue  = systemSlider.minimumValue;
        self.volumeSlider.maximumValue  = systemSlider.maximumValue;
        self.volumeSlider.value         = systemSlider.value;
        [self.volumeSlider addTarget:self action:@selector(updateSystemVolumeValue:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.volumeSlider];
        
        
        //时间话筒条
        self.progressSlider                 = [[UISlider alloc]init];
        self.progressSlider.hidden = YES;
        self.progressSlider.minimumValue    = 0.0;
        [self.progressSlider setThumbImage:[UIImage imageNamed:WMVideoSrcName(@"dot")] ?: [UIImage imageNamed:WMVideoFrameworkSrcName(@"dot")]  forState:UIControlStateNormal];
        self.progressSlider.minimumTrackTintColor = [UIColor clearColor];
        self.progressSlider.value           = 0.0;//指定初始值
        [self.progressSlider addTarget:self action:@selector(updateProgress:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:self.progressSlider];
        [self.progressSlider mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.equalTo(wSelf.bottomView).with.offset(50);
            make.right.equalTo(wSelf.bottomView).with.offset(-70);
            make.height.mas_equalTo(40);
            make.top.equalTo(self.bottomView).with.offset(0);
        }];
        
        //_fullScreenBtn
        self.fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.fullScreenBtn.hidden = YES;
        self.fullScreenBtn.showsTouchWhenHighlighted = YES;
        [self.fullScreenBtn setImage:[UIImage imageNamed:WMVideoSrcName(@"fullscreen")] ?: [UIImage imageNamed:WMVideoFrameworkSrcName(@"fullscreen")] forState:UIControlStateNormal];
        [self.fullScreenBtn setImage:[UIImage imageNamed:WMVideoSrcName(@"nonfullscreen")] ?: [UIImage imageNamed:WMVideoFrameworkSrcName(@"nonfullscreen")] forState:UIControlStateSelected];
        [self.bottomView addSubview:self.fullScreenBtn];
        [self.fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.right.equalTo(wSelf.bottomView).with.offset(0);
            make.height.mas_equalTo(44);
            make.bottom.equalTo(wSelf.bottomView).with.offset(0);
            make.width.mas_equalTo(44);
        }];
        
        //时间进度
        self.timeCurrentLabel                   = [[UILabel alloc]init];
        self.timeCurrentLabel.hidden = YES;
        self.timeCurrentLabel.textColor         = [UIColor whiteColor];
        self.timeCurrentLabel.backgroundColor   = [UIColor clearColor];
        self.timeCurrentLabel.textAlignment     = NSTextAlignmentRight;
        self.timeCurrentLabel.font              = [UIFont systemFontOfSize:11];
        [self.bottomView addSubview:self.timeCurrentLabel];
        [self.timeCurrentLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.equalTo(wSelf.progressSlider.mas_top);
            make.left.equalTo(wSelf.bottomView).with.offset(0);
            make.height.mas_equalTo(wSelf.progressSlider.mas_height);
            make.width.mas_equalTo(45);
        }];
        [self bringSubviewToFront:self.bottomView];
        
        //视频最大时间
        self.timeMaxLabel                   = [[UILabel alloc]init];
        self.timeMaxLabel.hidden = YES;
        self.timeMaxLabel.textAlignment     = NSTextAlignmentLeft;
        self.timeMaxLabel.textColor         = [UIColor whiteColor];
        self.timeMaxLabel.backgroundColor   = [UIColor clearColor];
        self.timeMaxLabel.font              = [UIFont systemFontOfSize:11];
        [self.bottomView addSubview:self.timeMaxLabel];
        [self.timeMaxLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.equalTo(wSelf.progressSlider.mas_top);
            make.left.mas_equalTo(wSelf.progressSlider.mas_right).with.offset(5);
            make.height.mas_equalTo(wSelf.progressSlider.mas_height);
            make.width.mas_equalTo(45);
        }];
        
        [self bringSubviewToFront:self.bottomView];
        
        
        self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        self.loadingView.hidden = YES;
        [self.loadingView hidesWhenStopped];
        [self addSubview:self.loadingView];
        [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        [self.loadingView startAnimating];
        self.bottomView.alpha       = 0.0;
        self.playOrPauseBtn.alpha   = 0.0;
        
        

        [self.currentItem addObserver:self
                          forKeyPath:@"status"
                             options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                             context:PlayViewStatusObservationContext];
        [self initTimer];
    }
    return self;
}

- (void)updateSystemVolumeValue:(UISlider *)slider
{
    systemSlider.value = slider.value;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
}


#pragma mark
#pragma mark - fullScreenAction
-(void)fullScreenAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    //用通知的形式把点击全屏的时间发送到app的任何地方，方便处理其他逻辑
    [[NSNotificationCenter defaultCenter] postNotificationName:@"fullScreenBtnClickNotice" object:sender];
}

- (double)duration{
    AVPlayerItem *playerItem = self.player.currentItem;
    if (playerItem.status == AVPlayerItemStatusReadyToPlay)
    {
        return CMTimeGetSeconds([[playerItem asset] duration]);
    }
    else
    {
        return 0.f;
    }
}

- (double)currentTime
{
    return CMTimeGetSeconds([[self player] currentTime]);
}

- (void)setCurrentTime:(double)time
{
    [[self player] seekToTime:CMTimeMakeWithSeconds(time, 1)];
}


#pragma mark
#pragma mark - PlayOrPause
- (void)PlayOrPause:(UIButton *)sender
{
    
    if (self.durationTimer==nil)
    {
        self.durationTimer = [NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(finishedPlay:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.durationTimer forMode:NSDefaultRunLoopMode];
    }
    sender.selected = !sender.selected;
    if (self.player.rate != 1.f)
    {
        if ([self currentTime] == [self duration])
            [self setCurrentTime:0.f];
        [self.player play];
    }
    else
    {
        [self.player pause];
    }
    //    CMTime time = [self.player currentTime];
    
    [self hidAriDrope];
}







- (void)hidAriDrope
{
    //移除aridrope
    for (UIView* vvv in self.subviews)
    {
        if ([vvv isKindOfClass:[MPVolumeView class]])
        {
            for (UIView* vvvv in vvv.subviews)
            {
                if ([NSStringFromClass([vvvv class]) isEqualToString:@"MPButton"])
                {
                    vvvv.hidden = YES;
                }
            }
        }
    }
}


#pragma mark - 设置播放的视频
- (void)setVideoURLStr:(NSString *)videoURLStr
{
    _videoURLStr = videoURLStr;
    
    if (self.currentItem)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_currentItem];
        [self.currentItem removeObserver:self forKeyPath:@"status"];
    }
    
    self.currentItem = [self getPlayItemWithURLString:videoURLStr];
    [self.currentItem addObserver:self
                       forKeyPath:@"status"
                          options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                          context:PlayViewStatusObservationContext];
        
    [self.player replaceCurrentItemWithPlayerItem:self.currentItem];
    
    // 添加视频播放结束通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_currentItem];
}

- (void)moviePlayDidEnd:(NSNotification *)notification
{
    __weak typeof(self) weakSelf = self;
    [self.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        [weakSelf.progressSlider setValue:0.0 animated:YES];
        weakSelf.playOrPauseBtn.selected = NO;
        [weakSelf.player play];
    }];
}


#pragma mark - 播放进度
- (void)updateProgress:(UISlider *)slider
{
    [self.player seekToTime:CMTimeMakeWithSeconds(slider.value, 1)];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    /* AVPlayerItem "status" property value observer. */
    if (context == PlayViewStatusObservationContext)
    {
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        switch (status)
        {
                /* Indicates that the status of the player is not yet known because
                 it has not tried to load new media resources for playback */
            case AVPlayerStatusUnknown:
            {
                [self.loadingView startAnimating];
                [UIView animateWithDuration:0.4 animations:^{
                        self.bottomView.alpha       = 0.0;
                        self.playOrPauseBtn.alpha   = 0.0;
                } completion:^(BOOL finish){
                    
                }];
            }
                break;
                
            case AVPlayerStatusReadyToPlay:
            {
                /* Once the AVPlayerItem becomes ready to play, i.e.
                 [playerItem status] == AVPlayerItemStatusReadyToPlay,
                 its duration can be fetched from the item. */
                if (CMTimeGetSeconds(self.player.currentItem.duration)) {
                    self.progressSlider.maximumValue = CMTimeGetSeconds(self.player.currentItem.duration);
                }
                
                [self initTimer];
                if (self.durationTimer==nil) {
                    self.durationTimer = [NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(finishedPlay:) userInfo:nil repeats:YES];
                    [[NSRunLoop currentRunLoop] addTimer:self.durationTimer forMode:NSDefaultRunLoopMode];
                }
                
                //5s dismiss bottomView
                if (self.autoDismissTimer==nil) {
                    self.autoDismissTimer = [NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(autoDismissBottomView:) userInfo:nil repeats:YES];
                    [[NSRunLoop currentRunLoop] addTimer:self.autoDismissTimer forMode:NSDefaultRunLoopMode];
                }
                
                [self.loadingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:0.4];
            }
                break;
                
            case AVPlayerStatusFailed:
            {
                [self.loadingView stopAnimating];
            }
                break;
        }
    }
}


#pragma mark
#pragma mark finishedPlay
- (void)finishedPlay:(NSTimer *)timer
{
    if (self.currentTime == self.duration&&self.player.rate==.0f)
    {
        self.playOrPauseBtn.selected = YES;
        [self.durationTimer invalidate];
        self.durationTimer = nil;
    }
}


#pragma mark
#pragma mark autoDismissBottomView
-(void)autoDismissBottomView:(NSTimer *)timer
{
    if (self.player.rate==.0f&&self.currentTime != self.duration) //暂停状态
    {
    }
    else if(self.player.rate==1.0f)
    {
        if (self.bottomView.alpha==1.0)
        {
            [UIView animateWithDuration:0.5 animations:^
            {
                self.bottomView.alpha       = 0.0;
                self.playOrPauseBtn.alpha   = 0.0;
            } completion:^(BOOL finish){
            }];
        }
    }
}


#pragma  maik - 定时器
-(void)initTimer
{
    double interval = .1f;
    
    CMTime playerDuration = [self playerItemDuration];
    if (CMTIME_IS_INVALID(playerDuration))
    {
        return;
    }
    double duration = CMTimeGetSeconds(playerDuration);
    if (isfinite(duration))
    {
        CGFloat width = CGRectGetWidth([self.progressSlider bounds]);
        interval = 0.5f * duration / width;
    }
    NSLog(@"interva === %f",interval);
    
    __weak typeof(self) weakSelf = self;
    
    [weakSelf.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(interval, NSEC_PER_SEC)  queue:NULL /* If you pass NULL, the main queue is used. */ usingBlock:^(CMTime time){
        [self syncScrubber];
    }];
}



- (void)syncScrubber
{
    CMTime playerDuration = [self playerItemDuration];
    if (CMTIME_IS_INVALID(playerDuration))
    {
        self.progressSlider.minimumValue = 0.0;
        return;
    }
    
    double duration = CMTimeGetSeconds(playerDuration);
    if (isfinite(duration))
    {
        float minValue          = [self.progressSlider minimumValue];
        float maxValue          = [self.progressSlider maximumValue];
        double time             = CMTimeGetSeconds([self.player currentTime]);
        _timeCurrentLabel.text  = [self convertTime:time];
        _timeMaxLabel.text      = [self convertTime:duration];
        
        if([self.progressSlider isTouchInside])
        {
            NSLog(@"正在响应事件");
            return;
        }
        
        [self.progressSlider setValue:(maxValue - minValue) * time / duration + minValue];
    }
}

- (CMTime)playerItemDuration
{
    AVPlayerItem *playerItem = [self.player currentItem];
    if (playerItem.status == AVPlayerItemStatusReadyToPlay){
        return([playerItem duration]);
    }
    
    return(kCMTimeInvalid);
}

- (NSString *)convertTime:(CGFloat)second
{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    if (second/3600 >= 1) {
        [[self dateFormatter] setDateFormat:@"HH:mm:ss"];
    } else {
        [[self dateFormatter] setDateFormat:@"mm:ss"];
    }
    NSString *newTime = [[self dateFormatter] stringFromDate:d];
    return newTime;
}

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for(UITouch *touch in event.allTouches)
    {
        self.firstPoint = [touch locationInView:self];
    }
    
    UISlider *volumeSlider = (UISlider *)[self viewWithTag:1000];
    volumeSlider.value = systemSlider.value;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for(UITouch *touch in event.allTouches)
    {
        self.secondPoint = [touch locationInView:self];
    }
    
    systemSlider.value += (self.firstPoint.y - self.secondPoint.y)/500.0;
    UISlider *volumeSlider = (UISlider *)[self viewWithTag:1000];
    volumeSlider.value = systemSlider.value;
    self.firstPoint = self.secondPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.firstPoint = self.secondPoint = CGPointZero;
}

-(void)dealloc
{
    [self.player pause];
    self.autoDismissTimer   = nil;
    self.durationTimer      = nil;
    self.player             = nil;
    [self.currentItem removeObserver:self forKeyPath:@"status"];
}
@end
