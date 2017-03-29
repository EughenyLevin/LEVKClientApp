//
//  LEAuthorizedViewController.m
//  LEVKClientApp
//
//  Created by Evgheny on 24.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import "LEAuthorizedViewController.h"
#import "LEServerManager.h"
#import "LEUserViewController.h"
@interface LEAuthorizedViewController ()

@end

@implementation LEAuthorizedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
  
    
    self.navigationItem.hidesBackButton = YES;
    
    [[LEServerManager sharedManager]authoriseOnScreen:self onCompletion:^(NSInteger userID) {
        
        
          NSLog(@"USERID: %ld",userID);
        
        //self.r.leftViewController = nil;

        LEUserViewController *userVc = [self.storyboard instantiateViewControllerWithIdentifier:@"fullInfoVC"];
        userVc.userID = userID;
        
         [self.navigationController setViewControllers:@[userVc] animated:YES];
        
    }];
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
