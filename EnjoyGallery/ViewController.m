//
//  ViewController.m
//  EnjoyGallery
//
//  Created by 이상진 on 3/24/14.
//  Copyright (c) 2014 EntusApps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //statusbar업데이트
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    //폴라이미지배열 초기화
    polaroidImageArray = [[NSMutableArray alloc]init];
    
    
    
    //스크롤뷰 컨텐츠사이즈 설정
    [self.poraroidScrollView setContentSize:CGSizeMake(0, 355)];
    
    //스크롤뷰 커스텀 페이징
    [self.poraroidScrollView setClipsToBounds:FALSE];
    [self.poraroidScrollView setDelegate:self];
    [self.poraroidScrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"blurBG.png"]]];
    [self.touchableview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"blurBG.png"]]];
    
//    [self.touchableview addGestureRecognizer:self.poraroidScrollView.panGestureRecognizer];
//    [self.touchableview setClipsToBounds:TRUE];
    
    

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

#pragma mark Add Image
- (void)addImage:(UIImage*)image date:(NSDate*)date{
    //스크롤뷰 컨텐츠사이즈 조절
    [self.poraroidScrollView setContentSize:CGSizeMake(self.poraroidScrollView.contentSize.width+260, 355)];
    
    
    CGRect twineViewFrame = CGRectMake(-38, -30, 320, 10);
    CGRect woodenClipViewFrame = CGRectMake(105, -55, 20, 82);
    CGRect imageViewFrame = CGRectMake(10, 10, 220, 220);
    CGRect poraViewFrame = CGRectMake(self.poraroidScrollView.contentSize.width-250,55, 240, 270);
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
    
    [self.poraroidScrollView addSubview:poraView];
    [polaroidImageArray addObject:poraView];
    
    //사진 추가되면 추가된 곳으로 이동.
    [polaroidImageArray.lastObject setHidden:NO];
    [self.poraroidScrollView setContentOffset:CGPointMake(self.poraroidScrollView.contentSize.width-260, 0) animated:TRUE];
    
}


#pragma mark IBAction
- (IBAction)BtnPressedz:(id)sender
{
    UIActionSheet *actionsheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:NSLocalizedStringFromTable(@"CANCEL", @"Local", @"Cancle!")
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:NSLocalizedStringFromTable(@"TAKE", @"Local",@"Take a Photo"), NSLocalizedStringFromTable(@"앨범에서 사진 선택", @"Local",@"Load From Album"), nil];
    [actionsheet showInView:self.view];
}

#pragma mark UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagepickerController = [[UIImagePickerController alloc] init];
    [imagepickerController setDelegate:self];
    [imagepickerController setAllowsEditing:YES];
    if(buttonIndex == 0){
        [imagepickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imagepickerController animated:YES completion:nil];
    }
    else if(buttonIndex == 1){
        [imagepickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        [self presentViewController:imagepickerController animated:YES completion:nil];
    }
}

#pragma mark UIImagePickerContoller Delegate
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:[editingInfo objectForKey:@"UIImagePickerControllerReferenceURL"]
                   resultBlock:^(ALAsset *asset) {
                       NSDate *myDate = [asset valueForProperty:ALAssetPropertyDate];
                       
                       [self addImage:image date:myDate];
                   } failureBlock:^(NSError *error) {
                       NSLog(@"Error");
                   }];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveToImage:(id)sender{
    // capture 이미지 생성
    UIImage* captureImage = [self captureContentsInScrollView];
    if(!captureImage) return;
    // 사진 앨범에 저장
    //UIImageWriteToSavedPhotosAlbum(captureImage, nil, nil, nil);
    UIImageWriteToSavedPhotosAlbum(captureImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    
}




- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    NSString *str = NSLocalizedStringFromTable(@"완료",@"Local", @"Complete!");
    
    if (error) {
        str =NSLocalizedStringFromTable(@"에러",@"Local", @"Error!");
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    
    [alert show];
    
}


#pragma mark 스크롤뷰 전체를 앨범에 저장.
-(UIImage*)captureContentsInScrollView{
    
    // 생성된 이미지를 저장할 변수
    UIImage *capture = nil;
    
    // UIScrollView의 기존 frame을 저장
    CGRect originScrollViewFrame = self.poraroidScrollView.frame;
    
    // capture할 영역을 지정. UIScrollView의 컨텐츠 사이즈
    CGSize captureSize = CGSizeMake(self.poraroidScrollView.contentSize.width, self.poraroidScrollView.contentSize.height);
    
    // bitmap graphic context 생성
    UIGraphicsBeginImageContextWithOptions(captureSize, YES, 0.0);
    
    // UIScrollView의 frame을 content 영역으로 변경
    self.poraroidScrollView.frame = CGRectMake(0, 0, captureSize.width, captureSize.height);
    
    // UIScrollView frame영역을 bitmap image context에 그림
    [self.touchableview.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //  bitmap graphic context로부터 이미지 획득
    capture = UIGraphicsGetImageFromCurrentImageContext();
    
    // UIScrollView의 frame을 원래대로 변경 (변경하지 않으면 스크롤이 안됨)
    self.poraroidScrollView.frame = originScrollViewFrame;
    
    // bitmap image context 종료
    UIGraphicsEndImageContext();
    
    return capture;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark statusBar희색으로.
//-(UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
