//
//  LELoginViewController.h
//  LEVKClientApp
//
//  Created by Evgheny on 24.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LEAccessToken;
@interface LELoginViewController : UIViewController<UIWebViewDelegate>
-(id)initWithcompletion:(void(^)(LEAccessToken *token))completion;
@end
