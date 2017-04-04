//
//  LESideMenuData.m
//  LEVKClientApp
//
//  Created by Evgheny on 04.04.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import "LESideMenuData.h"

@interface LESideMenuData ()
@property (strong,nonatomic) NSArray *cellArray;
@end


@implementation LESideMenuData

-(id)init{
    if (self = [super init]) {
        
        self.cellArray = @[@"Friends",@"Followers",@"Groups"];
    }
    return self;
}
-(NSInteger)countOfCellArray{
    return self.cellArray.count;
}

-(NSString*)objectInCellArrayAtIndex:(NSUInteger)index{
    return [_cellArray objectAtIndex:index];
}

@end
