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
        
        
        [self setFont:[UIFont systemFontOfSize:20]];
        
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
        [titleLabel setFont:[UIFont boldSystemFontOfSize:34]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setNumberOfLines:0];
        [titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [titleLabel sizeToFit];
        
        
        [titleLabel setFrame:CGRectMake(10, (CGRectGetHeight(frame)-CGRectGetHeight(titleLabel.frame)-10), 300, CGRectGetHeight(titleLabel.frame))];
//        [titleLabel setBackgroundColor:UIColorFromRGB(0x444444)];
        //        [titleLabel setMinimumScaleFactor:2.0];
        //        titleLabel.adjustsFontSizeToFitWidth = YES;
        
        titleLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)];
        [titleLabel addGestureRecognizer:tapGesture];
        
        
        
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

        
    }
    return self;
    
    
}

- (UIImage *)applyBlurOnImage: (UIImage *)imageToBlur withRadius: (CGFloat)blurRadius {
    CIImage *originalImage = [CIImage imageWithCGImage: imageToBlur.CGImage];
    CIFilter *filter = [CIFilter filterWithName: @"CIGaussianBlur"
                                  keysAndValues: kCIInputImageKey, originalImage, @"inputRadius", @(blurRadius), nil];
    CIImage *outputImage = filter.outputImage; CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef outImage = [context createCGImage: outputImage fromRect: [outputImage extent]];
    
    return [UIImage imageWithCGImage: outImage];
}





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
    string = [NSString stringWithFormat:@"%@%f%@%@",@"<img src=http://gradation.me/blank.png width=310 height=",CGRectGetHeight(self.frame)+10,@">",string];
    
    NSLog(@"%@",string);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    self.attributedText = attributedString;
}

#pragma mark 텍스트 하이라이트 설정 함수.
-(void)setHighlightText{
    
    
    __block BOOL textIsHighlited = YES;
    
    [self.attributedText enumerateAttributesInRange:[self selectedRange] options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        
        NSLog(@"왜? %@",@(range.location));
        
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



@end