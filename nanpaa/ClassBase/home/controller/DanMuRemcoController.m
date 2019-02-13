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
//@property (nonatomic, strong) UIImageView *bgImageJian;
@property (nonatomic, strong) UIButton *leftNavBtn;
@property (nonatomic, strong) UILabel *titleLabel;;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) RecommendModel *modelJump;
@property (nonatomic, strong) TjUserView *viewTjuser;
@property (nonatomic, strong) UIView *topBGview;
@property (nonatomic, strong) DynamicModel *model;
@property (nonatomic, strong) iCarousel *carouselImgBack;


@end


@implementation DanMuRemcoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    ______WS();
//    UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
//    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    [_imageView.layer setBorderColor:RGB(211, 39, 82).CGColor];
//    _imageView.userInteractionEnabled = YES;
//    _imageView.contentMode = UIViewContentModeScaleAspectFill;
//    _imageView.clipsToBounds = YES;
//    //    [self.imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
//    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    [_imageView addGestureRecognizer:tap];
//    //    _imageView.hidden = YES;
//    [self.view addSubview:_imageView];
    
    //
    NSLog(@"%ld",(long)self.iCarouselindex);
//    int index = arc4random() %( _dataArr.count);
    
    _carouselImgBack = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _carouselImgBack.type = iCarouselTypeLinear;// 必须在下面的之前设置，不然需要 reload
    _carouselImgBack.delegate = self;
    _carouselImgBack.tag = 10001;
    _carouselImgBack.dataSource = self;
    _carouselImgBack.pagingEnabled=YES;
    _carouselImgBack.currentItemIndex = self.iCarouselindex;

//    _carouselImgBack.decelerationRate = 2;
//    _carouselImgBack.scrollSpeed = 10;
//    [_carouselImgBack scrollToItemAtIndex:1 animated:YES];
    [self.view addSubview:_carouselImgBack];
//    [_carouselImgBack mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(wSelf.view.mas_bottom).offset(-10);
//        make.height.offset(190);
//        make.left.equalTo(wSelf.view).offset(65);
//        make.right.equalTo(wSelf.view.mas_right).offset(-65);
//    }];

    
    self.topBGview = [[UIView alloc] init];
    [self.view addSubview:self.topBGview];
    [self.topBGview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.view.mas_top).offset(0);
        make.left.equalTo(wSelf.view).offset(0);
        make.right.equalTo(wSelf.view.mas_right).offset(0);
        make.height.offset(64);
    }];
    
    
    _leftNavBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_leftNavBtn setImage:[UIImage imageNamed:@"tuijianJT"] forState:(UIControlStateNormal)];
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
    //阴影透明度
    _titleLabel.layer.shadowOpacity = 0.8;
    //阴影宽度
    _titleLabel.layer.shadowRadius = 1.0;
    //阴影颜色
    _titleLabel.layer.shadowColor = RGB(214, 214, 214).CGColor;
    //映影偏移
    _titleLabel.layer.shadowOffset = CGSizeMake(1, 1);
    _titleLabel.font = [UIFont systemFontOfSize:20];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.top.equalTo(wSelf.view.mas_top).offset(34);
        make.width.offset(150);
        make.height.offset(34);
    }];
    

    
    _carousel = [[iCarousel alloc] init];
    _carousel.type = iCarouselTypeCustom;// 必须在下面的之前设置，不然需要 reload
    _carousel.tag = 10002;
//    _carousel.scrollSpeed = 10;
    _carousel.delegate = self;
//    _carousel.decelerationRate = 2;
    _carousel.dataSource = self;
    _carousel.pagingEnabled=YES;
//    [_carousel scrollToItemAtIndex:1 animated:YES];
    _carousel.currentItemIndex = self.iCarouselindex;

    [self.view addSubview:_carousel];
    [_carousel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wSelf.view.mas_bottom).offset(-10);
        make.height.offset(190);
        make.left.equalTo(wSelf.view).offset(65);
        make.right.equalTo(wSelf.view.mas_right).offset(-65);
    }];
    
    self.modelJump = _dataArr[0];
}



- (void)dealloc{
    NSLog(@"%@: 已经销毁",self);
}



#pragma mark  ---------------自定义方法-------------

- (void)followAndUnfollowAction {
    ______WS();
    self.viewTjuser = (TjUserView *)self.carousel.currentItemView;
    
    if (!self.viewTjuser.isFollow) {
        [self.viewTjuser.followBtn setTitle:@"Following" forState:(UIControlStateNormal)];
        [self.viewTjuser.followBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        self.viewTjuser.followBtn.backgroundColor = RGB(223, 63, 101);
        NSInteger index = self.carousel.currentItemIndex;
        DynamicModel *model = _dataArr[index];
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
        NSDictionary *parDic = @{@"targetId":model.userid,
                                 @"token":userDic[@"token"],
                                 @"userid":userDic[@"userid"]};
        [[DJHttpApi shareInstance] POST:AddFollowUrl dict:parDic succeed:^(id data) {
            //            [[DJHManager shareManager] toastManager:@"following" superView:wSelf.view];
            //        [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendPost" object:self];
            
            wSelf.viewTjuser.isFollow = YES;
        } failure:^(NSError *error) {
            
        }];
    }else{
        [self.viewTjuser.followBtn setTitle:@"+Follow" forState:(UIControlStateNormal)];
        [self.viewTjuser.followBtn setTitleColor:RGB(223, 63, 101) forState:(UIControlStateNormal)];
        self.viewTjuser.followBtn.backgroundColor = [UIColor whiteColor];
        NSInteger index = self.carousel.currentItemIndex;
        DynamicModel *model = _dataArr[index];
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
        NSDictionary *parDic = @{@"targetId":model.userid,
                                 @"token":userDic[@"token"],
                                 @"userid":userDic[@"userid"]};
        [[DJHttpApi shareInstance] POST:deleteFollowUrl dict:parDic succeed:^(id data) {
            //            [[DJHManager shareManager] toastManager:@"following" superView:wSelf.view];
            //        [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendPost" object:self];
            
            wSelf.viewTjuser.isFollow = NO;
        } failure:^(NSError *error) {
            
        }];
    }
    
}



//- (void)tapAction{
//    self.hidesBottomBarWhenPushed = YES;
//    HisViewController *vc = [[HisViewController alloc] init];
//    vc.model = self.modelJump;
//    [self.navigationController pushViewController:vc animated:YES];
//}



#pragma mark  ---------------iCarousel Delegate-------------
- (CGFloat)carouselItemWidth:(iCarousel *)carousel{
    if (carousel.tag == 10001) {
        return kScreenWidth;
    }
    return 290;
}


-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.dataArr.count;
    //    return 50;
    
}

