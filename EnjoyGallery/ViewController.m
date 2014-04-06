//
//  ViewController.m
//  EnjoyGallery
//
//  Created by 이상진 on 3/24/14.
//  Copyright (c) 2014 EntusApps. All rights reserved.
//

#import "ViewController.h"
#import "PolaGallery.h"

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


#pragma mark Add Image
- (void)addImage:(UIImage*)image date:(NSDate*)date{
    PolaGallery *pola = [PolaGallery new];
    pola = [pola initWithImage:image Date:date ScrollView:self.poraroidScrollView];
    [polaroidImageArray addObject:pola];
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
