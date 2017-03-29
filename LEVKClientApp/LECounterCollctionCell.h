//
//  LECounterCollctionCell.h
//  LEVKClientApp
//
//  Created by Evgheny on 28.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LECounterCell.h"

@interface LECounterCollctionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *groupLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (assign,nonatomic) CounterCellSegue segueType;
 
@end
