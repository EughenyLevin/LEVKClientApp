//
//  LEWallImage.h
//  LEVKClientApp
//
//  Created by Evgheny on 29.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEWallImage : NSObject
@property (assign, nonatomic) NSInteger heigth;
@property (assign, nonatomic) NSInteger width;
@property (assign, nonatomic) NSInteger photoID;
@property (assign, nonatomic) NSInteger postID;
@property (assign, nonatomic) NSInteger albumID;
@property (assign, nonatomic) NSInteger ownerID;
@property (assign, nonatomic) NSInteger userLoadedID;

@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) NSDate* date;
@property (strong, nonatomic) NSURL* photo75;
@property (strong, nonatomic) NSURL* photo130;
@property (strong, nonatomic) NSURL* photo604;
@property (strong, nonatomic) NSURL* photo807;
@property (strong, nonatomic) NSURL* photo1280;
@property (strong, nonatomic) NSURL* photo2560;
- (instancetype)initWithResponce:(NSDictionary*) responce;
@end
