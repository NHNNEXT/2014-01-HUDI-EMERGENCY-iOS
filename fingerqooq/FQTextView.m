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

-(id)initWithFrame:(CGRect)frame title:(NSString*)title image:(UIImage*)image contents:(NSString*)contents{
    
    self = [super init];
    if (self) {
        self = [[FQTextView alloc]initWithFrame:frame];
        
        [self setScrollsToTop:true];
        
        self.delegate = self;
        [self initInset];
        
        [self setTextWithHtmlString:contents];
        
        
        [self setFont:[UIFont systemFontOfSize:20]];
        [self setTextColor:UIColorFromRGB(0x444444)];
        [self setEditable:false];
        
        
        
        //타이틀 이미지.
        CGRect titleImageFrame = CGRectMake(0, 0, 320, CGRectGetHeight(frame));
        
        titleImageView = [[UIImageView alloc]initWithImage:image];
        
        [titleImageView setFrame:titleImageFrame];
        
        [self addSubview:titleImageView];
        
        //블러뷰
        blurView = [[UIView alloc]initWithFrame:titleImageFrame];
        [blurView setBackgroundColor:[UIColor blackColor]];
        [blurView setAlpha:0.4];
        [self addSubview:blurView];
        
        //제목
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetHeight(frame)-150, 300, 150)];
        [titleLabel setText:title];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:34]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setNumberOfLines:0];
        [titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [titleLabel sizeToFit];
//        [titleLabel setMinimumScaleFactor:2.0];
//        titleLabel.adjustsFontSizeToFitWidth = YES;
        
        titleLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)];
        [titleLabel addGestureRecognizer:tapGesture];
        
        
        [self addSubview:titleLabel];
        
        //흰 배경용 뷰
        whiteBgView = [UIView new];
        [whiteBgView setFrame:CGRectMake(0, CGRectGetHeight(frame), 320, CGRectGetHeight(frame))];
        [whiteBgView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:whiteBgView];
        
        //순서 설정.
        [self sendSubviewToBack:whiteBgView];
        [self sendSubviewToBack:blurView];
        [self sendSubviewToBack:titleImageView];
        
        
    }
    return self;
    
    
}

-(void)initInset{
    self.textContainerInset = UIEdgeInsetsMake(self.frame.size.height+20, 0.0f, 0.0f, 0.0f);
}

-(void)initHighlightMenu{
    //하이라이트 메뉴 부분
    
    if (isHighlightMenuSet==YES) {
        return;
    }
    
    NSMutableArray *menuItems = [[[UIMenuController sharedMenuController] menuItems] mutableCopy];
    if (!menuItems) {
        menuItems = [[NSMutableArray alloc]init];
    }
    UIMenuItem *highlightMenuItem = [[UIMenuItem alloc]initWithTitle:@"하이라이트" action:@selector(highlightText:)];
    [menuItems addObject:highlightMenuItem];
    [[UIMenuController sharedMenuController] setMenuItems:menuItems];
    
    isHighlightMenuSet = YES;
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

//기본 메뉴 삭제용.
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(highlightText:)) {
        return YES;
    }
    
    return NO;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSString *selectedString = [self textInRange:[self selectedTextRange]];
    
    //선택된 텍스트가 있으면
//    if (![selectedString isEqualToString:@""]) {
//        NSLog(@"select 된거 : %@",selectedString);
//        return;
//    }
    
    
//    NSLog(@"선택된 텍스트 없음");
    
    double scrollOffsetY = scrollView.contentOffset.y;
    if (scrollOffsetY<=0) {
        [titleImageView setFrame:CGRectMake(0, scrollOffsetY, CGRectGetWidth(titleImageView.frame), CGRectGetHeight(titleImageView.frame))];
        [blurView setFrame:CGRectMake(0, scrollOffsetY, CGRectGetWidth(titleImageView.frame), CGRectGetHeight(titleImageView.frame))];
        [titleLabel setFrame:CGRectMake(10, (CGRectGetHeight(titleImageView.frame)-150)-(scrollOffsetY*0.8), CGRectGetWidth(titleLabel.frame), CGRectGetHeight(titleLabel.frame))];
        return;
    }
    //
    //
    [titleImageView setFrame:CGRectMake(0, (scrollOffsetY*0.3), CGRectGetWidth(titleImageView.frame), CGRectGetHeight(titleImageView.frame))];
    [blurView setFrame:CGRectMake(0, (scrollOffsetY*0.3), CGRectGetWidth(titleImageView.frame), CGRectGetHeight(titleImageView.frame))];
    //    [testTitle setFrame:CGRectMake(10, (self.view.frame.size.height-150)-(scrollOffsetY*1), CGRectGetWidth(testTitle.frame), CGRectGetHeight(testTitle.frame))];
    
    if (scrollOffsetY/CGRectGetHeight(titleImageView.frame)*1.2 >= 0.4) {
        
        [blurView setAlpha:scrollOffsetY/CGRectGetHeight(titleImageView.frame)*1.2];
    }
    //    NSLog(@"%f",scrollOffsetY);
}


-(void)highlightText:(id)sender{
    [self setHighlightText];
}


- (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated {
    NSLog(@"scrollRectToVisible");
}

- (void)labelTap{
    [self setContentOffset:CGPointMake(0, CGRectGetHeight(titleImageView.frame)) animated:true];
}


@end