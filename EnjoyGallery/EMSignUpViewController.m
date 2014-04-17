//
//  EMSignUpViewController.m
//  EnjoyGallery
//
//  Created by LeeYoungNam on 4/16/14.
//  Copyright (c) 2014 EntusApps. All rights reserved.
//

#import "EMSignUpViewController.h"

@interface EMSignUpViewController ()

@end

@implementation EMSignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"aaa");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _email.delegate = self;
    _name.delegate=self;
    _pw.delegate=self;
    _pwCheck.delegate=self;
    
    //textFiled return key chnage
    _email.returnKeyType = UIReturnKeyNext;
    _name.returnKeyType = UIReturnKeyNext;
    _pw.returnKeyType = UIReturnKeyNext;
    _pwCheck.returnKeyType = UIReturnKeyNext;
    
    
    //time bar hide
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    //button, bg color & radius
    _signUpButton.backgroundColor = [UIColor colorWithRed:(178/255.0) green:(177/255.0) blue:(201/255.0) alpha:1];
    _signUpButton.layer.cornerRadius = 5.0f;
    _bg.backgroundColor = [UIColor colorWithRed:(95/255.0) green:(90/255.0) blue:(96/255.0) alpha:0.15];
    _bg.layer.cornerRadius = 5.0f;
    
    //pw set
    _pw.secureTextEntry = YES;
    _pwCheck.secureTextEntry = YES;
    
    
    //set date
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.birth setInputView:datePicker];
    //remove cursor
    self.birth.tintColor = [UIColor clearColor];
    
    //set gender
    _genderList = @[@"male", @"female"];
    UIPickerView *genderPicker = [[UIPickerView alloc]init];
    genderPicker.dataSource = self;
    genderPicker.delegate = self;
    self.gender.inputView = genderPicker;
    self.gender.tintColor = [UIColor clearColor];
}

//keyboard return change -> next & login button
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if(theTextField==_email)
        [_name becomeFirstResponder];
    else if(theTextField == _name)
        [_pw becomeFirstResponder];
    else if(theTextField == _pw)
        [_pwCheck becomeFirstResponder];
    else if(theTextField ==_pwCheck)
        [_birth becomeFirstResponder];
    
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //hides keyboard when another part of layout was touched
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}



-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.birth.inputView;
    NSDateFormatter *dateForm = [[NSDateFormatter alloc] init];
    [dateForm setDateFormat:@"yyyy-MM-dd"];
    self.birthDay.text = [dateForm stringFromDate:picker.date];
    self.birth.text = @" ";
    [self.gender resignFirstResponder];

}


//set gender
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.genderList.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.genderList[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.gender.text = self.genderList[row];
    sleep(0.5);
    [self.gender resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
