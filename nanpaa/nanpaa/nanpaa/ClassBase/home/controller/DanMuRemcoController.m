//
//  DanMuRemcoController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/11.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "DanMuRemcoController.h"
#import "iCarousel.h"
#import "RecommendModel.h"
#import "DynamicModel.h"
#import "HisViewController.h"
#import "SDWebImageManager.h"
#import "TjUserView.h"

@interface DanMuRemcoController ()<iCarouselDelegate,iCarouselDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) iCarousel *carousel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *introducLab;
@property (nonatomic, strong) UIImageView *scaleImg;
@property (nonatomic, strong) UILabel *distanceLab;
@property (nonatomic, strong) UIImage *downImage;
@property (nonatomic, strong) UIImageView *bgImageJian;
@property (nonatomic, strong) UIButton *leftNavBtn;
@property (nonatomic, strong) UILabel *titleLabel;;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DynamicModel *modelJump;
@property (nonatomic, strong) TjUserView *viewTjuser;

@end

@implementation DanMuRemcoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ______WS();
    UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [_imageView.layer setBorderColor:RGB(211, 39, 82).CGColor];
    _imageView.userInteractionEnabled = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.clipsToBounds = YES;
//    [self.imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [_imageView addGestureRecognizer:tap];
//    _imageView.hidden = YES;
    [self.view addSubview:_imageView];
    


    _leftNavBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_leftNavBtn setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
    [_leftNavBtn  addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_leftNavBtn];
    [_leftNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(0);
        make.top.equalTo(wSelf.view).offset(34);
        make.width.offset(50);
        make.height.offset(20);
    }];

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.text = @"Recommend";
    _titleLabel.font = [UIFont systemFontOfSize:20];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.top.equalTo(wSelf.view.mas_top).offset(34);
        make.width.offset(150);
        make.height.offset(34);
    }];
    
  
    _bgImageJian = [[UIImageView alloc] init];
    _bgImageJian.layer.masksToBounds = YES;
//    _bgImageJian.userInteractionEnabled = YES;
    _bgImageJian.backgroundColor = [UIColor whiteColor];
//    [_bgImageJian addGestureRecognizer:tap];
    [self.view addSubview:_bgImageJian];
    [_bgImageJian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wSelf.view.mas_bottom).offset(0);
        make.left.equalTo(wSelf.view).offset(0);
        make.right.equalTo(wSelf.view.mas_right).offset(0);
        make.height.offset(158);
    }];

    
    _carousel = [[iCarousel alloc] init];
    _carousel.type = iCarouselTypeCustom;// 必须在下面的之前设置，不然需要 reload
//    _carousel.currentItemIndex = _dataArr.count / 2;
    _carousel.delegate = self;
    _carousel.dataSource = self;
    _carousel.pagingEnabled=YES;
    [_carousel scrollToItemAtIndex:1 animated:YES];
    [self.view addSubview:_carousel];
    [_carousel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.bgImageJian.mas_top).offset(4);
        make.height.offset(190);
        make.left.equalTo(wSelf.view).offset(0);
        make.right.equalTo(wSelf.view.mas_right).offset(0);
    }];
    
}


- (void)addImgScrollView{
    int index = (int) _dataArr.count;
    for (int i = 0; i < index; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * i + 0, 0, kScreenWidth, kScreenHeight)];
        RecommendModel *model = _dataArr[i];
        NSLog(@"%@",model.avatarUrl);
        [_scrollView addSubview:imageView];
        imageView.image = [self imageByScalingAndCroppingForSize:CGSizeMake(CGRectGetWidth(imageView.bounds), CGRectGetHeight(imageView.bounds)) imageUrl:model.avatarUrl];
    }
    
    [_carousel reloadData];
}


#pragma mark  ---------------自定义方法-------------

