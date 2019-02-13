
//
//  DjhScrollView.m
//  nanpaa
//
//  Created by bianKerMacBook on 17/1/18.
//  Copyright © 2017年 bianKerMacBookDJH. All rights reserved.
//

#import "DjhScrollView.h"

@implementation DjhScrollView

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]){
    }
    return self;
}

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event
{
    // If not dragging, send event to next responder
    if (!self.dragging)
        [self.nextResponder touchesEnded: touches withEvent:event];
    else
        [super touchesEnded: touches withEvent: event];
}

@end
