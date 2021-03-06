//
//  FQViewController.h
//  fingerqooq
//
//  Created by 이상진 on 2014. 5. 13..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "FQTextView.h"
#import "AFNetworking.h"
#import "FQTableView.h"

#import <FacebookSDK/FacebookSDK.h>

@interface FQViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    UIView *contentsView, *touchableView;
    NSMutableArray *contentsViews;
    NSObject *articlesObject;
    NSMutableArray *dataArray;
    AFHTTPRequestOperationManager *manager;
    FQTextView *articleView;
    UIView *menuBar;
    BOOL btnFlag;
    UIButton *btnArticles;
    FQTableView *listTableView;
}
- (void)logout:(id)sender;

@property id FBID;
@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end
