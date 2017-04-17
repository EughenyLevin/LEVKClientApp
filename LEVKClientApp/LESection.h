//
//  Section.h
//  LEVKClientApp
//
//  Created by Evgheny on 14.04.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LESection : NSObject

@property (strong,nonatomic) NSMutableArray *itemsArray;
@property (strong,nonatomic) NSString       *sectionName;

@end
