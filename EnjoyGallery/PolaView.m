//
//  PolaGallery.m
//  EnjoyGallery
//
//  Created by 이상진 on 2014. 4. 7..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "PolaView.h"

@implementation PolaView

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

- (id)addPolaWithImage:(UIImage*)image Date:(NSDate*)date ScrollView:(UIScrollView*)scrollview
{
    
    polaImage = image;
    polaDate = date;
    polaScrollView = scrollview;
    
    //스크롤뷰 컨텐츠사이즈 조절
    [scrollview setContentSize:CGSizeMake(scrollview.contentSize.width+260, 355)];
    
    CGRect twineViewFrame = CGRectMake(-38, -30, 320, 10);
    CGRect woodenClipViewFrame = CGRectMake(105, -55, 20, 82);
    CGRect imageViewFrame = CGRectMake(10, 10, 220, 220);
    CGRect poraViewFrame = CGRectMake(scrollview.contentSize.width-250,55, 240, 270);
    CGRect dateLabelViewFrame = CGRectMake(10,235, 220, 30);
    
    UIView *poraView = [[UIView alloc]initWithFrame:poraViewFrame];
    [poraView setBackgroundColor:[UIColor whiteColor]];
    
    
    //이미지뷰 설정
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageViewFrame];
    [imageView setImage:image];
    
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
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:date
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    
    [dateLabel setText:dateString];
    [dateLabel setFont:[UIFont fontWithName:@"NanumBrush" size:25]];
    [dateLabel setTextColor:[UIColor blackColor]];
    
    //이미지 기울기
    //    [UIView beginAnimations:nil context:nil];
    //    [UIView setAnimationDuration:0.01];
    //    poraView.transform = CGAffineTransformMakeRotation(((int)arc4random_uniform(2)-1)*(M_PI/180));
    //    [UIView commitAnimations];
    
    //그림자 만들기
    //그림자 버그 발견 : 스크롤할때 스크롤뷰 사이드에도 그림자 생김.
    //        poraView.layer.shadowOffset = CGSizeMake(1, 1);
    //        poraView.layer.shadowOpacity = 1;
    //        poraView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    [poraView addSubview:twineImageView];
    [poraView addSubview:imageView];
    [poraView addSubview:woodenClipImageView];
    [poraView addSubview:dateLabel];
    
    ////메모 : 안티 얼라이어싱 하는법 = infoPlist에 Renders with edge antialisasing필드 추가 값은 YES////
    
    [scrollview addSubview:poraView];
//    [polaroidImageArray addObject:poraView];
    
    //사진 추가되면 추가된 곳으로 이동.
//    [polaroidImageArray.lastObject setHidden:NO];
    [scrollview setContentOffset:CGPointMake(scrollview.contentSize.width-260, 0) animated:TRUE];
    
    return poraView;
}

- (void)deletePola:(NSMutableArray*)array index:(int)index{
    //스크롤뷰 컨텐츠사이즈 조절
    [polaScrollView setContentSize:CGSizeMake(polaScrollView.contentSize.width+260, 355)];
    
    for (int i=index; i<[array count]; i++) {
        UIView *thisPola = [array objectAtIndex:index];
        [thisPola setFrame:CGRectMake(thisPola.frame.origin.x-260, thisPola.frame.origin.y, thisPola.frame.size.width, thisPola.frame.size.height)];
    }
}


//메모리 관리 위해 화면에서 사라진 이미지는 히든.
//메모리 관리에 도움 없음?
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    int contentOffest = (int)self.poraroidScrollView.contentOffset.x;
//    int page = contentOffest/240;
//    NSLog(@"%d",page);
//
//    if (page<=1){
//        for (int i = 1; i<polaroidImageArray.count; i++) {
////            [[polaroidImageArray objectAtIndex:i] setHidden:FALSE];
//            [self.poraroidScrollView addSubview:[polaroidImageArray objectAtIndex:i]];
//            NSLog(@"%d번 보임",i);
//        }
//    }
//    else if (page>=2){
//        for (int i = 1; i<polaroidImageArray.count; i++) {
////            [[polaroidImageArray objectAtIndex:i] setHidden:TRUE];
//            [[polaroidImageArray objectAtIndex:i] removeFromSuperview];
//            NSLog(@"%d번 안보임",i);
//        }
//        for (int i = page-1; i<=page+1; i++) {
//            if (i==polaroidImageArray.count) {
//                NSLog(@"마지막임");
//                break;
//            }
////            [[polaroidImageArray objectAtIndex:i] setHidden:FALSE];
//            [self.poraroidScrollView addSubview:[polaroidImageArray objectAtIndex:i]];
//            NSLog(@"%d번 보임",i);
//
//        }
//
//    }
////     else
////        [[polaroidImageArray objectAtIndex:0] setHidden:FALSE];
//
//}

