//
//  LELoginViewController.m
//  LEVKClientApp
//
//  Created by Evgheny on 24.03.17.
//  Copyright © 2017 Eugheny_Levin. All rights reserved.
//

#import "LELoginViewController.h"
#import "LEAccessToken.h"

@interface LELoginViewController ()
@property (copy, nonatomic) void(^completion)(LEAccessToken* token);
@property (weak, nonatomic) UIWebView* webView;
@property (strong, nonatomic) LEAccessToken* token;
@end

@implementation LELoginViewController

-(id)initWithcompletion:(void (^)(LEAccessToken *))completion{
    if (self = [super init]) {
        
        self.completion = completion;
    }
    return self;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:frame];
    
    webView.delegate = self;
    self.webView = webView;
    
    [self.view addSubview:webView];
    
    NSURL* url = [NSURL URLWithString:@"https://oauth.vk.com/authorize?"
                  "client_id=5942498&"
                  //"client_secret=PAMtANozJjpZ5euLj1tl&"
                  "redirect_uri=https://api.vk.com/blank.html&"
                  "display=mobile&"
                  "scope=friends,photos,audio,video,wall,groups,offline,messages&"
                  "response_type=token&"
                  
                  "v=5.42&"];
    
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
    
    [webView loadRequest:request];

}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"%@", [request.URL host]);
    if ([[request.URL host] isEqualToString:@"api.vk.com"]) {
        
        LEAccessToken* token = [[LEAccessToken alloc] init];
        
        NSString* query = [[request URL] description];
        
        NSArray* array = [query componentsSeparatedByString:@"#"];
        
        if (array.count > 1) {
            
            query = [array lastObject];
        }
        NSArray* pairs = [query componentsSeparatedByString:@"&"];
        
        for (NSString* pair in pairs) {
            
            NSArray* values = [pair componentsSeparatedByString:@"="];
            
            if (values.count == 2) {
                
                NSString* key = [values firstObject];
                
                if ([key isEqualToString:@"access_token"]) {
                    token.token = [values lastObject];
                } else if ([key isEqualToString:@"expires_in"]) {
                    
                    NSTimeInterval interval = [[values lastObject] doubleValue];
                    
                    token.date = [NSDate dateWithTimeIntervalSinceNow:interval];
                } else if ([key isEqualToString:@"user_id"]) {
                    token.userID = [[values lastObject] integerValue];
                }
            }
        }
        
        if (self.completion) {
            self.completion(token);
        }
        
        //[self dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }
    
    return YES;
}

#pragma mark - Actions


- (void) dealloc {
    self.webView.delegate = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
