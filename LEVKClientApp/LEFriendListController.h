//
//  LEFriendListController.h
//  LEVKClientApp
//
//  Created by Evgheny on 03.04.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEUser.h"

@interface LEFriendListController : UIViewController<UITabBarDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (assign,nonatomic) NSInteger userID;
@property (strong,nonatomic) LEUser *user;
@property (assign,nonatomic) BOOL friendsFollowers;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
