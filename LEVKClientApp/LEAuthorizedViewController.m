//
//  LEAuthorizedViewController.m
//  LEVKClientApp
//
//  Created by Evgheny on 24.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import "LEAuthorizedViewController.h"
#import "LEServerManager.h"
@interface LEAuthorizedViewController ()

@end

@implementation LEAuthorizedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [[LEServerManager sharedManager]authoriseOnScreen:self onCompletion:^(NSInteger userID) {
        
        NSLog(@"USERID: %ld",userID);
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
