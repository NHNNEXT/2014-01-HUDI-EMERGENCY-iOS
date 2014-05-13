//
//  FQTextView.h
//  fingerqooq
//
//  Created by 이상진 on 2014. 5. 14..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FQTextView : UITextView
-(void)setHighlightText;
-(void)setTextWithHtmlString:(id)string;
-(void)initInset;
@end
