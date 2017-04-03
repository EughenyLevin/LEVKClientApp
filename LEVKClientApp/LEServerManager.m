//
//  LEServerManager.m
//  LEVKClientApp
//
//  Created by Evgheny on 24.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import "LEServerManager.h"
#import "AFNetworking.h"
#import "LEUser.h"
#import "LELoginViewController.h"
#import "LEAccessToken.h"
#import "LECity.h"
#import "LEUserCounters.h"
#import "LEPost.h"


static NSString *responseKey = @"response";

@interface LEServerManager ()

@property (strong,nonatomic) AFHTTPSessionManager *sessionManager;
@property (strong, nonatomic) LEAccessToken* token;
@end

@implementation LEServerManager

#pragma mark - ManagerInit -

+(instancetype)sharedManager{
    
    static LEServerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [LEServerManager new];
    });
   
    return manager;
    
}

-(id)init{
    
    if (self = [super init]) {
        
        NSURL *url = [NSURL URLWithString:@"https://api.vk.com/method/"];
        _sessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:url];
    }
    return self;
}
/*
-(void)getUserWithID:(NSInteger)userID onSuccess:(void (^)(LEUser *))success onFailure:(void (^)(NSError *))failure{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @(userID),   "@user_ids",
                             @"photo_100, can_write_private_message",@"fields",
                             @"nom",@"name_case",
                             @5.8, @"v"
                            , nil];
    [self.sessionManager GET:@"users.get" parameters:params
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                         NSLog(@"Response: %@",responseObject);
                         
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"%@",[error localizedDescription]);
                     }];
    
    
}
 */
-(void)authoriseOnScreen:(UIViewController *)screen onCompletion:(void (^)(NSInteger))handler{
    
    LELoginViewController *vc = [[LELoginViewController alloc] initWithcompletion:^(LEAccessToken *token) {
        
        self.token = token;
        
        NSInteger ID = token.userID;
        self.authorizedUserID = ID;
        
        if (token) {
            if (handler) {
                handler(ID);
            }
        } else {
            if (handler)
                handler(-1);
        }
        
    }];
    
    
    [screen.navigationController pushViewController:vc animated:NO];
    

    
}

///////////////////////////////////--User page--////////////////////////////////////////////////

-(void)getWallForUserID:(NSInteger)ID withOffset:(NSInteger)offset withCount:(NSInteger)count onSuccess:(void (^)(NSArray *, NSInteger))success onFailure:(void (^)(NSError *))failure{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @(ID),          @"owner_id",
                            @(offset),      @"offset",
                            @(count),       @"count",
                            @"all",         @"filter",
                            @1,             @"extended",
                            @"first_name, last_name, online, photo_100, can_write_private_message", @"fields",
                            self.token.token, @"access_token",
                            @5.42,           @"v",
                            nil];
    
    [self.sessionManager GET:@"wall.get"
                  parameters:params progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         
                         NSDictionary *responseDict = [responseObject objectForKey:@"response"];

                         //NSLog(@"responseDict: %@",responseDict);
                         
                         
                         NSArray *itemsArray = [responseDict objectForKey:@"items"];
                         NSArray *usersArray = [responseDict objectForKey:@"profiles"];
                         
                         NSMutableArray* posts = [NSMutableArray array];
                         
                         for(NSDictionary *item in itemsArray){
                       
                             LEPost *post = [[LEPost alloc]initWithItem:item];
                             LELike *like = [LELike new];
                             like.likesCount = [[[item objectForKey:@"likes"]objectForKey:@"count"]integerValue];
                             post.like = like;
                             
                             for (NSDictionary *profile in usersArray) {
                                 
                                 LEPost *requredPost = nil;
                                 
                                 if ([[profile objectForKey:@"id"]integerValue]==post.fromID) {
                                     requredPost = post;
                                 }
                                 
                                 if (requredPost) {
                                     LEUser *fromUser = [[LEUser alloc]initWithDict:profile];
                                     requredPost.source = (LEParentObject*)fromUser;
                                   
                                 }
                                 
                             }
                             
                             
                             [posts addObject:post];
                             
                           
                         }
                         
                         if (success) {
                             success(posts,[[responseDict objectForKey:@"count"]integerValue]);
                         }
                         
                         
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                         NSLog(@"WALL ERROR! %@",[error localizedDescription]);
                         
                     }];
    
    
    
    
}

-(void)getInfoForUserWithID:(NSInteger)userID onSuccess:(void (^)(LEUser *))success onFailure:(void (^)(NSError *, NSInteger))failure{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @(userID), @"user_ids",
                            @"photo_max, photo_100, bdate, city, online, counters, can_post, can_write_private_message",       @"fields",
                            @"nom",                               @"name_case",
                            self.token.token,                     @"access_token",nil];
    
    [self.sessionManager GET:@"users.get" parameters:params progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                         NSArray *respArray = [responseObject objectForKey:@"response"];
                         
                         
                         NSDictionary *responseUser = [respArray firstObject];
                         LEUser *user  = [[LEUser alloc]initWithResponseForMScreen:responseUser];
                         
                         
                         LEUserCounters *counters = [[LEUserCounters alloc]initWithData:[responseUser objectForKey:@"counters"]];
                         
                         user.counters = counters;
                         
                         if (success) success(user);
                         
                         
                         
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                     }];
    
    
}


-(void)getFriendsForUserWithID:(NSInteger)userID withOffset:(NSInteger)offset
                     withCount:(NSInteger)count
                     onSuccess:(void (^)(NSArray *, NSInteger))success
                     onFailure:(void (^)(NSError *))failure{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @(userID), @"user_id",
                            @"name"  , @"order",
                            @(count) , @"count",
                            @(offset), @"offset",
                            @"photo_100, online"  , @"fields",
                            @5.8, @"v",
                            nil];
    
    [self.sessionManager GET:@"friends.get"
        parameters:params progress:nil
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *responseDict  = [responseObject objectForKey:@"response"];
            NSInteger friendsCount = [[responseDict objectForKey:@"count"]integerValue];
            NSArray* responseArray       = [responseDict objectForKey:@"items"];
            NSMutableArray *friendsArray = [NSMutableArray array];
          
            for (NSDictionary *friendData in responseArray) {
                
                LEUser *friend = [[LEUser alloc]initWithDict:friendData];
                [friendsArray addObject:friend];
            }
            if (success) {
                success(friendsArray,friendsCount);
            }
            
            
            
        }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    
}

-(void)getFollowersForUser:(NSInteger)userID
                withOffset:(NSInteger)offset
                 withCount:(NSInteger)count
                 onSuccess:(void (^)(NSArray *))success
                 onFailure:(void (^)(NSError *))failure{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @(userID), @"user_id",
                            @"name"  , @"order",
                            @(count) , @"count",
                            @(offset), @"offset",
                            @"photo_100, online",  @"fields",
                            nil];
    [self.sessionManager GET:@"users.getFollowers" parameters:params progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         
                         NSLog(@"Folllowers: %@",responseObject);
                         
                         NSDictionary *responseDict  = [responseObject objectForKey:@"response"];
                         NSArray      *responseArray = [responseDict objectForKey:@"items"];
                         NSMutableArray *followers = [NSMutableArray array];
                         for (NSDictionary *userInfo in responseArray) {
                             
                             LEUser *follower = [[LEUser alloc]initWithDict:userInfo];
                             [followers addObject:follower];
                         }
                         if (success) {
                             success(followers);
                         }
                         
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                                                  
                     }];
}

@end
