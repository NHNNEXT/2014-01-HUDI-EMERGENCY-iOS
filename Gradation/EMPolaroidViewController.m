//
//  ViewController.m
//  EnjoyGallery
//
//  Created by 이상진 on 3/24/14.
//  Copyright (c) 2014 EntusApps. All rights reserved.
//

#import "EMPolaroidViewController.h"
#import "EMPolaroidGalleryView.h"
#import "SIAlertView.h"
#import "SMPageControl.h"
#import "AFNetworking.h"

#define BG_COLOR_R 233/255.0
#define BG_COLOR_G 234/255.0
#define BG_COLOR_B 237/255.0

#define BTN_COLOR_R 63/255.0
#define BTN_COLOR_G 73/255.0
#define BTN_COLOR_B 83/255.0

#define SERVER_IP @"http://10.73.45.130:8080/gradation/"

@interface EMPolaroidViewController ()

@end

@implementation EMPolaroidViewController

#pragma mark -
#pragma mark viewDidLoand And StatusBar Setting

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [AFPhotoEditorController setAPIKey:@"940beb6071f8633a" secret:@"8dac56305d06e2e1"];
    
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
    [self.polaroidScrollView setContentSize:CGSizeMake(0, 355)];
    
    //스크롤뷰 커스텀 페이징
    [self.polaroidScrollView setClipsToBounds:FALSE];
    [self.polaroidScrollView setDelegate:self];
    
//    [self.polaroidScrollView setBackgroundColor:[UIColor colorWithRed:BG_COLOR_R green:BG_COLOR_G blue:BG_COLOR_B alpha:1]];
//    [self.touchableview setBackgroundColor:[UIColor colorWithRed:BG_COLOR_R green:BG_COLOR_G blue:BG_COLOR_B alpha:1]];
//    [self.wrapView setBackgroundColor:[UIColor colorWithRed:BG_COLOR_R green:BG_COLOR_G blue:BG_COLOR_B alpha:1]];
    
//    [self.polaroidScrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"blurBG.png"]]];
//    [self.touchableview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"blurBG.png"]]];
//    [self.wrapView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ricepaper-1.png"]]];
    
    [self.polaroidScrollView setBackgroundColor:[UIColor colorWithRed:BG_COLOR_R green:BG_COLOR_G blue:BG_COLOR_B alpha:1.0]];
//    [self.touchableview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"blurBG.png"]]];
    
//    [self.touchableview addGestureRecognizer:self.polaroidScrollView.panGestureRecognizer];
//    [self.touchableview setClipsToBounds:TRUE];
    
    [self showTutorial];
    
}

