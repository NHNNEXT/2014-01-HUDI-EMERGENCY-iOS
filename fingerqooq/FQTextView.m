//
//  FQTextView.m
//  fingerqooq
//
//  Created by 이상진 on 2014. 5. 14..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "FQTextView.h"
#import "UIImageView+LBBlurredImage.h"
#import <CoreText/CoreText.h>

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define MAIN_COLOR 0xe74c3c


@implementation FQTextView


-(id)initWithFrame:(CGRect)frame titleString:(NSString*)title titleImage:(UIImage*)image contentsString:(NSString*)contents{
    
    self = [super init];
    if (self) {

        
        self = [[FQTextView alloc]initWithFrame:frame];
        
        [self setScrollsToTop:true];
        
        self.delegate = self;
        
        [self setTextWithHtmlString:contents];
        
        
        [self setFont:[UIFont fontWithName:@"NanumMyeongjo" size:17]];
        
        
        [self setTextColor:UIColorFromRGB(0x444444)];
        [self setEditable:false];

        
        //타이틀 이미지.
        CGRect titleImageFrame = CGRectMake(0, 0, 320, CGRectGetHeight(frame));
        
//        UIImage *blurImage = [self applyBlurOnImage:image withRadius:2.0];
        
        
        titleImageView = [[UIImageView alloc]initWithFrame:titleImageFrame];
        
//        [titleImageView setImageToBlur:image
//                            blurRadius:kLBBlurredImageDefaultBlurRadius
//                       completionBlock:^(){
//                           NSLog(@"블러블라");
//                       }];
        if (!image) {
            image = [UIImage imageNamed:@"titleImage2.jpg"];
        }
        
        [titleImageView setImage:image];
        
        
        [self addSubview:titleImageView];
        
        //블러뷰
        blurView = [[UIView alloc]initWithFrame:titleImageFrame];
        [blurView setBackgroundColor:[UIColor blackColor]];
        [blurView setAlpha:0.3];
        [self addSubview:blurView];
        

        
        //제목
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, CGRectGetHeight(frame))];
        [titleLabel setText:title];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setNumberOfLines:0];
        [titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [titleLabel sizeToFit];
        
        
        [titleLabel setFrame:CGRectMake(10, (CGRectGetHeight(frame)-CGRectGetHeight(titleLabel.frame)-10), 300, CGRectGetHeight(titleLabel.frame))];
//        [titleLabel setBackgroundColor:UIColorFromRGB(0x444444)];
        //        [titleLabel setMinimumScaleFactor:2.0];
        //        titleLabel.adjustsFontSizeToFitWidth = YES;
        
        titleLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGestureForTitleLabel =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)];
        [titleLabel addGestureRecognizer:tapGestureForTitleLabel];
        
        
        
        [self addSubview:titleLabel];
        
        //흰 배경용 뷰
        whiteBgView = [UIView new];
        [whiteBgView setFrame:CGRectMake(0, CGRectGetHeight(frame), 320, CGRectGetHeight(titleImageView.frame))];
        [whiteBgView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:whiteBgView];
        
        //순서 설정.
        [self sendSubviewToBack:whiteBgView];
        [self sendSubviewToBack:blurView];
        [self sendSubviewToBack:titleImageView];
        
        //메뉴뷰
        menuView = [[UIView alloc]initWithFrame:CGRectMake(0, -51, 320, 50)];
        menuView.backgroundColor = [UIColor whiteColor];
        
        isShowMenu = false;
        
        [self addSubview:menuView];
        
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0.0f, menuView.frame.size.height, menuView.frame.size.width, 1.0f);
        bottomBorder.backgroundColor = UIColorFromRGB(0x888888).CGColor;
        [menuView.layer addSublayer:bottomBorder];
        
        
        
        UILabel *menuLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        [menuLabel setText:@"Go To Top"];
        [menuLabel setTextAlignment:NSTextAlignmentCenter];
        [menuLabel setFont:[UIFont systemFontOfSize:15]];
        [menuView addSubview:menuLabel];
        
        menuLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGestureForMenuView =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuTap)];
        [menuLabel addGestureRecognizer:tapGestureForMenuView];

    }
    return self;
    
    
}


#pragma mark -
#pragma mark 컨텐츠 설정 부분(set).

-(void)setTitleString:(NSString*)string{
    [titleLabel setText:string];
}

