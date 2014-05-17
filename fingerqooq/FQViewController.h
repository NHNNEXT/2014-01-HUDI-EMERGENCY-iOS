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

@interface FQViewController : UIViewController<UIScrollViewDelegate>{
    UIView *contentsView, *touchableView;
    NSMutableArray *contentsViews;
    NSObject *articlesObject;
}


@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end
