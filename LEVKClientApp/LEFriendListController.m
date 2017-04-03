//
//  LEFriendListController.m
//  LEVKClientApp
//
//  Created by Evgheny on 03.04.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import "LEFriendListController.h"
#import "UIColor+LEvkRedColor.h"
#import "UIImageView+AFNetworking.h"
#import "LEServerManager.h"
#import "LEFriendListCell.h"

@interface LEFriendListController ()

@property (strong,nonatomic) NSMutableArray *friendsArray;
@property (assign,nonatomic) NSInteger      friendsCount;
@property (strong,nonatomic) NSMutableArray *followersArray;

@end

static NSInteger requestCount = 20;

@implementation LEFriendListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.friendsArray   = [NSMutableArray array];
    self.followersArray = [NSMutableArray array];
    
    if (_friendsFollowers == 0)
        [self getFriendsList];
    
    else if(_friendsFollowers)
        [self getFollowersList];
    
    
    self.tableView.tintColor = [UIColor vkRedColor];

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (_friendsFollowers) return self.followersArray.count;
    else return self.friendsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    static NSString *cellID = @"friendsListCell";
    LEFriendListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[LEFriendListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (_friendsFollowers) {
        
        LEUser *follower = [self.followersArray objectAtIndex:indexPath.row];
        cell.name.text = [NSString stringWithFormat:@"%@ %@",follower.firstName,follower.lastName];
        [cell.friendAvatar setImageWithURL:follower.photo100URL];
        
    }
    
    else if(!_friendsFollowers) {
        
        LEUser *friend = [self.friendsArray objectAtIndex:indexPath.row];
        cell.name.text = [NSString stringWithFormat:@"%@ %@",friend.firstName,friend.lastName];
        [cell.friendAvatar setImageWithURL:friend.photo100URL];
    }
    
    return cell;
        
    
}
#pragma mark - ServerMethods

-(void)getFriendsList{
    
    [[LEServerManager sharedManager]getFriendsForUserWithID:_userID
                                                 withOffset:self.friendsArray.count
                                                  withCount:requestCount
                                                  onSuccess:^(NSArray *friends, NSInteger count) {
    
                    [self.friendsArray addObjectsFromArray:friends];
                    self.friendsCount = count;
                   
                    [self.tableView reloadData];
                                                      
                                                      
}                                               onFailure:^(NSError *error) {
    NSLog(@"FAILURE %@",[error localizedDescription]);
    
}];
    
}

-(void)getFollowersList{
    
    [[LEServerManager sharedManager]getFollowersForUser:_userID
                                            withOffset:self.friendsArray.count
                                            withCount:requestCount
                            onSuccess:^(NSArray *success) {
    
                                [self.followersArray addObjectsFromArray:success];
                                NSLog(@"Fllowers: %@",_followersArray);
                                [self.tableView reloadData];
                                
}                           onFailure:^(NSError *error) {
    
}];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
