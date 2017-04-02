//
//  LEPost.m
//  LEVKClientApp
//
//  Created by Evgheny on 29.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import "LEPost.h"
#import "LEWallImage.h"

@implementation LEPost

-(instancetype)initWithItem:(NSDictionary *)item{
    
    if (self = [super initWithItem:item]) {
        
        self.ownerID = [[item objectForKey:@"owner_id"]integerValue];
        
        
        self.photos = [NSMutableArray array];
        for (NSDictionary *attachment in [item objectForKey:@"attachments"]) {
            if ([[attachment objectForKey:@"type"]isEqualToString:@"photo"]) {
                LEWallImage *image  = [[LEWallImage alloc]initWithResponce:[attachment  objectForKey:@"photo"]];
                [_photos addObject:image];
            }
        }
        
        
        
    }
    return self;
}

@end
