//
//  LEGroupsController.m
//  LEVKClientApp
//
//  Created by Evgheny on 04.04.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import "LEGroupsController.h"
#import "LEServerManager.h"
#import "LENewsPost.h"
#import "UIImageView+AFNetworking.h"
#import "LENewsPostCell.h"

@interface LEGroupsController ()
@property (strong,nonatomic) NSMutableArray *newsArray;
@end

@implementation LEGroupsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.newsArray = [NSMutableArray array];
    [self  getGroupsGromServer];
}

#pragma mark - Server Methods -

-(void)getGroupsGromServer{
    
        [[LEServerManager sharedManager]getNewsForUser:_userID withOffset:_newsArray.count withCount:10 onSuccess:^(NSArray *news) {
            
            [_newsArray addObjectsFromArray:news];
            [self.tableView reloadData];
            
        } onFailure:^(NSError *error) {
            
        }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return _newsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *cellID = @"groupCell";
    LENewsPostCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LENewsPostCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    LENewsPost *post = [_newsArray objectAtIndex:indexPath.row];
    NSURL *imageURL = post.imageURL;
    NSLog(@"URL: %@",imageURL);
    cell.author.text  = post.groupName;
    [cell.authorImage setImageWithURL:imageURL];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
