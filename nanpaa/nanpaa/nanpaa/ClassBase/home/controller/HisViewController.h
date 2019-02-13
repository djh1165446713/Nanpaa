//
//  HisViewController.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/9.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicModel.h"
#import "FollowModel.h"

@interface HisViewController : UIViewController

@property (nonatomic, strong) DynamicModel *model;
@property (nonatomic, strong) NSString *userid;
@end
