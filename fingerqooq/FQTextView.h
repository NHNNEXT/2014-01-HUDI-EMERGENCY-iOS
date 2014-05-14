//
//  FQTextView.h
//  fingerqooq
//
//  Created by 이상진 on 2014. 5. 14..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FQTextView : UITextView<UITextViewDelegate>{
    UIImageView *titleImageView;
    UIView *blurView, *whiteBgView;
    UILabel *titleLabel;
    BOOL isHighlightMenuSet, isSelection;
}

-(id)initWithFrame:(CGRect)frame title:(NSString*)title image:(UIImage*)image contents:(NSString*)contents;
-(void)setHighlightText;
-(void)setTextWithHtmlString:(id)string;
-(void)initInset;

-(void)initHighlightMenu;



@end
