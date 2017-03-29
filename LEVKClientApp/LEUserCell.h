//
//  LEUserCell.h
//  LEVKClientApp
//
//  Created by Evgheny on 27.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LEUserCell : UITableViewCell

@property (weak,nonatomic) IBOutlet UILabel    *title;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *gender;
@property (weak, nonatomic) IBOutlet UILabel *bDate;

@end
