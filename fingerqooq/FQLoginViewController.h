//
//  FQLoginViewController.h
//  fingerqooq
//
//  Created by 이상진 on 2014. 5. 29..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "AFNetworking.h"
#import "FQViewController.h"

@interface FQLoginViewController : UIViewController<UITextFieldDelegate,FBLoginViewDelegate>{
    FBProfilePictureView *profilePictureView;
    AFHTTPRequestOperationManager *manager;
    id FBID;
}
@property (weak, nonatomic) IBOutlet UITextField *pwField;
@property (weak, nonatomic) IBOutlet UITextField *idField;

@end
