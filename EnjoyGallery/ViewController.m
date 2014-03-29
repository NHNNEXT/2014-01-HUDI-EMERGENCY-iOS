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
    
    
    //앨범에서 asset다 가져오는 함수 호출
    //[self loadFromAlbum];
    
    
    //스크롤뷰 컨텐츠사이즈 설정
    [self.poraroidScrollView setContentSize:CGSizeMake(0, 300)];
    
    //스크롤뷰 커스텀 페이징
    [self.poraroidScrollView setClipsToBounds:FALSE];
    [self.poraroidScrollView setDelegate:self];
//    [self.touchableview addGestureRecognizer:self.poraroidScrollView.panGestureRecognizer];//없어도 됨 1
//    [self.touchableview setClipsToBounds:TRUE];//없어도 됨 2
    
    
    //컨텐츠 설정
    /*
    for (int i = 0; i < 10; i++) {
        CGRect imageViewFrame = CGRectMake(10, 10, 190, 253);
        CGRect poraViewFrame = CGRectMake(240*i+10, 0, 210, 300);
        CGRect woodenClipViewFrame = CGRectMake(105, -55, 20, 82);
        
        UIView *poraView = [[UIView alloc]initWithFrame:poraViewFrame];
        [poraView setBackgroundColor:[UIColor whiteColor]];
        
        
        //이미지뷰 설정
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageViewFrame];
        UIImage *carImage = [UIImage imageNamed:[NSString stringWithFormat:@"car%d.jpg",(i+1)]];
        [imageView setImage:carImage];
        
        //나무 집게 생성
        UIImageView *woodenClipImageView = [[UIImageView alloc]initWithFrame:woodenClipViewFrame];
        UIImage *woodenClipImage = [UIImage imageNamed:@"나무집게1.png"];
        [woodenClipImageView setImage:woodenClipImage];
        
        
        //이미지 기울기
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.01];
        
        poraView.transform = CGAffineTransformMakeRotation(((int)arc4random_uniform(2)-1)*(M_PI/180));
        [UIView commitAnimations];
        
        //그림자 만들기
        //그림자 버그 발견 : 스크롤할때 스크롤뷰 사이드에도 그림자 생김.
//        poraView.layer.shadowOffset = CGSizeMake(1, 1);
//        poraView.layer.shadowOpacity = 1;
//        poraView.layer.shadowColor = [UIColor blackColor].CGColor;
        
        [poraView addSubview:imageView];
        [poraView addSubview:woodenClipImageView];
        
        ////팁 : 안티 얼라이어싱 하는법 = infoPlist에 Renders with edge antialisasing필드 추가 값은 YES////
        
        [self.poraroidScrollView addSubview:poraView];
    }
    */
}


//메모리 관리 위해 화면에서 사라진 이미지는 히든.
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int contentOffest = (int)self.poraroidScrollView.contentOffset.x;
    int page = contentOffest/240;
    NSLog(@"%d",page);
    
    if (page<=1){
        for (int i = 1; i<polaroidImageArray.count; i++) {
            [[polaroidImageArray objectAtIndex:i] setHidden:FALSE];
            NSLog(@"%d번 보임",i);
        }
    }
    else if (page>=2){
        for (int i = 1; i<polaroidImageArray.count; i++) {
            [[polaroidImageArray objectAtIndex:i] setHidden:TRUE];
            NSLog(@"%d번 안보임",i);
        }
        for (int i = page-1; i<=page+1; i++) {
            if (i==polaroidImageArray.count) {
                NSLog(@"마지막임");
                break;
            }
            [[polaroidImageArray objectAtIndex:i] setHidden:FALSE];
            NSLog(@"%d번 보임",i);
            
        }
        
    }
//     else
//        [[polaroidImageArray objectAtIndex:0] setHidden:FALSE];
    
}

#pragma mark Add Image
- (void)addImage:(UIImage*)image{
    //스크롤뷰 컨텐츠사이즈 조절
    [self.poraroidScrollView setContentSize:CGSizeMake(self.poraroidScrollView.contentSize.width+240, 300)];
    
    
    CGRect imageViewFrame = CGRectMake(10, 10, 190, 253);
    CGRect poraViewFrame = CGRectMake(self.poraroidScrollView.contentSize.width-230, 0, 210, 300);
    CGRect woodenClipViewFrame = CGRectMake(105, -55, 20, 82);
    
    UIView *poraView = [[UIView alloc]initWithFrame:poraViewFrame];
    [poraView setBackgroundColor:[UIColor whiteColor]];
    
    
    //이미지뷰 설정
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageViewFrame];
    [imageView setImage:image];
    
    //나무 집게 생성
    UIImageView *woodenClipImageView = [[UIImageView alloc]initWithFrame:woodenClipViewFrame];
    UIImage *woodenClipImage = [UIImage imageNamed:@"나무집게1.png"];
    [woodenClipImageView setImage:woodenClipImage];
    
    
    //이미지 기울기
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.01];
    
    poraView.transform = CGAffineTransformMakeRotation(((int)arc4random_uniform(2)-1)*(M_PI/180));
    [UIView commitAnimations];
    
    //그림자 만들기
    //그림자 버그 발견 : 스크롤할때 스크롤뷰 사이드에도 그림자 생김.
    //        poraView.layer.shadowOffset = CGSizeMake(1, 1);
    //        poraView.layer.shadowOpacity = 1;
    //        poraView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    [poraView addSubview:imageView];
    [poraView addSubview:woodenClipImageView];
    
    ////팁 : 안티 얼라이어싱 하는법 = infoPlist에 Renders with edge antialisasing필드 추가 값은 YES////
    
    [self.poraroidScrollView addSubview:poraView];
    [polaroidImageArray addObject:poraView];
    
    //사진 추가되면 추가된 곳으로 이동.
    [polaroidImageArray.lastObject setHidden:NO];
    [self.poraroidScrollView setContentOffset:CGPointMake(self.poraroidScrollView.contentSize.width-240, 0) animated:TRUE];
    
}


#pragma mark IBAction
- (IBAction)BtnPressedz:(id)sender
{
    UIActionSheet *actionsheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:NSLocalizedString(@"취소", @"취소취소해")
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:NSLocalizedString(@"사진 촬영", @"Take a Photo"), NSLocalizedString(@"앨범에서 사진 선택", @"Load From Album"), nil];
    [actionsheet setTintColor:[UIColor blackColor]];
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
    [self addImage:image];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}






- (void)loadFromAlbum{
    //앨범에서 사진 가져오기.
    NSMutableArray *assets = [[NSMutableArray alloc] init];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc]init];
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
                           usingBlock:^(ALAssetsGroup *group, BOOL *stop){
                               if (group != nil) {
                                   [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop){
                                       if (result != nil) {
                                           NSLog(@"가져온거 : %@\n",result);
                                           [assets addObject:result];
                                       }
                                   }];
                               }
                           }failureBlock:^(NSError *error){
                               NSLog(@"가져오기 실패: %@",[error description]);
                           }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//statusbar 흰색으로.
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