#pragma mark tutorial
- (void)showTutorial{
    EAIntroPage *page1 = [EAIntroPage page];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro1"]];
    page1.title = @"Tutorial";
    page1.titleColor = [UIColor blackColor];
    page1.desc = @"처음실행하면 버튼만 딸랑있고, 아무 사진도 없습니다.";
    page1.descColor = [UIColor blackColor];
    page1.bgImage = [UIImage imageNamed:@"introBg.png"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro2"]];
    page2.title = @"사진 추가";
    page2.titleColor = [UIColor blackColor];
    page2.desc = @"Add 버튼을 누르면 사진을 찍거나 앨범에서\n 사진을 선택할 수 있습니다.";
    page2.descColor = [UIColor blackColor];
    page2.bgImage = [UIImage imageNamed:@"introBg.png"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro3"]];
    page3.title = @"사진 편집";
    page3.titleColor = [UIColor blackColor];
    page3.desc = @"사진 선택을 완료하면 사진을 편집 할 수 있습니다.\n 효과, 스티커, 텍스트 삽입 등의 기능이 있습니다.";
    page3.descColor = [UIColor blackColor];
    page3.bgImage = [UIImage imageNamed:@"introBg.png"];
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro6"]];
    page4.title = @"사진 확인";
    page4.titleColor = [UIColor blackColor];
    page4.desc = @"사진 편집을 완료한 후, 완료 버튼을 터치 하면\n사진 찍은 날짜와 함께 갤러리에 사진이 추가됩니다.";
    page4.descColor = [UIColor blackColor];
    page4.bgImage = [UIImage imageNamed:@"introBg.png"];
    
    EAIntroPage *page5 = [EAIntroPage page];
    page5.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro7"]];
    page5.titleIconPositionY = 200;
    page5.title = @"사진 저장";
    page5.titleColor = [UIColor blackColor];
    page5.desc = @"같은 방법으로 사진을 여러장 추가 하고\n Save 버튼을 터치하면, 앨범에 아름다운 갤러리가 저장됩니다.";
    page5.descColor = [UIColor blackColor];
    page5.bgImage = [UIImage imageNamed:@"introBg.png"];
    
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4,page5]];
    UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [skipButton setTitle:@"Skip" forState:UIControlStateNormal];
    [skipButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [skipButton setFrame:CGRectMake((320-100), [UIScreen mainScreen].bounds.size.height - 60, 100, 40)];
    intro.skipButton = skipButton;
    
    [intro.pageControl removeFromSuperview];
    
    SMPageControl *myPageControl = [[SMPageControl alloc] init];
    myPageControl.pageIndicatorImage = [UIImage imageNamed:@"pageDot"];
    myPageControl.currentPageIndicatorImage = [UIImage imageNamed:@"selectedPageDot"];
    [myPageControl sizeToFit];
    //    [self.view addSubview:pageControl];
    intro.pageControl = (UIPageControl *)myPageControl;
    [intro addSubview:intro.pageControl];
    intro.pageControlY = 80.0f;
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Add PolaroidView
- (void)addImage:(UIImage*)image date:(NSDate*)date{
    PolaroidView *pola = [PolaroidView new];
    pola = [pola addPolaWithImage:image Date:date ScrollView:self.polaroidScrollView];
    [polaroidImageArray addObject:pola];
}

- (IBAction)deleteCurPola:(id)sender{
    
    //사진 없으면 에러창 띄움
    if (![polaroidImageArray count]) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Error!"  andMessage:NSLocalizedStringFromTable(@"NO PHOTO", @"Local", @"사진 없다")];
        
        [alertView addButtonWithTitle:NSLocalizedStringFromTable(@"OK", @"Local", @"확인")
                                 type:SIAlertViewButtonTypeCancel
                              handler:^(SIAlertView *alert) {
                                  NSLog(@"확인 클릭!");
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleFade;
        [alertView show];
        
        return;
    }
    

    
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                     andMessage:NSLocalizedStringFromTable(@"REMOVE THIS PHOTO?", @"Local", @"이 사진을 삭제 하겠습니까?")];
    
    [alertView addButtonWithTitle:NSLocalizedStringFromTable(@"Cancle", @"Local", @"취소")
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alert) {
                              NSLog(@"취소 클릭!");
                          }];
    
    [alertView addButtonWithTitle:NSLocalizedStringFromTable(@"OK", @"Local", @"확인")
                             type:SIAlertViewButtonTypeDestructive
                          handler:^(SIAlertView *alert) {
                              NSLog(@"확인 클릭!");
                              [self deletePolaroidView:currentPage];
                          }];
    
    alertView.transitionStyle = SIAlertViewTransitionStyleFade;
    [alertView show];
    
    
}


#pragma mark Delete PolaroidView
- (void)deletePolaroidView:(NSUInteger)index{
    
    
    PolaroidView *curPagePola = [polaroidImageArray objectAtIndex:index];
//    NSUInteger index = [polaroidImageArray indexOfObject:sender];
    
    //스크롤뷰 컨텐츠사이즈 조절
    [self.polaroidScrollView setContentSize:CGSizeMake(self.polaroidScrollView.contentSize.width-260, 355)];
    
    for (NSUInteger i=index; i<[polaroidImageArray count]; i++) {
        UIView *thisPola = [polaroidImageArray objectAtIndex:i];
        [thisPola setFrame:CGRectMake(thisPola.frame.origin.x-260, thisPola.frame.origin.y, thisPola.frame.size.width, thisPola.frame.size.height)];
    }
    
//    [self.polaroidScrollView setContentOffset:CGPointMake(0, 0) animated:TRUE];
    
    
    [polaroidImageArray removeObject:curPagePola];
    
    [curPagePola removeFromSuperview];
    curPagePola = nil;
    
    
    NSLog(@"어레이 카운트 : %d", (int)[polaroidImageArray count]);
    NSLog(@"컨텐츠 사이즈 : %f", self.polaroidScrollView.contentSize.width);
}



- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.polaroidScrollView.frame.size.width;
    currentPage = floor((self.polaroidScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    NSLog(@"%d",(int)currentPage);
}


#pragma mark IBAction
- (IBAction)BtnPressedz:(id)sender
{
    UIActionSheet *actionsheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:NSLocalizedStringFromTable(@"Cancle", @"Local", @"Cancle!")
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:NSLocalizedStringFromTable(@"TAKE", @"Local",@"Take a Photo"), NSLocalizedStringFromTable(@"앨범에서 사진 선택", @"Local",@"Load From Album"), nil];
    [actionsheet showInView:self.view];
    
    
}

#pragma mark UIActionSheet Delegate
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet{
    for (UIView *subview in actionSheet.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subview;
            [button setTitleColor:[UIColor colorWithRed:BTN_COLOR_R green:BTN_COLOR_G blue:BTN_COLOR_B alpha:1.0] forState:UIControlStateNormal];
        }
    }
}

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
    assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:[editingInfo objectForKey:@"UIImagePickerControllerReferenceURL"]
                   resultBlock:^(ALAsset *asset) {
                       myDate = [asset valueForProperty:ALAssetPropertyDate];
                       //지금 찍어서 데이트가 없으면 현재 시간을 입력.
                       if (!myDate) {
                           myDate = [[NSDate alloc]init];
                       }                       
                       
                   } failureBlock:^(NSError *error) {
                       NSLog(@"Error");
                   }];
    [picker dismissViewControllerAnimated:YES completion:^{[self displayEditorForImage:image];}];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark 사진 저장
