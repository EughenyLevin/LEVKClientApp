//
//  LEWallObject.m
//  LEVKClientApp
//
//  Created by Evgheny on 29.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import "LEWallObject.h"

@implementation LEWallObject

-(instancetype)initWithItem:(NSDictionary *)item{
    
    if (self = [super init]) {
        
        self.text = [item objectForKey:@"text"];
        
        self.ID = [[item objectForKey:@"id"] integerValue];
        self.fromID = [[item objectForKey:@"from_id"] integerValue];
        
        NSTimeInterval dateInterval = [[item objectForKey:@"date"]integerValue];
        self.date = [NSDate dateWithTimeIntervalSince1970:dateInterval];
        
    }
    
    return self;
}


@end
