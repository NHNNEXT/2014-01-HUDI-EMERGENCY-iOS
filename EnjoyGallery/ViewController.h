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

@interface ViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>{
    
    NSMutableArray *polaroidImageArray;
}

@property (strong, nonatomic) IBOutlet UIScrollView *poraroidScrollView;
//@property (strong, nonatomic) IBOutlet UIPageControl *poraroidPageControl;
@property (strong, nonatomic) IBOutlet UIView *touchableview;
@property (strong, nonatomic) IBOutlet UIView *wrapView;

@end
