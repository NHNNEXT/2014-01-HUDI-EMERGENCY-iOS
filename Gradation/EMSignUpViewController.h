//
//  EMSignUpViewController.h
//  EnjoyGallery
//
//  Created by LeeYoungNam on 4/16/14.
//  Copyright (c) 2014 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMSignUpViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate, UINavigationBarDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *pw;
@property (weak, nonatomic) IBOutlet UITextField *pwCheck;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *bg;
@property (weak, nonatomic) IBOutlet UITextField *birth;

@property (weak, nonatomic) IBOutlet UITextField *gender;
@property (strong, nonatomic)NSArray *genderList;
- (IBAction)actionSignup:(id)sender;
- (IBAction)backButton:(id)sender;



@end
