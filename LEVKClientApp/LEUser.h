//
//  LEUser.h
//  LEVKClientApp
//
//  Created by Evgheny on 24.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEUser : NSObject

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSURL* photo100URL;
@property (strong, nonatomic) NSURL* photo50URL;
@property (assign, nonatomic, getter = isOnline) BOOL online;
@property (assign, nonatomic) NSInteger ID;

@property (strong,nonatomic) NSDate *shortBDate;
@property (strong,nonatomic) NSDate *longBDate;
@property (strong,nonatomic) NSURL  *imageURL;
@property (assign, nonatomic) NSInteger followersCount;
@property (assign, nonatomic) NSInteger friendsCount;


-(LEUser*)initWithDict:(NSDictionary*)data;
-(LEUser*)initWithResponseForMScreen:(NSDictionary*)data;

@end
