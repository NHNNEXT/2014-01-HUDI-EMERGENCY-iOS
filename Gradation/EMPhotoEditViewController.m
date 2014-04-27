//
//  EMPhotoEditorViewController.m
//  EnjoyPhotoEdit
//
//  Created by 이상진 on 2014. 3. 16..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "EMPhotoEditorViewController.h"
@interface EMPhotoEditorViewController ()

@end

@implementation EMPhotoEditorViewController

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
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark IBAction
- (IBAction)BtnPressedz:(id)sender
{
    UIActionSheet *actionsheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:NSLocalizedStringFromTable(@"취소", @"Local", @"Cancle")
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:NSLocalizedStringFromTable(@"사진 촬영", @"Local", @"Take a Photo!"), NSLocalizedStringFromTable(@"앨범에서 사진 선택", @"Local", @"Load From Album"), nil];
    [actionsheet showInView:self.view];
}

#pragma mark UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagepickerController = [[UIImagePickerController alloc] init];
    [imagepickerController setDelegate:self];
    [imagepickerController setAllowsEditing:NO];
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
    myImageView.image = image;
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)displayEditorBtn:(id)sender {
    
    [self displayEditorForImage:myImageView.image];
}

//
//포토 에디터 시작
//
- (void)displayEditorForImage:(UIImage *)imageToEdit
{
    AFPhotoEditorController *editorController = [[AFPhotoEditorController alloc] initWithImage:imageToEdit];
    [editorController setDelegate:self];
    [self presentViewController:editorController animated:YES completion:nil];
}


//사진을 앨범에 저장.
- (IBAction)saveToPhotoAlbum:(id)sender{
    UIImageWriteToSavedPhotosAlbum(myImageView.image, self, nil, nil);
    UIAlertView *alertView = [[UIAlertView alloc]
                         initWithTitle:nil
                         message:NSLocalizedString(@"완료", @"complete save to album")
                         delegate:nil
                         cancelButtonTitle:nil
                         otherButtonTitles:@"OK", nil];
    
    [alertView show];
}


//
//수정 완료, 취소시 동작
//
- (void)photoEditor:(AFPhotoEditorController *)editor finishedWithImage:(UIImage *)image
{
    // Handle the result image here and dismiss the editor.
//    [self doSomethingWithImage:image]; // Developer-defined method that presents the final editing-resolution image to the user, perhaps.
    [myImageView setImage:image];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoEditorCanceled:(AFPhotoEditorController *)editor
{
    // Dismiss the editor.
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
