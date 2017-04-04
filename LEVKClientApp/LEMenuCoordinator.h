//
//  LEMenuCoordinator.h
//  LEVKClientApp
//
//  Created by Evgheny on 04.04.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEUserViewController.h"

@interface LEMenuCoordinator : UIViewController<LESideMenuDelegate>
@property (assign,nonatomic) NSInteger userId;
@property (assign,nonatomic)  BOOL   showingSideMenu;
@end
