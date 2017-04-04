//
//  LEUserCounters.h
//  LEVKClientApp
//
//  Created by Evgheny on 28.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEUserCounters : NSObject

@property (assign,nonatomic) NSInteger followers;
@property (assign, nonatomic) NSInteger friends;
@property (assign, nonatomic) NSInteger groups;

-(LEUserCounters*)initWithData:(NSDictionary*)data;

@end