- (void)followAndUnfollowAction {
//    ______WS();
    self.viewTjuser = (TjUserView *)self.carousel.currentItemView;
    
    if (!self.viewTjuser.isFollow) {
        [self.viewTjuser.followBtn setTitle:@"Following" forState:(UIControlStateNormal)];
        [self.viewTjuser.followBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        self.viewTjuser.followBtn.backgroundColor = RGB(223, 63, 101);
        NSInteger index = self.carousel.currentItemIndex;
        RecommendModel *model = _dataArr[index];
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
        NSDictionary *parDic = @{@"targetId":model.userid,
                                 @"token":userDic[@"token"],
                                 @"userid":userDic[@"userid"]};
        [[DJHttpApi shareInstance] POST:AddFollowUrl dict:parDic succeed:^(id data) {
            //            [[DJHManager shareManager] toastManager:@"following" superView:wSelf.view];
            //        [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendPost" object:self];

            self.viewTjuser.isFollow = YES;
        } failure:^(NSError *error) {
            
        }];
    }else{
        [self.viewTjuser.followBtn setTitle:@"+Follow" forState:(UIControlStateNormal)];
        [self.viewTjuser.followBtn setTitleColor:RGB(223, 63, 101) forState:(UIControlStateNormal)];
        self.viewTjuser.followBtn.backgroundColor = [UIColor whiteColor];
        NSInteger index = self.carousel.currentItemIndex;
        RecommendModel *model = _dataArr[index];
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
        NSDictionary *parDic = @{@"targetId":model.userid,
                                 @"token":userDic[@"token"],
                                 @"userid":userDic[@"userid"]};
        [[DJHttpApi shareInstance] POST:deleteFollowUrl dict:parDic succeed:^(id data) {
            //            [[DJHManager shareManager] toastManager:@"following" superView:wSelf.view];
            //        [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendPost" object:self];
            
            self.viewTjuser.isFollow = NO;
        } failure:^(NSError *error) {
            
        }];
    }

}



- (void)tapAction{
    self.hidesBottomBarWhenPushed = YES;
    HisViewController *vc = [[HisViewController alloc] init];
    vc.model = self.modelJump;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark  ---------------iCarousel Delegate-------------
- (CGFloat)carouselItemWidth:(iCarousel *)carousel{
    return 290;
}


-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.dataArr.count;
//    return 50;

}

-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
//    TjUserView *userView = nil;
    
//    if (!view) {
        TjUserView *userView = [[TjUserView alloc] init];
        [userView.followBtn addTarget:self action:@selector(followAndUnfollowAction) forControlEvents:(UIControlEventTouchUpInside)];
        userView.frame = CGRectMake(0, 0, 270, 280);
        userView.layer.cornerRadius = 8;
        userView.backgroundColor = [UIColor whiteColor];
        userView.layer.borderWidth = 1;
        [userView.layer setBorderColor:[UIColor clearColor].CGColor];

//    }
//    view = userView;
//    view.contentMode = UIViewContentModeCenter;
    RecommendModel *model = _dataArr[index];
    userView.nameLab.text = model.nickname;
    userView.textView.text = model.introduce;
    return userView;
}


-(void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
    NSLog(@"carousel %ld",(long)carousel.currentItemIndex);
    
    _iCarouselindex = carousel.currentItemIndex;
    
}



- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel {
    NSLog(@"Index: %@", @(self.carousel.currentItemIndex));
    RecommendModel *model = _dataArr[self.carousel.currentItemIndex];
    self.modelJump = _dataArr[self.carousel.currentItemIndex];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl]  placeholderImage:nil options:(SDWebImageRefreshCached)];
    
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
        static CGFloat max_sacle = 1.0f;
        static CGFloat min_scale = 0.8f;
        if (offset <= 1 && offset >= -1){
            
            float tempScale = offset < 0 ? 1 + offset : 1 - offset;
            float slope = (max_sacle-min_scale) / 1;
            CGFloat scale = min_scale + slope * tempScale;
            transform = CATransform3DScale(transform, scale, scale, 1);
            
        }else{
            
            transform = CATransform3DScale(transform, min_scale, min_scale, 1);
            
        }
        return CATransform3DTranslate(transform, offset * self.carousel.itemWidth * 1.2, 0.0, 0.0);
}


- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return YES;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.1f;
        }
        case iCarouselOptionFadeMax:
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}



- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
    self.carousel.hidden = YES;

}



#pragma mark  ---------------View Delegate-------------
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


- (UIImage *)downImage:(NSString *)imageUrl {
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageRefreshCached
                                                   progress:^(NSInteger receivedSize, NSInteger expectedSize)
     {
         //处理下载进度
     } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
         if (error) {
         }
         if (image) {
             _downImage = image;
         }
     }];
    return _downImage;
}


-(UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize imageUrl:(NSString *)imageUrl
{
    UIImage *downImage = [self downImage:imageUrl];
    UIImage*newImage = nil;
    CGSize imageSize = downImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if(CGSizeEqualToSize(imageSize,targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth/width;
        CGFloat heightFactor = targetHeight/height;
        if(widthFactor > heightFactor)
            scaleFactor = widthFactor;//scaletofitheight
        else
            scaleFactor = heightFactor;//scaletofitwidth
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        //centertheimage
        if(widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight-scaledHeight) * 0.5;
        }
        else if(widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize);//thiswillcrop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [downImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"couldnotscaleimage");
    UIGraphicsEndImageContext();
    return newImage;
}







@end
