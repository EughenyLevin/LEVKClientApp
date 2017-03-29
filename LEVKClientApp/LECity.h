//
//  LECity.h
//  LEVKClientApp
//
//  Created by Evgheny on 27.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LECity : NSObject

@property (assign,nonatomic) NSInteger ID;
@property (strong,nonatomic) NSString  *cityName;

-(LECity*)initWithData:(NSDictionary*)data;

@end
