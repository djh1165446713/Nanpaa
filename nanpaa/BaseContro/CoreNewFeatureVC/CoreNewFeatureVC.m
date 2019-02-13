//
//  CoreNewFeatureVC.m
//  CoreNewFeatureVC
//
//  Created by 冯成林 on 15/4/27.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CoreNewFeatureVC.h"
#import "NewFeatureScrollView.h"
#import "NewFeatureImageV.h"
#import "UIApplication+Extend.h"
#import "UIView+NFLayout.h"


NSString *const NewFeatureVersionKey = @"NewFeatureVersionKey";

@interface CoreNewFeatureVC ()<UIScrollViewDelegate>


/** 模型数组 */
@property (nonatomic,strong) NSArray *models;

/** scrollView */
@property (nonatomic,weak) NewFeatureScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControll;
@property (nonatomic, strong) UIButton *beginButton;

@property (nonatomic,copy) void(^enterBlock)();

@end

@implementation CoreNewFeatureVC

/*
 *  初始化
 */
+(instancetype)newFeatureVCWithModels:(NSArray *)models enterBlock:(void(^)())enterBlock{
    
    CoreNewFeatureVC *newFeatureVC = [[CoreNewFeatureVC alloc] init];
    
    newFeatureVC.models = models;
    
    //记录block
    newFeatureVC.enterBlock =enterBlock;
    
    return newFeatureVC;
}


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    //控制器准备
    [self vcPrepare];
    
    //显示了版本新特性，保存版本号
    [self saveVersion];
}


/*
 *  显示了版本新特性，保存版本号
 */
-(void)saveVersion{
    
    //系统直接读取的版本号
    NSString *versionValueStringForSystemNow=[UIApplication sharedApplication].version;
    
    //保存版本号
    [[NSUserDefaults standardUserDefaults] setObject:versionValueStringForSystemNow forKey:NewFeatureVersionKey];
}



/*
 *  控制器准备
 */
-(void)vcPrepare{
    
    //添加scrollView
    NewFeatureScrollView *scrollView = [[NewFeatureScrollView alloc] init];
    scrollView.delegate = self;
    _scrollView = scrollView;

    //添加
    [self.view addSubview:scrollView];
    
    //添加约束
    [scrollView autoLayoutFillSuperView];
    
    //添加图片
    [self imageViewsPrepare];
    
    _pageControll = [[UIPageControl alloc] init];
    _pageControll.numberOfPages = self.models.count;
    [self.view addSubview:_pageControll];
    WEAKOBJECT(weakSelf, self);
    [weakSelf.pageControll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view).offset(-15);
        make.centerX.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    _beginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _beginButton.frame = CGRectMake(0, 0, 88, 29);
    _beginButton.center = CGPointMake(self.models.count * kScreenWidth - kScreenWidth/2, kScreenHeight - 70);
    [_beginButton setTitle:@"Let' Start" forState:UIControlStateNormal];
    _beginButton.layer.cornerRadius = 29 / 2;
    _beginButton.layer.masksToBounds = YES;
    _beginButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_beginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _beginButton.layer.borderWidth = 1;
    _beginButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    [_beginButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:_beginButton];
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControll.currentPage = scrollView.contentOffset.x/kScreenWidth;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x/kScreenWidth >self.models.count-2) {
        self.pageControll.alpha = 0;
    }
    else
    {
        self.pageControll.alpha = 1;
    }
}


/*
 *  添加图片
 */
-(void)imageViewsPrepare{
    
    [self.models enumerateObjectsUsingBlock:^(NewFeatureModel *model, NSUInteger idx, BOOL *stop) {
        
        NewFeatureImageV *imageV = [[NewFeatureImageV alloc] init];
        
        //设置图片
        imageV.image = model.image;
        
        //记录tag
        imageV.tag = idx;
        
        if(idx == self.models.count -1) {
            
            //开启交互
            imageV.userInteractionEnabled = YES;
            
            //添加手势
            [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)]];
        }
        
        [_scrollView addSubview:imageV];
    }];
}



-(void)gestureAction:(UITapGestureRecognizer *)tap{
    
    UIView *tapView = tap.view;
    
    //禁用
    tapView.userInteractionEnabled = NO;
    
    if(UIGestureRecognizerStateEnded == tap.state) [self dismiss];
}

-(void)dismiss{
    
    if(self.enterBlock != nil) _enterBlock();
}

/*
 *  是否应该显示版本新特性页面
 */
+(BOOL)canShowNewFeature{
    
    //系统直接读取的版本号
    NSString *versionValueStringForSystemNow=[UIApplication sharedApplication].version;
    
    //读取本地版本号
    NSString *versionLocal = [[NSUserDefaults standardUserDefaults] objectForKey:NewFeatureVersionKey];
    
    if(versionLocal!=nil && [versionValueStringForSystemNow isEqualToString:versionLocal]){//说明有本地版本记录，且和当前系统版本一致
        
        return NO;
        
    }else{//无本地版本记录或本地版本记录与当前系统版本不一致
        
        //保存
        [[NSUserDefaults standardUserDefaults] setObject:versionValueStringForSystemNow forKey:NewFeatureVersionKey];
        
        return YES;
    }
}
@end
