//
//  EMPhotoEditorViewController.h
//  EnjoyPhotoEdit
//
//  Created by 이상진 on 2014. 3. 16..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AviarySDK.framework/Headers/AFPhotoEditorController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface EMPhotoEditorViewController : UIViewController<UIActionSheetDelegate,AFPhotoEditorControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
    IBOutlet UIImageView *myImageView;
}

@end
