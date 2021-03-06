//
//  FQTextView.h
//  fingerqooq
//
//  Created by 이상진 on 2014. 5. 14..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"


@interface FQTextView : UITextView<UITextViewDelegate>{
    UIImageView *titleImageView;
    UIView *blurView, *whiteBgView;
    UILabel *titleLabel;
    BOOL isHighlightMenuSet, isShowMenu;
    CGRect fullFrame;
    UIView *menuView;
    AFHTTPRequestOperationManager *manager;
}

@property (strong, nonatomic) UIViewController *viewControllerRef;
@property id articleId;
@property UIScrollView *mainScrollView;

-(id)initWithFrame:(CGRect)frame titleString:(NSString*)title titleImage:(UIImage*)image contentsString:(NSString*)contents;
-(void)setHighlightText;
-(void)setTextWithHtmlString:(id)string;

-(void)initHighlightMenu;

-(void)setTitleString:(NSString*)string;
-(void)setTitleImage:(UIImage*)image;
-(void)setContents:(NSString*)string;


@end
