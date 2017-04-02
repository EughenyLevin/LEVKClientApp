//
//  LEPost.h
//  LEVKClientApp
//
//  Created by Evgheny on 29.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import "LEWallObject.h"
#import "LELike.h"
@interface LEPost : LEWallObject

@property (assign,nonatomic)  NSInteger ownerID;
@property (strong,nonatomic)  NSMutableArray *photos;
@property (strong,nonatomic)  LELike *like;
@end
