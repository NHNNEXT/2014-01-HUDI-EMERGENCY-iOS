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
#import "GKLParallaxPicturesViewController.h"

@interface FQViewController : UIViewController<UITextViewDelegate>{
    FQTextView *myTextView,*myTextView2,*myTextView3;
    
    UIImageView *testImageView;
    UIView *blurView;
    UILabel *testTitle;
}
@property (strong, nonatomic) IBOutlet UITextView *contentsTextView;
@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end
