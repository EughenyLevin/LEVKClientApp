//
//  LENewsPost.m
//  LEVKClientApp
//
//  Created by Evgheny on 04.04.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import "LENewsPost.h"

@implementation LENewsPost

-(id)initWithData:(NSDictionary *)data{
    
    if (self = [super init]) {
        
        self.groupID = [[data objectForKey:@"gid"]integerValue];
        self.groupName = [data objectForKey:@"screen_name"];
        self.imageURL  =  [NSURL URLWithString:[data objectForKey:@"photo"]];//[data objectForKey:@"photo"];
        
    }
    
    return self;
    
}

@end
