//
//  ViewController.h
//  EnjoyGallery
//
//  Created by 이상진 on 3/24/14.
//  Copyright (c) 2014 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>
#import <QuartzCore/QuartzCore.h>
#import "AviarySDK.framework/Headers/AFPhotoEditorController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "EAIntroView.h"

@interface EMPolaroidViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UIAlertViewDelegate,AFPhotoEditorControllerDelegate,UINavigationControllerDelegate,EAIntroDelegate>{
    ALAssetsLibrary* assetslibrary;
    NSUInteger currentPage;
    NSMutableArray *polaroidImageArray;
    NSDate *myDate;
    NSString *fileNameString;
}

@property (strong, nonatomic) IBOutlet UIScrollView *polaroidScrollView;
//@property (strong, nonatomic) IBOutlet UIPageControl *polaroidPageControl;
@property (strong, nonatomic) IBOutlet UIView *touchableview;
@property (strong, nonatomic) IBOutlet UIView *wrapView;

@end
