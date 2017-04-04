//
//  LEUserViewController.h
//  LEVKClientApp
//
//  Created by Evgheny on 27.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEUser.h"
@protocol LESideMenuDelegate <NSObject>

@required
-(void)movePanelRight;
-(void)movePanelToOriginalPosition;
@end

@interface LEUserViewController : UIViewController<UITabBarDelegate,UITableViewDataSource>

@property (strong, nonatomic) LEUser* currentUser;
@property (weak,nonatomic) id<LESideMenuDelegate>delegate;
@property (assign,nonatomic) NSInteger userID;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
