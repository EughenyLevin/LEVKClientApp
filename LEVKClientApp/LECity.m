//
//  LECity.m
//  LEVKClientApp
//
//  Created by Evgheny on 27.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import "LECity.h"

@implementation LECity

-(LECity*)initWithData:(NSDictionary *)data{
    
    self = [super init];
         if (self) {
         
             self.ID = [[data objectForKey:@"id"] integerValue];
             self.cityName = [data objectForKey:@"title"];
        
    }
    return self;
    
}

@end
