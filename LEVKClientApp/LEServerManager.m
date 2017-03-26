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
                        
                         NSLog(@"%@",responseObject);
                         
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"%@",[error localizedDescription]);
                     }];
    
    
}
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


@end
