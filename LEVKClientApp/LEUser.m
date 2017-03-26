//
//  LEUser.m
//  LEVKClientApp
//
//  Created by Evgheny on 24.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import "LEUser.h"

@implementation LEUser

-(LEUser*)initWithDict:(NSDictionary *)data{
    if (self = [super init]) {
        
        self.firstName = [data objectForKey:@"first_name"];
        self.lastName = [data objectForKey:@"last_name"];
        self.photo100URL = [NSURL URLWithString:[data objectForKey:@"photo_100"]];
        self.online = [[data objectForKey:@"online"] boolValue];
        self.ID = [[data objectForKey:@"id"] integerValue];
       // self.canWritePrivateMessages = [[data objectForKey:@"can_write_private_message"] boolValue];
        
    }
    
    return self;
}

-(LEUser*)initWithResponseForMScreen:(NSDictionary *)data{
    
    if (self = [super init]) {
        
        self.firstName = [data objectForKey:@"first_name"];
        self.lastName = [data objectForKey:@"last_name"];
        self.photo100URL = [NSURL URLWithString:[data objectForKey:@"photo_100"]];
        self.online = [[data objectForKey:@"online"] boolValue];
        self.ID = [[data objectForKey:@"id"] integerValue];
        //self.photoMaxURL = [NSURL URLWithString:[data objectForKey:@"photo_max"]];
        
    }
    
    return self;
    
}

@end
