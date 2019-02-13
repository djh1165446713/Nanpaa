//
//  KBTabbarController.m
//  KBTabbarController
//
//  Created by kangbing on 16/5/31.
//  Copyright © 2016年 kangbing. All rights reserved.
//

#import "KBTabbarController.h"
#import "HomeController.h"
#import "NearbyController.h"
#import "KBTabbar.h"
#import "CeshiViewController.h"

@interface KBTabbarController ()

@end

@implementation KBTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    HomeController *hvc = [[HomeController alloc] init];
    [self addChildController:hvc title:nil imageName:@"message" selectedImageName:@"message-red" navVc:[UINavigationController class]];
    

    NearbyController *MoreVc = [[NearbyController alloc] init];
    [self addChildController:MoreVc title:nil imageName:@"search-white" selectedImageName:@"search-red" navVc:[UINavigationController class]];
    
    
//    [[UITabBar appearance] setBackgroundImage:[self imageWithColor:RGB(28, 30, 58)]];
    [[UITabBar appearance] setBarTintColor:RGB(37, 41, 75)];
    //  设置tabbar
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    // 设置自定义的tabbar
    [self setCustomtabbar];
    
    
    
}



- (void)setCustomtabbar{

    KBTabbar *tabbar = [[KBTabbar alloc]init];
    [self setValue:tabbar forKeyPath:@"tabBar"];
    [tabbar.centerBtn addTarget:self action:@selector(centerBtnClick) forControlEvents:UIControlEventTouchUpInside];

    
}

- (void)centerBtnClick{

    
//    CeshiViewController *vc = [[CeshiViewController alloc] init];
////    NSLog(@"%@",self.navigationController);
//    [self presentViewController:vc animated:YES completion:nil];
   
    [[NSNotificationCenter defaultCenter] postNotificationName:[[NSUserDefaults standardUserDefaults] objectForKey:@"tanchuan" ] object:self userInfo:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildController:(UIViewController*)childController title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName navVc:(Class)navVc
{
    
    childController.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置一下选中tabbar文字颜色
    
    [childController.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }forState:UIControlStateSelected];
    
    UINavigationController* nav = [[navVc alloc] initWithRootViewController:childController];
    
    [self addChildViewController:nav];
}


- (UIImage *)imageWithColor:(UIColor *)color{
    // 一个像素
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}




@end
