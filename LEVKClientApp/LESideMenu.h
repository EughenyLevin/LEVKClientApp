//
//  LESideMenu.h
//  LEVKClientApp
//
//  Created by Evgheny on 04.04.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEUser.h"

@interface LESideMenu : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) LEUser *user;

@end
