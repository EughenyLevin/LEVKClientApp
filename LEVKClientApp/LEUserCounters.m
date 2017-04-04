//
//  LEUserCounters.m
//  LEVKClientApp
//
//  Created by Evgheny on 28.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import "LEUserCounters.h"

@implementation LEUserCounters

-(LEUserCounters*)initWithData:(NSDictionary *)data{
    
    if (self = [super init]) {
        
        self.friends   = [[data objectForKey:@"friends"]integerValue];
        self.followers = [[data objectForKey:@"followers"]integerValue];
        self.groups    = [[data objectForKey:@"groups"]integerValue];
    }
    
    return self;
}

@end
