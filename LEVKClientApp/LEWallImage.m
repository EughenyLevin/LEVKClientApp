//
//  LEWallImage.m
//  LEVKClientApp
//
//  Created by Evgheny on 29.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import "LEWallImage.h"

@implementation LEWallImage
- (instancetype)initWithResponce:(NSDictionary*) responce
{
    self = [super init];
    if (self) {
        
        if ([responce objectForKey:@"post_id"])
            self.postID = [[responce objectForKey:@"post_id"] longValue];
        
        if ([responce objectForKey:@"id"])
            self.photoID = [[responce objectForKey:@"id"] longValue];
        
        if ([responce objectForKey:@"owner_id"])
            self.ownerID = [[responce objectForKey:@"owner_id"] longValue];
        
        self.text = [responce objectForKey:@"text"];
        
        if ([responce objectForKey:@"album_id"])
            self.albumID = [[responce objectForKey:@"album_id"] longValue];
        
        if ([responce objectForKey:@"user_id"])
            self.userLoadedID = [[responce objectForKey:@"user_id"] longValue];
        
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:[[responce objectForKey:@"date"] longValue]];
        
        self.date = date;
        
        self.heigth = [[responce objectForKey:@"height"] integerValue];
        self.width = [[responce objectForKey:@"width"] integerValue];
        
        
        self.photo75 = [NSURL URLWithString:[responce objectForKey:@"photo_75"]];
        self.photo130 = [NSURL URLWithString:[responce objectForKey:@"photo_130"]];
        self.photo604 = [NSURL URLWithString:[responce objectForKey:@"photo_604"]];
        self.photo807 = [NSURL URLWithString:[responce objectForKey:@"photo_807"]];
        self.photo1280 = [NSURL URLWithString:[responce objectForKey:@"photo_1280"]];
        self.photo2560 = [NSURL URLWithString:[responce objectForKey:@"photo_2560"]];
        
        
    }
    return self;
}

@end
