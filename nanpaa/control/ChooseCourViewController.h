//
//  ChooseCourViewController.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/24.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>



@interface ChooseCourViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong) NSMutableArray *listTeamsArray;

//@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


//- (void)filterContentForSearchText:(NSString *)searchText scope:(NSInteger)scope;

@end