-(void)setTitleImage:(UIImage*)image{
    [titleImageView setImage:image];
}

-(void)setContents:(NSString*)string{
    
    [self setTextWithHtmlString:string];
}

-(void)setContents:(NSString*)contentString titleImage:(UIImage*)titleImage titleString:(NSString*)titleString{
    
}



#pragma mark -
#pragma mark 본문 하이라이트 메뉴 설정 함수.
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


#pragma mark 본문 텍스트 설정 함수.
-(void)setTextWithHtmlString:(NSString*)string{
    string = [NSString stringWithFormat:@"%@%f%@%@%@",@"<head><style>img{max-width:310px;height:auto;} body{line-height:24px;vertical-align:middle;display:inline-block;}</style></head><body><img src=http://gradation.me/blank.png width=310 height=",CGRectGetHeight(self.frame)+10,@">",string,@"</body>"];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    self.attributedText = attributedString;
}

#pragma mark 텍스트 하이라이트 설정 함수.
-(void)setHighlightText{
    
    
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
        [self.textStorage addAttribute:NSBackgroundColorAttributeName value:[UIColor yellowColor] range:[self selectedRange]];
        [self.textStorage addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x000000) range:[self selectedRange]];
    }

    [self setSelectedRange:NSRangeFromString(@"")];
    return;
}

#pragma mark 기본 메뉴 삭제용.
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(highlightText:)) {
        return YES;
    }
    
    return NO;
}


#pragma mark 스크롤시 처리 함수
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    
    double scrollOffsetY = scrollView.contentOffset.y;
    
    
    
    
    [menuView setFrame:CGRectMake(0, scrollOffsetY-51, 320, 50)];
    isShowMenu = false;
    
    if (scrollOffsetY<=0) {
        [titleImageView setFrame:CGRectMake(0, scrollOffsetY, CGRectGetWidth(titleImageView.frame), CGRectGetHeight(titleImageView.frame))];
        
        [blurView setFrame:CGRectMake(0, scrollOffsetY, CGRectGetWidth(titleImageView.frame), CGRectGetHeight(titleImageView.frame))];
        
        [titleLabel setFrame:CGRectMake(10, (CGRectGetHeight(titleImageView.frame)-CGRectGetHeight(titleLabel.frame)-10)-(scrollOffsetY*0.8), CGRectGetWidth(titleLabel.frame), CGRectGetHeight(titleLabel.frame))];
        return;
    }

    [titleImageView setFrame:CGRectMake(0, (scrollOffsetY*0.3), CGRectGetWidth(titleImageView.frame), CGRectGetHeight(titleImageView.frame))];
    [blurView setFrame:CGRectMake(0, (scrollOffsetY*0.3), CGRectGetWidth(titleImageView.frame), CGRectGetHeight(titleImageView.frame))];
    //    [testTitle setFrame:CGRectMake(10, (self.view.frame.size.height-150)-(scrollOffsetY*1), CGRectGetWidth(testTitle.frame), CGRectGetHeight(testTitle.frame))];
    
    if (scrollOffsetY/CGRectGetHeight(titleImageView.frame) >= 0.3) {
        
        [blurView setAlpha:scrollOffsetY/CGRectGetHeight(titleImageView.frame)*1.2];
    }
    //    NSLog(@"%f",scrollOffsetY);
}


-(void)highlightText:(id)sender{
    [self setHighlightText];
}



#pragma mark 타이틀 라벨 터치시 본문으로 이동 함수
- (void)labelTap{
    [self setContentOffset:CGPointMake(0, CGRectGetHeight(titleImageView.frame)) animated:true];
}

- (void)menuTap{
    [self setContentOffset:CGPointMake(0, 0) animated:true];
    [menuView setFrame:CGRectMake(0, menuView.frame.origin.y-51, 320, 50)];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (menuView.frame.origin.y<-50) {
        return;
    }
    [self toggleMenu];
    
}

-(void)toggleMenu{
    [UIView beginAnimations:@"ToggleSiblings" context:nil];
    //    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
    [UIView setAnimationDuration:0.2];
    if (!isShowMenu) {
        [menuView setFrame:CGRectMake(0, menuView.frame.origin.y+51, 320, 50)];
        isShowMenu=true;
    }
    else{
        [menuView setFrame:CGRectMake(0, menuView.frame.origin.y-51, 320, 50)];
        isShowMenu=false;
    }
    
    [UIView commitAnimations];
}


@end