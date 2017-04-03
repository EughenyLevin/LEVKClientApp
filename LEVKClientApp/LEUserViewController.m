//
//  LEUserViewController.m
//  LEVKClientApp
//
//  Created by Evgheny on 27.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import "LEUserViewController.h"
#import "LEServerManager.h"
#import "LEUserCell.h"
#import "UIImageView+AFNetworking.h"
#import "LEUser.h"
#import "LECounterCell.h"
#import "LEPostCell.h"
#import "LEPost.h"
#import "LEWallImage.h"
#import "LEFriendListController.h"

static CGFloat height = 4;

@interface LEUserViewController ()

@property (strong, nonatomic) LEUser* currentUser;
@property (strong, nonatomic) NSMutableArray* postsArray;

@end

@implementation LEUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.postsArray = [NSMutableArray array];
   
    [self setNavigationBarStyle];
    
    [self getUserInfoWithCompletion:^(BOOL state) {
      
        
    }];
    
    [self getWallWithCompletion:^(BOOL state) {
        
        if (state) {
            [self.tableView setHidden:NO];
        }
    }];

  
  }

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getUserInfoWithCompletion:(void(^)(BOOL state))completion{
    
    [[LEServerManager sharedManager]getInfoForUserWithID:_userID
        onSuccess:^(LEUser *user) {
    
            self.currentUser = user;
            [self.tableView reloadData];
            
            if (completion) {
                completion(YES);
            }
            
            }
    onFailure:^(NSError *error, NSInteger errorCode) {
    
    }];
    
}


-(void)getWallWithCompletion:(void(^)(BOOL state))completion{
    
    [[LEServerManager sharedManager]getWallForUserID:_userID
      withOffset:0
      withCount:100
      onSuccess:^(NSArray *posts, NSInteger count) {
          
          [self.postsArray addObjectsFromArray: posts];
          [self.tableView reloadData];
          NSLog(@"_postsArray: %ld",_postsArray.count);
          
      } onFailure:^(NSError *error) {
          
      }];
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0 ) {
        return 1;
    }
    else if (section == 1){
        return 1;
    }
    else return _postsArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *profileCellID = @"profileCell";
    static NSString *counterCellID = @"counterCell";
    static NSString *postcellID    = @"postCell";
 
    if (indexPath.section == 0){
    
        LEUserCell *profileCell = (LEUserCell*)[tableView dequeueReusableCellWithIdentifier:profileCellID];
   
            if (!profileCell) {
                profileCell = [[LEUserCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:profileCellID];
    }
    
        [profileCell.photo setImageWithURL:self.currentUser.photo100URL];
    
        profileCell.photo.layer.masksToBounds = YES;
        profileCell.photo.layer.cornerRadius = 32;
        profileCell.photo.layer.borderWidth = 1;
        profileCell.photo.layer.borderColor = [UIColor whiteColor].CGColor;
    
        [profileCell setNeedsLayout];

        profileCell.title.text = [NSString stringWithFormat:@"%@ %@",_currentUser.firstName,_currentUser.lastName];
        NSDateFormatter *df = [NSDateFormatter new];
        [df setDateFormat:@"d.M.yyyy"];
        NSString *datestring = [df stringFromDate:_currentUser.longBDate];
       
        if (!datestring) {
            [df setDateFormat:@"M.yyyy"];
            datestring = [df stringFromDate:_currentUser.shortBDate];
        }
        profileCell.bDate.text = datestring;
        profileCell.gender.text = (_currentUser.sex.integerValue ==0) ? @"Male":@"Female";
    
        profileCell.status.text = (_currentUser.online)?@"online":@"offline";
       
        if ([profileCell.status.text isEqualToString:@"online"]) profileCell.status.textColor = [UIColor greenColor];
        else profileCell.status.textColor = [UIColor grayColor];
    
        profileCell.layer.borderColor = [UIColor redColor].CGColor;
        profileCell.layer.borderWidth = 1;
        profileCell.backgroundColor = [UIColor clearColor];
        profileCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        return profileCell;
        
    }

    else if (indexPath.section == 1){
            
            LECounterCell *counterCell = (LECounterCell*)[tableView dequeueReusableCellWithIdentifier:counterCellID];
            
            if (!counterCell) {
                
                counterCell = [[LECounterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:counterCellID];
                
            }
        
        __weak LEUserViewController *weakSelf = self;
        counterCell.currentUser = _currentUser;
        counterCell.segueBlock = ^(CounterCellSegue type){
            
            switch (type) {
                case CounterCellSegueFriends: case CounterCellSegueFollowers:{
                    LEFriendListController  *flc = [weakSelf.storyboard instantiateViewControllerWithIdentifier:@"friendsList"];
                    flc.userID = weakSelf.userID;
                    flc.user   = weakSelf.currentUser;
                    flc.friendsFollowers = type;
                    
                    [weakSelf.navigationController pushViewController:flc animated:YES];
                    
                     break;
                }
                
                   
                    
                default:
                    break;
            }
            
        };
    
        [counterCell.collectionView reloadData];
        
        
        
        return counterCell;
    }
    else {
        
        LEPostCell *postCell = (LEPostCell*)[tableView dequeueReusableCellWithIdentifier:postcellID];
        if (!postCell) {
            postCell = [[LEPostCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:postcellID];
        }
            if (self.postsArray.count) {

            LEPost *post = [self.postsArray objectAtIndex:indexPath.row];
                if (post.text) {
                    
                    NSDateFormatter *df = [NSDateFormatter new];
                    [df setDateFormat:@"dd.mm.yy"];
                    postCell.posDate.text  = [df stringFromDate: post.date];
                    postCell.postText.text = post.text;
                    NSString *postAuthor = [NSString stringWithFormat:@"%@ %@",post.source.firstName, post.source.lastName];
                    
                    postCell.fromUser.text = postAuthor;
                    LEWallImage *image = [post.photos objectAtIndex:indexPath.row];
                    [postCell.postView setImageWithURL:image.photo130];
                    [postCell.authorPhoto setImageWithURL:post.source.photo100URL];
                    postCell.postLikes.text = [NSString stringWithFormat:@"%ld",post.like.likesCount];
                    
                }
                else NSLog(@"ALERT!!!");
        }
        
        return postCell;
        
    }
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    switch (indexPath.section) {
        case 0: return 120;
        case 1: return 50;
        case 2: return 220;
            
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return height;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return height;
    
}

- (IBAction)onLikeButClick:(id)sender {
    
    
}
#pragma mark - UINavigationBar gradient -


-(void)setNavigationBarStyle{
    
    UIColor *barTintColor = [UIColor colorWithRed:64/256 green:86/256 blue:106/256 alpha:1];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = barTintColor;
    self.navigationController.navigationBar.backgroundColor =  [UIColor redColor];
}


@end
