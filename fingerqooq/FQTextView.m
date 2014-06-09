//
//  FQTextView.m
//  fingerqooq
//
//  Created by 이상진 on 2014. 5. 14..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "FQTextView.h"
#import <CoreText/CoreText.h>
#import "ProgressHUD.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define MAIN_COLOR 0xe74c3c

#define VIEW_WIDTH self.frame.size.width
#define VIEW_HEIGHT self.frame.size.height

@implementation FQTextView

@synthesize viewControllerRef;
@synthesize articleId;
@synthesize mainScrollView;

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
//        CGRect titleImageFrame = CGRectMake(0, 0, 320, CGRectGetHeight(frame));
//        
////        UIImage *blurImage = [self applyBlurOnImage:image withRadius:2.0];
//        
//        
//        titleImageView = [[UIImageView alloc]initWithFrame:titleImageFrame];
//        
////        [titleImageView setImageToBlur:image
////                            blurRadius:kLBBlurredImageDefaultBlurRadius
////                       completionBlock:^(){
////                           NSLog(@"블러블라");
////                       }];
//        if (!image) {
//            image = [UIImage imageNamed:@"titleImage2.jpg"];
//        }
//        
//        [titleImageView setImage:image];
//        
//        
//        [self addSubview:titleImageView];
        
//        //블러뷰
//        blurView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
//        [blurView setBackgroundColor:[UIColor blackColor]];
//        [blurView setAlpha:0.3];
//        [self addSubview:blurView];
//        

        
        //제목
//        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, -VIEW_HEIGHT, VIEW_WIDTH, VIEW_HEIGHT/2)];
//        [titleLabel setText:title];
//        [titleLabel setBackgroundColor:UIColorFromRGB(MAIN_COLOR)];
//        [titleLabel setFont:[UIFont boldSystemFontOfSize:24]];
//        [titleLabel setTextColor:[UIColor whiteColor]];
//        [titleLabel setNumberOfLines:0];
//        [titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
//        [titleLabel sizeToFit];
//        
//        
//        
//        titleLabel.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tapGestureForTitleLabel =
//        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)];
//        [titleLabel addGestureRecognizer:tapGestureForTitleLabel];
//        
//        
//        
//        [self addSubview:titleLabel];
//        
//        //흰 배경용 뷰
//        whiteBgView = [UIView new];
//        [whiteBgView setFrame:CGRectMake(0, CGRectGetHeight(frame), VIEW_WIDTH, CGRectGetHeight(titleImageView.frame))];
//        [whiteBgView setBackgroundColor:[UIColor whiteColor]];
//        [self addSubview:whiteBgView];
//        
//        //순서 설정.
//        [self sendSubviewToBack:whiteBgView];
//        [self sendSubviewToBack:blurView];
//        [self sendSubviewToBack:titleImageView];
        
        //메뉴뷰
        menuView = [[UIView alloc]initWithFrame:CGRectMake(0, -51, VIEW_WIDTH, 44)];
        menuView.backgroundColor = [UIColor whiteColor];
        
        isShowMenu = false;
        
        [self addSubview:menuView];
        
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0.0f, menuView.frame.size.height, menuView.frame.size.width, 1.0f);
        bottomBorder.backgroundColor = UIColorFromRGB(MAIN_COLOR).CGColor;
        [menuView.layer addSublayer:bottomBorder];
        
        UIButton *btnToTop = [[UIButton alloc]initWithFrame:CGRectMake(40, 0, VIEW_WIDTH/2-20, 44)];
        [btnToTop setTitle:@"Go To Top" forState:UIControlStateNormal];
        [btnToTop setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnToTop addTarget:self action:@selector(goToTop) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btnQooq = [[UIButton alloc]initWithFrame:CGRectMake(VIEW_WIDTH/2+20, 0, VIEW_WIDTH/2-20, 44)];
        [btnQooq setTitle:@"QooQ!" forState:UIControlStateNormal];
        [btnQooq setTitleColor:UIColorFromRGB(MAIN_COLOR) forState:UIControlStateNormal];
        [btnQooq addTarget:self action:@selector(qooq) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btnBack = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 44)];
        [btnBack setTitle:@"<" forState:UIControlStateNormal];
        [btnBack setTitleColor:UIColorFromRGB(MAIN_COLOR) forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        
        [menuView addSubview:btnQooq];
        [menuView addSubview:btnToTop];
        [menuView addSubview:btnBack];
        
//        menuLabel.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tapGestureForMenuView =
//        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuTap)];
//        [menuLabel addGestureRecognizer:tapGestureForMenuView];
        
        

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
    string = [NSString stringWithFormat:@"%@%@%@",@"<head><style>img{max-width:310px;height:auto;} body{line-height:24px;vertical-align:middle;display:inline-block;}</style></head><body>",string,@"</body>"];
    
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
    
    
    [menuView setFrame:CGRectMake(0, scrollOffsetY-51, VIEW_WIDTH, 44)];
    isShowMenu = false;
    
    if (scrollOffsetY<0) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
    
//    if (scrollOffsetY<=0 &&scrollOffsetY>-CGRectGetHeight(titleLabel.frame)/3) {
//        NSLog(@"%f",scrollOffsetY);
//        NSLog(@"%f",CGRectGetHeight(titleLabel.frame)/3);
//        [titleLabel setFrame:CGRectMake(0, -scrollOffsetY*2-CGRectGetHeight(titleLabel.frame), VIEW_WIDTH, CGRectGetHeight(titleLabel.frame))];
//        return;
//    }
//    
//    else if (scrollOffsetY<=-CGRectGetHeight(titleLabel.frame)/3){
//        [scrollView setContentOffset:CGPointMake(0, scrollOffsetY)];
//        return;
//    }

    
    if (scrollOffsetY+scrollView.frame.size.height>=scrollView.contentSize.height) {
        isShowMenu=false;
        [self toggleMenu];
        NSLog(@"바텀?");
        
    }
}


-(void)highlightText:(id)sender{
    [self setHighlightText];
}



#pragma mark 타이틀 라벨 터치시 본문으로 이동 함수
- (void)labelTap{
    [self setContentOffset:CGPointMake(0, CGRectGetHeight(titleImageView.frame)) animated:true];
}

- (void)goToTop{
    [self setContentOffset:CGPointMake(0, 0) animated:true];
    [menuView setFrame:CGRectMake(0, menuView.frame.origin.y-51, VIEW_WIDTH, 50)];
}

- (void)qooq{
    manager = [AFHTTPRequestOperationManager manager];
    
    
    [manager GET:@"http://10.73.39.130:8080/gradation/qooq" parameters:@{@"id":articleId} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [ProgressHUD showSuccess:@"Qooq 성공!" Interaction:YES];
        NSLog(@"석섹스!");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [ProgressHUD showError:@"에라이 에라다!"];
    }];
}
- (void)back{
    NSLog(@"bakc");
    [mainScrollView setContentOffset:CGPointMake(0, 0) animated:true];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self toggleMenu];
}

-(void)toggleMenu{
    [UIView beginAnimations:@"ToggleSiblings" context:nil];
    //    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
    [UIView setAnimationDuration:0.2];
    if (!isShowMenu) {
        [menuView setFrame:CGRectMake(0, menuView.frame.origin.y+51, VIEW_WIDTH, 44)];
        isShowMenu=true;
    }
    else{
        [menuView setFrame:CGRectMake(0, menuView.frame.origin.y-51, VIEW_WIDTH, 44)];
        isShowMenu=false;
    }
    
    [UIView commitAnimations];
}


@end