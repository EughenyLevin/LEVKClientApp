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


@interface LEUserViewController ()

@property (strong, nonatomic) LEUser* currentUser;
@property (strong, nonatomic) NSMutableArray* postsArray;

@end

@implementation LEUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSLog(@"ID  = %ld",_userID);
    [self getUserInfoWithCompletion:^(BOOL state) {
      
    }];
    
    
    
    
   // [self getWallWithCompletion:^(BOOL state) {
    
    //}];
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
            
           
            
            }
    onFailure:^(NSError *error, NSInteger errorCode) {
    
    }];
    
}


-(void)getWallWithCompletion:(void(^)(BOOL state))completion{
    
    [[LEServerManager sharedManager]getWallForUserID:_userID
      withOffset:0
      withCount:100
      onSuccess:^(NSArray *posts, NSInteger count) {
          
          NSLog(@"SUCCESS!");
          
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
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *profileCellID = @"profileCell";
    static NSString *counterCellID = @"counterCell";
 
    if (indexPath.section == 0){
    
        LEUserCell *profileCell = (LEUserCell*)[tableView dequeueReusableCellWithIdentifier:profileCellID];
   
            if (!profileCell) {
                profileCell = [[LEUserCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:profileCellID];
    }
    
        [profileCell.photo setImageWithURL:self.currentUser.photo100URL];
    
        profileCell.photo.layer.masksToBounds = YES;
        profileCell.photo.layer.cornerRadius = 32;
        profileCell.photo.layer.borderWidth = 2;
        profileCell.photo.layer.borderColor = [UIColor greenColor].CGColor;
    
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

    else {
            
            LECounterCell *counterCell = (LECounterCell*)[tableView dequeueReusableCellWithIdentifier:counterCellID];
            
            if (!counterCell) {
                
                counterCell = [[LECounterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:counterCellID];
                
                
            }
        counterCell.currentUser = _currentUser;
        [counterCell.collectionView reloadData];
        
        return counterCell;
    }
    

    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
