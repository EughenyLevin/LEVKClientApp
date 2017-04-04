//
//  LECounterCell.h
//  LEVKClientApp
//
//  Created by Evgheny on 28.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LEUser;

typedef enum {
    
    CounterCellSegueFriends,
    CounterCellSegueFollowers,
    CounterCellSegueGroups
    
}CounterCellSegue;

@interface LECounterCell : UITableViewCell <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic) LEUser *currentUser;
@property (weak, nonatomic)  IBOutlet UICollectionView *collectionView;
@property (copy,nonatomic)   void(^segueBlock)(CounterCellSegue row);

@end
