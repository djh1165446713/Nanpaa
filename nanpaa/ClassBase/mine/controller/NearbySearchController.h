//
//  NearbySearchController.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/7.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearbySearchController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *listTeamsArray;
@property (nonatomic,strong) NSMutableArray *listFilterTeamsArray;

//@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic,strong) UISearchController *searchController;

//- (void)filterContentForSearchText:(NSString *)searchText scope:(NSInteger)scope;

@end
