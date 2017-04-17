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
#import "LESection.h"

@interface LEFriendListController ()

@property (strong,nonatomic) NSArray *friendsArray;
@property (assign,nonatomic) NSInteger      friendsCount;
@property (strong,nonatomic) NSMutableArray *followersArray;
@property (assign,nonatomic) BOOL loadingCell;
@property (strong,nonatomic) NSArray *sectionsArray;
@property (strong,nonatomic) NSBlockOperation *currentGenerateOperation;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

static NSInteger requestCount = 10;

@implementation LEFriendListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.friendsArray   = [NSMutableArray array];
    self.followersArray = [NSMutableArray array];
    self.loadingCell = YES;
    
    if (_friendsFollowers == 0)
        [self getFriendsList];
    
    else if(_friendsFollowers)
        [self getFollowersList];
    
    
   UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetMaxY(self.view.bounds), 44.0f)];
    searchBar.delegate = (id)self;
    [self.view addSubview:searchBar];
    
    self.tableView.tableHeaderView = searchBar;

    
    
   // self.tableView.tintColor = [UIColor vkRedColor];

    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    LESection* sec = [self.sectionsArray objectAtIndex:section];
    
    return [sec.itemsArray count];
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
      
    LESection* section = [self.sectionsArray objectAtIndex:indexPath.section];
    
   // NSString* name = [section.itemsArray objectAtIndex:indexPath.row];
    
        LEUser *friend = [section.itemsArray objectAtIndex:indexPath.row];
        cell.name.text = [NSString stringWithFormat:@"%@ %@",friend.firstName,friend.lastName];
        [cell.friendAvatar setImageWithURL:friend.photo100URL];
    }
    
    return cell;
        
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.sectionsArray objectAtIndex:section] sectionName];
}


#pragma mark - UITableViewDelegate

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    static NSString* identifier = @"Header";

    UITableViewHeaderFooterView* header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];

    LESection* currentSection = [self.sectionsArray objectAtIndex:section];
    
    header.textLabel.text = currentSection.sectionName;
    
    header.textLabel.textColor = [UIColor orangeColor];
    [self.view setNeedsDisplay];
    
    return header;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}


#pragma mark - ServerMethods

-(void)getFriendsList{
    
    [[LEServerManager sharedManager]getFriendsForUserWithID:_userID
                                                 withOffset:self.friendsArray.count
                                                  withCount:requestCount
                                                  onSuccess:^(NSArray *friendsArray, NSInteger count) {
            
                  //  self.friendsCount = count;
                                                    self.friendsArray  =friendsArray;
                                                      
                                                      NSMutableArray* indexPaths = [NSMutableArray array];
                                                      for (int i = 0; i < friendsArray.count; i++) {
                                                          NSIndexPath* indexPath = [NSIndexPath indexPathForRow:[self.friendsArray count] - [friendsArray count] + i
                                                                                                      inSection:0];
                                                          [indexPaths addObject:indexPath];
                                                      }
                                                      
                        [self generateSectionsInBackGroundFromArray:self.friendsArray withFilter:self.searchBar.text];
           
                                                      
                                                      
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
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    
                                      [self.tableView reloadData];
                                    
                                });
                                
                              
                                
}                           onFailure:^(NSError *error) {
    
}];
    
}


-(void)generateSectionsInBackGroundFromArray:(NSArray*)array withFilter:(NSString*)filter{
    
    if (!_currentGenerateOperation.isCancelled) {
        self.currentGenerateOperation = nil;
    }
    
    __weak LEFriendListController *weakSelf = self;
    self.currentGenerateOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        weakSelf.sectionsArray = [weakSelf generateSectionsFromArray:array withFilter:filter];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.tableView reloadData];
            
        });
        
        
    }];
    
    [self.currentGenerateOperation start];
}

-(NSArray*)generateSectionsFromArray:(NSArray*)array withFilter:(NSString*)filter{
    
    NSMutableArray *sectionsArray = [NSMutableArray array];
    NSString *curLetter = nil;
    NSString *firstLetter = nil;
    
    LESection *section = nil;
    
    for (LEUser *user in array) {
     
        if (!self.currentGenerateOperation.isCancelled) {
            NSString *fullName = [NSString stringWithFormat:@"%@ %@",user.firstName,user.lastName];
            
            if (filter.length != 0 && [fullName rangeOfString:filter options:NSCaseInsensitiveSearch].location == NSNotFound) {
                continue;
            }
            
            firstLetter = [user.firstName substringToIndex:1];
         
            if (![curLetter isEqualToString:firstLetter]) {
                section = [LESection new];
                section.sectionName = firstLetter;
                section.itemsArray = [NSMutableArray array];
                
                [sectionsArray addObject:section];
                curLetter = firstLetter;
                
            }
            else{
                
                section = [sectionsArray lastObject];
                
            }
            [section.itemsArray addObject:user];
            
        }
        
        else return array;
        
    }
    
    return sectionsArray;
    
}






#pragma mark - UIScrollViewDelegate



#pragma mark - UISearchBarDelegate -

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    [self generateSectionsInBackGroundFromArray:self.friendsArray withFilter:searchText];
    
}


@end
