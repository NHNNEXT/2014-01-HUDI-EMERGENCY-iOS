//
//  EMLoginViewController.h
//  EnjoyGallery
//
//  Created by LeeYoungNam on 4/14/14.
//  Copyright (c) 2014 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMLoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *pwField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;




@end
