//
//  LENewsPost.h
//  LEVKClientApp
//
//  Created by Evgheny on 04.04.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LENewsPost : NSObject

@property (assign,nonatomic) NSUInteger groupID;
@property (strong,nonatomic) NSURL     *imageURL;
@property (strong,nonatomic) NSString *groupName;

-(instancetype)initWithData:(NSDictionary*)data;

@end
