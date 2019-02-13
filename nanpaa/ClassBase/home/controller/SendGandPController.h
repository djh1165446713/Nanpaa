//
//  SendGandPController.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/9.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "BaseController.h"
#import "DynamicModel.h"
@interface SendGandPController : BaseController
@property (nonatomic, strong) DynamicModel *model;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) UILabel *valueLab;

@end