- (IBAction)saveToImage:(id)sender{
    //사진 없으면 에러 메시지 
    if (![polaroidImageArray count]) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Error!"  andMessage:NSLocalizedStringFromTable(@"NO PHOTO", @"Local", @"사진 없다")];
        
        [alertView addButtonWithTitle:NSLocalizedStringFromTable(@"OK", @"Local", @"확인")
                                 type:SIAlertViewButtonTypeCancel
                              handler:^(SIAlertView *alert) {
                                  NSLog(@"확인 클릭!");
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleFade;
        [alertView show];
        return;
    }
    
    // capture 이미지 생성
    UIImage* captureImage = [self captureContentsInScrollView];
    if(!captureImage) return;
    // 사진 앨범에 저장
    //UIImageWriteToSavedPhotosAlbum(captureImage, nil, nil, nil);
    UIImageWriteToSavedPhotosAlbum(captureImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}



#pragma mark 사진 저장 후 처리
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    NSString *str = NSLocalizedStringFromTable(@"완료",@"Local", @"Complete!");
    
    if (error) {
        str =NSLocalizedStringFromTable(@"에러",@"Local", @"Error!");
    }
    
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:str  andMessage:nil];
    
    [alertView addButtonWithTitle:NSLocalizedStringFromTable(@"OK", @"Local", @"확인")
                             type:SIAlertViewButtonTypeDestructive
                          handler:^(SIAlertView *alert) {
                              NSLog(@"확인 클릭!");
                          }];
    alertView.transitionStyle = SIAlertViewTransitionStyleFade;
    [alertView show];
}


