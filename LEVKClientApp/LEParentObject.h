//
//  LEParentObject.h
//  LEVKClientApp
//
//  Created by Evgheny on 02.04.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEParentObject : NSObject

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSURL* photo100URL;
@property (strong, nonatomic) NSURL* photo50URL;

@property (assign, nonatomic, getter = isOnline) BOOL online;
@property (assign, nonatomic) NSInteger ID;

@end
