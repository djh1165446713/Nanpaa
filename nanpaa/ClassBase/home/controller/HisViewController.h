//
//  HisViewController.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/9.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"
#import "FollowModel.h"
#import "DynamicModel.h"
@interface HisViewController : UIViewController
@property (nonatomic, strong) RecommendModel *model1;

@property (nonatomic, strong) DynamicModel *model;
@property (nonatomic, strong) NSString *userid;
@end