#pragma mark 스크롤뷰 전체를 앨범에 저장.
-(UIImage*)captureContentsInScrollView{
    
    // 생성된 이미지를 저장할 변수
    UIImage *capture = nil;
    
    // UIScrollView의 기존 frame을 저장
    CGRect originScrollViewFrame = self.polaroidScrollView.frame;
    
    // capture할 영역을 지정. UIScrollView의 컨텐츠 사이즈
    CGSize captureSize = CGSizeMake(self.polaroidScrollView.contentSize.width, self.polaroidScrollView.contentSize.height);
    
    // bitmap graphic context 생성
    UIGraphicsBeginImageContextWithOptions(captureSize, YES, 0.0);
    
    // UIScrollView의 frame을 content 영역으로 변경
    self.polaroidScrollView.frame = CGRectMake(0, 0, captureSize.width, captureSize.height);
    
    // UIScrollView frame영역을 bitmap image context에 그림
    [self.touchableview.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //  bitmap graphic context로부터 이미지 획득
    capture = UIGraphicsGetImageFromCurrentImageContext();
    
    // UIScrollView의 frame을 원래대로 변경 (변경하지 않으면 스크롤이 안됨)
    self.polaroidScrollView.frame = originScrollViewFrame;
    
    // bitmap image context 종료
    UIGraphicsEndImageContext();
    
    return capture;
}








#pragma mark -
#pragma mark PhotoEditor

//- (IBAction)displayEditorBtn:(id)sender {
//    
//    [self displayEditorForImage:myImageView.image];
//}


- (void)displayEditorForImage:(UIImage *)imageToEdit
{
    AFPhotoEditorController *editorController = [[AFPhotoEditorController alloc] initWithImage:imageToEdit];
    [editorController setDelegate:self];
    [self presentViewController:editorController animated:YES completion:nil];
}


#pragma makr 수정 완료, 취소시 동작
- (void)photoEditor:(AFPhotoEditorController *)editor finishedWithImage:(UIImage *)image
{
    // Handle the result image here and dismiss the editor.
    //    [self doSomethingWithImage:image]; // Developer-defined method that presents the final editing-resolution image to the user, perhaps.
    
    [self addImage:image date:myDate];
    [self imageUploadToServer:image :@"testImage.jpg"];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoEditorCanceled:(AFPhotoEditorController *)editor
{
    // Dismiss the editor.
    [self dismissViewControllerAnimated:YES completion:nil];
}


//
//페이스북으로 공유
//
//- (IBAction)shareToFacebook:(id)sender{
//    BOOL displayedNativeDialog = [FBNativeDialogs
//                                  presentShareDialogModallyFrom:self
//                                  initialText:@"-by EnjoyCamera"
//                                  image:myImageView.image
//                                  url:nil
//                                  handler:^(FBNativeDialogResult result, NSError *error) {
//                                      
//                                      NSString *alertText = @"";
//                                      if ([[error userInfo][FBErrorDialogReasonKey] isEqualToString:FBErrorDialogNotSupported]) {
//                                          alertText = @"iOS Share Sheet not supported.";
//                                      } else if (error) {
//                                          alertText = [NSString stringWithFormat:@"error: domain = %@, code = %d", error.domain, error.code];
//                                      } else if (result == FBNativeDialogResultSucceeded) {
//                                          alertText = @"Posted successfully.";
//                                      }
//                                      
//                                      if (![alertText isEqualToString:@""]) {
//                                          // Show the result in an alert
//                                          [[[UIAlertView alloc] initWithTitle:@"Result"
//                                                                      message:alertText
//                                                                     delegate:self
//                                                            cancelButtonTitle:@"OK!"
//                                                            otherButtonTitles:nil]
//                                           show];
//                                      }
//                                  }];
//    if (!displayedNativeDialog) {
//        /*
//         Fallback to web-based Feed dialog:
//         https://developers.facebook.com/docs/howtos/feed-dialog-using-ios-sdk/
//         */
//    }}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark 서버에 이미지 업로드
- (void)imageUploadToServer:(UIImage*)image :(NSString*)filename{
    NSData *imageData = UIImageJPEGRepresentation(image, 90);
	NSString *urlString = @"http://10.73.45.130:8080/gradation/api/v1/albums/default";
	
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"yyyy-mm-dd-HH-mm-ss"];
    [timeFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    NSString *dateString = [timeFormatter stringFromDate:myDate ];
    NSString *fileString = [NSString stringWithFormat:@"%@%@",[timeFormatter stringFromDate:myDate ],@".jpg"];
    
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        [formData appendPartWithFileData:imageData
                                    name:@"fileName"
                                fileName:fileString mimeType:@"image/jpeg"];
        
        [formData appendPartWithFormData:[dateString dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"date"];
        
        [formData appendPartWithFormData:[@"wow~ title" dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"title"];
        
        [formData appendPartWithFormData:[@"contents is ....." dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"contents"];
        
        [formData appendPartWithFormData:[@"1" dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"albumId"];
        
        
        [formData appendPartWithFormData:[@"1" dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"userId"];
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

#pragma mark 사진 서버에서 불러오기.
- (IBAction)imageLoadFromServer:(id)sender{
    NSString *URLString = @"http://10.73.45.130:8080/gradation/api/v1/albums";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager.requestSerializer setValue:@"Content-Type" forHTTPHeaderField:@"application/json"];

    [manager GET:URLString
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"%@",responseObject);
             for (int i=0; i<[[responseObject objectForKey:@"data"] count]; i++) {
                 NSDate *date = (NSDate*)[[[responseObject objectForKey:@"data"] objectForKey:[NSString stringWithFormat:@"%d",i]]objectForKey:@"date"];
                 
                 
                 NSURL *imageURLs = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IP,[[[responseObject objectForKey:@"data"] objectForKey:[NSString stringWithFormat:@"%d",i]]objectForKey:@"photoURL"]]];
                 
                 NSLog(@"%@",imageURLs);
                 
                 
                 NSURL *imageURL = [NSURL URLWithString:@"http://cdn.theatlantic.com/static/infocus/ngpc112812/s_n01_nursingm.jpg"];
                 
                 [self addImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]] date:date];
             }
    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
