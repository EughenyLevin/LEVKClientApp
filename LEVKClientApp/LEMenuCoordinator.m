//
//  LEMenuCoordinator.m
//  LEVKClientApp
//
//  Created by Evgheny on 04.04.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import "LEMenuCoordinator.h"
#import "LEUserViewController.h"
#import "LESideMenu.h"

static float     duration     = 0.5;
static float     delay        = 0.0;
static NSInteger cornerRadius = 10;

@interface LEMenuCoordinator ()
@property (strong,nonatomic) LEUserViewController *userVC;
@property (strong,nonatomic) LESideMenu           *sideMenuVC;
@end


@implementation LEMenuCoordinator

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showingSideMenu = NO;
    [self setNavigationBarStyle];
    [self setupView];
}

#pragma mark - sideMenuAction -

-(void)onMenu{
   if(!_showingSideMenu) [self movePanelRight];
   else [self movePanelToOriginalPosition];
}

-(void)setupView{
    
    self.userVC = [self.storyboard instantiateViewControllerWithIdentifier:@"fullInfoVC"];
    self.userVC.userID = _userId;
    self.userVC.delegate = (id)self;
    [self.view addSubview:self.userVC.view];
    [self addChildViewController:_userVC];
    
    [_userVC didMoveToParentViewController:self];
    
}

-(UIView*)getLEftView{
    
    if (_sideMenuVC == nil) {
        self.sideMenuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"menu"];
        self.sideMenuVC.user = self.userVC.currentUser;
        self.sideMenuVC.userID = self.userId;
        [self.view addSubview:_sideMenuVC.view];
        [self addChildViewController:_sideMenuVC];
        [_sideMenuVC didMoveToParentViewController:self];
        _sideMenuVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    UIView *view = self.sideMenuVC.view;
    _showingSideMenu = YES;
    return view;
    
}

-(void)movePanelRight{
    
    UIView *childView = [self getLEftView];
    [self.view sendSubviewToBack:childView];
    
    [UIView animateWithDuration:0.5 delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         self.userVC.view.frame = CGRectMake(self.view.frame.size.width - 90, 0, self.view.frame.size.width, self.view.frame.size.height);
                             [self showCenterViewWithShadow:YES withOffset:-2];
                     } completion:^(BOOL finished) {
                        
                     }];
}

-(void)movePanelToOriginalPosition{
    
    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
         self.userVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
    } completion:^(BOOL finished) {
        if (finished) {
         
            [self resetMainView];
            
            [self showCenterViewWithShadow:NO withOffset:0];
        }
        
        
    }];
    
}

- (void)resetMainView
{
    if (_sideMenuVC !=nil) {
        
        [_sideMenuVC.view removeFromSuperview];
        _sideMenuVC= nil;
         _showingSideMenu = NO;
    }
     [self showCenterViewWithShadow:NO withOffset:0];
    
}

-(void)showCenterViewWithShadow:(BOOL)value withOffset:(NSInteger)offset{
    
    if (value)
    {
        [_userVC.view.layer setCornerRadius:cornerRadius];
        [_userVC.view.layer setShadowColor:[UIColor blackColor].CGColor];
        [_userVC.view.layer setShadowOpacity:0.8];
        [_userVC.view.layer setShadowOffset:CGSizeMake(offset, offset)];
        
    }
    else
    {
        [_userVC.view.layer setCornerRadius:0.0f];
        [_userVC.view.layer setShadowOffset:CGSizeMake(offset, offset)];
    }
    
}

#pragma mark - UINavigationBar gradient -


-(void)setNavigationBarStyle{
    
    UIColor *barTintColor = [UIColor colorWithRed:64/256 green:86/256 blue:106/256 alpha:1];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = barTintColor;
    self.navigationController.navigationBar.backgroundColor =  [UIColor redColor];
    
    
    NSString *butImage =  [[NSBundle mainBundle]pathForResource:@"arrow" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:butImage];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(onMenu) forControlEvents:UIControlEventTouchUpInside]; //adding action
    [button setBackgroundImage:image forState:UIControlStateNormal];
    button.frame = CGRectMake(0 ,0,35,35);
   
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButton;
   
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
