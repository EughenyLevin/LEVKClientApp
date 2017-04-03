//
//  LEFriendListController.h
//  LEVKClientApp
//
//  Created by Evgheny on 03.04.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEUser.h"

@interface LEFriendListController : UITableViewController
@property (assign,nonatomic) NSInteger userID;
@property (strong,nonatomic) LEUser *user;
@property (assign,nonatomic) BOOL friendsFollowers;

@end
