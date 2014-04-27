//
//  PolaGallery.m
//  EnjoyGallery
//
//  Created by 이상진 on 2014. 4. 7..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "EMPolaroidGalleryView.h"

@implementation PolaroidView

@synthesize polaDate;
@synthesize polaImage;
@synthesize polaScrollView;


//- (id) initWithImage: (UIImage*)image date:(NSDate*)date scrollview:(UIScrollView*)scrollView
//{
//    self = [super init];
//    if (self) {
//        [self setPolaImage:image];
//        [self setPolaDate:date];
//        [self setPolaImage:image];
//    }
//    
//    return self;
//}
//
//- (id)init
//{
//    return [self initWithImage:nil date:nil scrollview:nil];
//}


- (id)addPolaWithImage:(UIImage*)image Date:(NSDate*)date ScrollView:(UIScrollView*)scrollview
{
    [self setPolaImage:image];
    [self setPolaDate:date];
    [self setPolaScrollView:scrollview];
    
    //스크롤뷰 컨텐츠사이즈 조절
    [polaScrollView setContentSize:CGSizeMake(polaScrollView.contentSize.width+260, 355)];
    
    CGRect pageViewFrame = CGRectMake(polaScrollView.contentSize.width-250, 0, 240, 335);
    
    CGRect twineViewFrame = CGRectMake(-40, 20, 320, 10);
    CGRect woodenClipViewFrame = CGRectMake(105, 0, 20, 82);
    CGRect imageViewFrame = CGRectMake(5, 5, 230, 230);
    CGRect polaroidViewFrame = CGRectMake(0,55, 240, 240);
    CGRect dateLabelViewFrame = CGRectMake(5,215, 230, 20);
    
    UIView *pageView = [[UIView alloc]initWithFrame:pageViewFrame];
    
    
    
    UIView *polaroidView = [[UIView alloc]initWithFrame:polaroidViewFrame];
    [polaroidView setBackgroundColor:[UIColor whiteColor]];
//    [polaroidView.layer setBorderWidth:1.0f];
//    [polaroidView.layer setBorderColor:[UIColor blackColor].CGColor];
    
    
    //이미지뷰 설정
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageViewFrame];
    [imageView setImage:polaImage];
    
    //노끈 생성
    UIImageView *twineImageView = [[UIImageView alloc]initWithFrame:twineViewFrame];
    UIImage *twineImage = [UIImage imageNamed:@"twine.png"];
    [twineImageView setImage:twineImage];
    
    //나무 집게 생성
    UIImageView *woodenClipImageView = [[UIImageView alloc]initWithFrame:woodenClipViewFrame];
    UIImage *woodenClipImage = [UIImage imageNamed:@"나무집게1.png"];
    [woodenClipImageView setImage:woodenClipImage];
    
    //라벨 생성
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:dateLabelViewFrame];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:polaDate
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    
    [dateLabel setText:dateString];
    [dateLabel setFont:[UIFont fontWithName:@"NanumPen" size:20]];
    [dateLabel setTextColor:[UIColor blackColor]];
    [dateLabel setBackgroundColor:[UIColor whiteColor]];
    [dateLabel setTextAlignment:NSTextAlignmentRight];
    [dateLabel setAlpha:0.65f];
//    [dateLabel setTextColor:[UIColor blackColor]];
    
    //이미지 기울기
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.01];
//    PolaroidView.transform = CGAffineTransformMakeRotation(((int)arc4random_uniform(4)-2)*(M_PI/180));
//    woodenClipImageView.transform = CGAffineTransformMakeRotation(((int)arc4random_uniform(6)-3)*(M_PI/180));
//    [UIView commitAnimations];
    
    //그림자 만들기
    //그림자 버그 발견 : 스크롤할때 스크롤뷰 사이드에도 그림자 생김. 해결.
//    PolaroidView.layer.shadowOffset = CGSizeMake(1, 1);
//    PolaroidView.layer.shadowOpacity = 1;
//    PolaroidView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    [polaroidView addSubview:imageView];
    [polaroidView addSubview:dateLabel];
    
    [pageView addSubview:polaroidView];
    [pageView addSubview:twineImageView];
    [pageView addSubview:woodenClipImageView];
    ////메모 : 안티 얼라이어싱 하는법 = infoPlist에 Renders with edge antialisasing필드 추가 값은 YES////
    
    [scrollview addSubview:pageView];
//    [polaroidImageArray addObject:PolaroidView];
    
    //사진 추가되면 추가된 곳으로 이동.
//    [polaroidImageArray.lastObject setHidden:NO];
    [scrollview setContentOffset:CGPointMake(scrollview.contentSize.width-260, 0) animated:TRUE];
    
    return pageView;
}

- (void)deletePola:(NSMutableArray*)array index:(int)index{
    //스크롤뷰 컨텐츠사이즈 조절
    [polaScrollView setContentSize:CGSizeMake(polaScrollView.contentSize.width+260, 355)];
    
    for (int i=index; i<[array count]; i++) {
        UIView *thisPola = [array objectAtIndex:index];
        [thisPola setFrame:CGRectMake(thisPola.frame.origin.x-260, thisPola.frame.origin.y, thisPola.frame.size.width, thisPola.frame.size.height)];
    }
}

@end
