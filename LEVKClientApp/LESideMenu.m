//
//  LESideMenu.m
//  LEVKClientApp
//
//  Created by Evgheny on 04.04.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import "LESideMenu.h"
#import "LESideMenuData.h"
#import "UIImageView+AFNetworking.h"
#import "LEGroupsController.h"
#import "LEFriendListController.h"

@interface LESideMenu ()
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (strong,nonatomic) LESideMenuData *data;

@end

@implementation LESideMenu

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data  = [LESideMenuData new];
    [self.image setImageWithURL:_user.photo100URL];
    
}

#pragma mark -UITableViewDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data countOfCellArray];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *cellID = @"menuCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [_data objectInCellArrayAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark -UITableViewDelegate -

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    switch (indexPath.row) {
        case 0:
        {
            LEFriendListController *friendsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"friendsList"];
            friendsVC.user = _user;
            friendsVC.userID = _userID;
            [self.navigationController pushViewController:friendsVC animated:YES];
            
        }
            break;
        case 2: {
            LEGroupsController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"groups"];
            vc.user = _user;
            vc.userID = _userID;
            [self.navigationController pushViewController:vc animated:YES];
        }
        default:
            break;
    }
    
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
