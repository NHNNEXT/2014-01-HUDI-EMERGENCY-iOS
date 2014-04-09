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

@interface EMPolaroidViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UIAlertViewDelegate>{
    ALAssetsLibrary* assetslibrary;
    NSUInteger currentPage;
    NSMutableArray *polaroidImageArray;
}

@property (strong, nonatomic) IBOutlet UIScrollView *polaroidScrollView;
//@property (strong, nonatomic) IBOutlet UIPageControl *polaroidPageControl;
@property (strong, nonatomic) IBOutlet UIView *touchableview;
@property (strong, nonatomic) IBOutlet UIView *wrapView;

@end