-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
    //    TjUserView *userView = nil;
    
    //    if (!view) {
    DynamicModel *model = _dataArr[index];

    if (carousel.tag == 10002) {
        
        TjUserView *userView = [[TjUserView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeadImgAction)];
        [userView.followBtn addTarget:self action:@selector(followAndUnfollowAction) forControlEvents:(UIControlEventTouchUpInside)];
        [userView.headIconImg addGestureRecognizer:tap];
        userView.frame = CGRectMake(0, 0, 270, 260);
        userView.layer.cornerRadius = 8;
        //        userView.backgroundColor = [UIColor whiteColor];
        userView.layer.borderWidth = 1;
        [userView.layer setBorderColor:[UIColor clearColor].CGColor];
        
        if ([model.isFollowing integerValue] == 1) {
            userView.isFollow = YES;
        }
        userView.model = model;
        userView.nameLab.text = model.nickname;
        userView.textView.text = model.introduce;
        userView.followLab.text =[NSString stringWithFormat:@"follow   %@",model.followerNum];
        userView.fowllowingLab.text =[NSString stringWithFormat:@"following   %@",model.followingNum];
        return userView;
    }else{
        
        UIView *img = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        UIImageView *imgB = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//        ((UIImageView *)img).image = [UIImage imageNamed:@"placeholderImg"];
//        ((UIImageView *)view).image = [UIImage imageNamed:[self.dataList objectAtIndex:index]];
        [img addSubview:imgB];
        [imgB sd_setImageWithURL:[NSURL URLWithString:model.backgroundUrl] placeholderImage:[UIImage imageNamed:@"normorBGIMG"]];
        return img;
    }
}


-(void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
    NSLog(@"carousel %ld",(long)carousel.currentItemIndex);
    
//    _iCarouselindex = carousel.currentItemIndex;
    
}



- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel {
    NSLog(@"Index: %@", @(self.carousel.currentItemIndex));
//    RecommendModel *model = _dataArr[self.carousel.currentItemIndex];
    self.modelJump = _dataArr[self.carousel.currentItemIndex];
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.backgroundUrl]  placeholderImage:nil options:(SDWebImageRefreshCached)];
    if (carousel.tag == 10001) {
        _carousel.currentItemIndex = _carouselImgBack.currentItemIndex;

    }else{
        _carouselImgBack.currentItemIndex = _carousel.currentItemIndex;
    }
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if (carousel.tag == 10001) {
        DynamicModel *model = _dataArr[self.carousel.currentItemIndex];
        self.hidesBottomBarWhenPushed = YES;
        HisViewController *vc = [[HisViewController alloc] init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
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
            if (carousel.tag == 10001) {
                return value;
            }else{
                return value * 1.1f;
            }
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


//- (void)carouselDidScroll:(iCarousel *)carousel{
//    if(carousel == self.carousel)
//    {
//     
//        NSLog(@"%@",carousel);
//        NSLog(@"%f --- ",carousel.scrollOffset);
//        self.carouselImgBack.delegate = nil;
//        self.carouselImgBack.scrollOffset = self.carousel.scrollOffset;
////        [self.carouselImgBack   setViewpointOffset:self.carousel.viewpointOffset];
////        self.carouselImgBack.contentOffset = self.carousel.contentOffset;
//        self.carouselImgBack.delegate = self;
//    }else {
//        self.carousel.delegate = nil;
////        [self.carousel setViewpointOffset:self.carouselImgBack.contentOffset];
////        self.carousel.contentOffset = self.carouselImgBack.contentOffset;
//        self.carousel.scrollOffset = self.carouselImgBack.scrollOffset;
//        self.carousel.delegate = self;
//    }
//}


#pragma mark  ---------------自定义方法-------------

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
    self.carousel.hidden = YES;
    self.carouselImgBack.hidden = YES;
}


- (void)tapHeadImgAction{
    NSLog(@"点击了头像");
}


#pragma mark  ---------------View Delegate-------------
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.carousel.hidden = YES;
    self.carouselImgBack.hidden = YES;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.carousel.hidden = NO;
    self.carouselImgBack.hidden = NO;
}

- (UIImage *)downImage:(NSString *)imageUrl {
    ______WS();
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageRefreshCached
                                                   progress:^(NSInteger receivedSize, NSInteger expectedSize)
     {
         //处理下载进度
     } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
         if (error) {
         }
         if (image) {
             wSelf.downImage = image;
         }
     }];
    return wSelf.downImage;
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
