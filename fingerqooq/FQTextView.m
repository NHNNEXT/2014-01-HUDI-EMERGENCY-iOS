//
//  FQTextView.m
//  fingerqooq
//
//  Created by 이상진 on 2014. 5. 14..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "FQTextView.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define MAIN_COLOR 0xe74c3c

@implementation FQTextView


-(id)initWithTitle:(NSString*)title image:(UIImage*)image contents:(NSString*)contents{
    
}

-(void)initInset{
    self.textContainerInset = UIEdgeInsetsMake(self.frame.size.height+20, 0.0f, 0.0f, 0.0f);
}


-(void)setTextWithHtmlString:(NSString*)string{
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    self.attributedText = attributedString;
}


-(void)setHighlightText{
    
    //set highlighted
    
    __block BOOL textIsHighlited = YES;
    
    [self.attributedText enumerateAttributesInRange:[self selectedRange] options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        if ([attrs valueForKey:@"NSBackgroundColor"] == Nil) {
            textIsHighlited = NO;
        }
    }];
    
    if (textIsHighlited) {
        [self.textStorage removeAttribute:NSBackgroundColorAttributeName range:[self selectedRange]];
        [self.textStorage removeAttribute:NSForegroundColorAttributeName range:[self selectedRange]];
    }else{
        [self.textStorage addAttribute:NSBackgroundColorAttributeName value:UIColorFromRGB(MAIN_COLOR) range:[self selectedRange]];
        [self.textStorage addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xffffff) range:[self selectedRange]];
    }

    [self setSelectedRange:NSRangeFromString(@"")];
    return;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    return NO;
}

@end
