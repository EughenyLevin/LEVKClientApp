//
//  LEServerManager.h
//  LEVKClientApp
//
//  Created by Evgheny on 24.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class LEUser;

typedef void(^LESuccessBlock)(LEUser *user);

@interface LEServerManager : NSObject

@property (assign,nonatomic) NSInteger authorizedUserID;

+(instancetype)sharedManager;

-(void)getUserWithID:(NSInteger)userID
           onSuccess:(void(^)(LEUser *user))success
           onFailure:(void(^)(NSError *error))failure;

-(void)authoriseOnScreen:(UIViewController*)screen
            onCompletion:(void(^)(NSInteger userID))handler;


-(void) getWallForUserID:(NSInteger)ID
              withOffset:(NSInteger)offset
               withCount:(NSInteger)count
               onSuccess:(void(^)(NSArray* posts, NSInteger count))success
               onFailure:(void(^)(NSError *error))failure;


-(void)getInfoForUserWithID:(NSInteger)userID
                  onSuccess:(void(^)(LEUser *user))success
                  onFailure:(void(^)(NSError *error, NSInteger errorCode))failure;

@end
