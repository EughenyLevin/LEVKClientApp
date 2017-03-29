//
//  LEUserViewController.h
//  LEVKClientApp
//
//  Created by Evgheny on 27.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LEUserViewController : UIViewController<UITabBarDelegate,UITableViewDataSource>

@property (assign,nonatomic) NSInteger userID;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