//#pragma mark Add Image
//- (void)addImage:(UIImage*)image date:(NSDate*)date{
//    //스크롤뷰 컨텐츠사이즈 조절
//    [self.poraroidScrollView setContentSize:CGSizeMake(self.poraroidScrollView.contentSize.width+260, 355)];
//    
//    
//    CGRect twineViewFrame = CGRectMake(-38, -30, 320, 10);
//    CGRect woodenClipViewFrame = CGRectMake(105, -55, 20, 82);
//    CGRect imageViewFrame = CGRectMake(10, 10, 220, 220);
//    CGRect poraViewFrame = CGRectMake(self.poraroidScrollView.contentSize.width-250,55, 240, 270);
//    CGRect dateLabelViewFrame = CGRectMake(10,235, 220, 30);
//    
//    UIView *poraView = [[UIView alloc]initWithFrame:poraViewFrame];
//    [poraView setBackgroundColor:[UIColor whiteColor]];
//    
//    
//    //이미지뷰 설정
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageViewFrame];
//    [imageView setImage:image];
//    
//    //노끈 생성
//    UIImageView *twineImageView = [[UIImageView alloc]initWithFrame:twineViewFrame];
//    UIImage *twineImage = [UIImage imageNamed:@"twine.png"];
//    [twineImageView setImage:twineImage];
//    
//    //나무 집게 생성
//    UIImageView *woodenClipImageView = [[UIImageView alloc]initWithFrame:woodenClipViewFrame];
//    UIImage *woodenClipImage = [UIImage imageNamed:@"나무집게1.png"];
//    [woodenClipImageView setImage:woodenClipImage];
//    
//    //라벨 생성
//    UILabel *dateLabel = [[UILabel alloc]initWithFrame:dateLabelViewFrame];
//    
//    NSString *dateString = [NSDateFormatter localizedStringFromDate:date
//                                                          dateStyle:NSDateFormatterShortStyle
//                                                          timeStyle:NSDateFormatterShortStyle];
//    
//    [dateLabel setText:dateString];
//    [dateLabel setFont:[UIFont fontWithName:@"NanumBrush" size:25]];
//    [dateLabel setTextColor:[UIColor blackColor]];
//    
//    //이미지 기울기
//    //    [UIView beginAnimations:nil context:nil];
//    //    [UIView setAnimationDuration:0.01];
//    //    poraView.transform = CGAffineTransformMakeRotation(((int)arc4random_uniform(2)-1)*(M_PI/180));
//    //    [UIView commitAnimations];
//    
//    //그림자 만들기
//    //그림자 버그 발견 : 스크롤할때 스크롤뷰 사이드에도 그림자 생김.
//    //        poraView.layer.shadowOffset = CGSizeMake(1, 1);
//    //        poraView.layer.shadowOpacity = 1;
//    //        poraView.layer.shadowColor = [UIColor blackColor].CGColor;
//    
//    [poraView addSubview:twineImageView];
//    [poraView addSubview:imageView];
//    [poraView addSubview:woodenClipImageView];
//    [poraView addSubview:dateLabel];
//    
//    ////메모 : 안티 얼라이어싱 하는법 = infoPlist에 Renders with edge antialisasing필드 추가 값은 YES////
//    
//    [self.poraroidScrollView addSubview:poraView];
//    [polaroidImageArray addObject:poraView];
//    
//    //사진 추가되면 추가된 곳으로 이동.
//    [polaroidImageArray.lastObject setHidden:NO];
//    [self.poraroidScrollView setContentOffset:CGPointMake(self.poraroidScrollView.contentSize.width-260, 0) animated:TRUE];
//    
//}






@end
