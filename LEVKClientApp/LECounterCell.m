//  LECounterCell.m
//  LEVKClientApp
//
//  Created by Evgheny on 28.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import "LECounterCell.h"
#import "LEUser.h"
#import "LECounterCollctionCell.h"

@implementation LECounterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate   = self;
    
    self.preservesSuperviewLayoutMargins = NO;
    self.layoutMargins = UIEdgeInsetsZero;
    
}

#pragma mark - Methods

-(void)generateTitle:(NSString**)title nadCount:(NSString**)count
             andType:(CounterCellSegue*)type
        forIndexPath:(NSIndexPath*)indexPath{
    
    NSArray *titles = @[@"Friends",@"Followers",@"Groups"];
    
    NSInteger index;
    
    switch (indexPath.item) {
        
        case 0:
            
            index = indexPath.item;
            *count = [NSString stringWithFormat:@"%ld",self.currentUser.counters.friends];
            *type  = CounterCellSegueFriends;
            break;
        
        case 1:
            
            index = indexPath.item;
            *count = [NSString stringWithFormat:@"%ld",self.currentUser.counters.followers];
            *type  = CounterCellSegueFollowers;
            break;
        case 2:
            
            index = indexPath.item;
            *count = [NSString stringWithFormat:@"%ld",self.currentUser.counters.groups];
            break;
            
            
        default:
            break;
    }
    
    *title = [titles objectAtIndex:index];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSInteger count = 0;
    self.currentUser.counters.friends?   count++ : count;
    self.currentUser.counters.followers? count++ : count;
    self.currentUser.counters.groups?    count++ : count;

    return count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    

    static NSString *identifier = @"counterCell";
    
    LECounterCollctionCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    NSString *title = [NSString string];
    NSString *count = [NSString string];
    CounterCellSegue  type;
    [self generateTitle:&title nadCount:&count andType:&type forIndexPath:indexPath];

    collectionCell.groupLabel.text = title;
    collectionCell.countLabel.text = count;
    collectionCell.segueType = type;
    
    [collectionCell layoutIfNeeded];
    
    return collectionCell;
}

#pragma mark - UICollectionViewDelegate - 

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LECounterCollctionCell *cell = (LECounterCollctionCell*)[collectionView cellForItemAtIndexPath:indexPath];
    self.segueBlock(cell.segueType);
    NSLog(@"SEGUETYPE: %u",cell.segueType);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}



@end
