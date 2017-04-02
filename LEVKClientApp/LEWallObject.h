//
//  LEWallObject.h
//  LEVKClientApp
//
//  Created by Evgheny on 29.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LEParentObject.h"

@interface LEWallObject : NSObject

@property (assign, nonatomic) NSInteger ID;
@property (assign, nonatomic) NSInteger fromID;

@property (strong,nonatomic) LEParentObject *source;

@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) NSDate* date;
//@property (strong, nonatomic) ParentObject* source;

//@property (strong, nonatomic) Likes* likes;

- (instancetype) initWithItem:(NSDictionary*) item;


@end
