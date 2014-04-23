//
//  EMSignUpViewController.m
//  EnjoyGallery
//
//  Created by LeeYoungNam on 4/16/14.
//  Copyright (c) 2014 EntusApps. All rights reserved.
//

#import "EMSignUpViewController.h"
#import "EMLoginViewController.h"

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
    self.birth.text = [dateForm stringFromDate:picker.date];
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

- (IBAction)actionSignup:(id)sender {
    NSInteger result = 0;
    @try {
        
        if([[self.email text] isEqualToString:@""] || [[self.name text] isEqualToString:@""]
           ||[self.pw.text isEqualToString:@""] ||[self.pwCheck.text isEqualToString:@""] ||[self.gender.text isEqualToString:@""] ||[self.birth.text isEqualToString:@""]) {
            [self alertStatus:@"Please enter All" :@"SignUp Failed :(" :0];
        } else {
            //send
            
            //set json
            NSDictionary *newDatasetInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                            self.email.text, @"email",
                                            self.pw.text, @"password",
                                            self.pwCheck.text, @"password-confirm",
                                            self.name.text, @"name",
                                            self.birth.text, @"birth-day",
                                            self.gender.text, @"gender",
                                            nil];
            NSError *jsonError;
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:newDatasetInfo options:kNilOptions error:&jsonError];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            NSURL *url=[NSURL URLWithString:@"http://10.73.39.78:8080/gradation/intro/signup"];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setHTTPBody:jsonData];
            
            NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            [connection start];
            
            
            //reponse
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            
            if ([response statusCode] >= 200 && [response statusCode] < 300)
            {
                NSError *error = nil;
                NSDictionary *jsonData = [NSJSONSerialization
                                          JSONObjectWithData:urlData
                                          options:NSJSONReadingMutableContainers
                                          error:&error];
                
                result = [jsonData[@"code"] integerValue];
                
                if(result == 200)
                {
                    [self alertStatus:@"Plz verify email :)" :@"Signup success" :0];
                    
                }else { //회원가입 실패  실패처리
                    NSString * error_msg = (NSString *) jsonData[@"message"];
                    [self alertStatus:error_msg :@"SignUp Failed:(" :0];
                }
            } else {//연결에러
                [self alertStatus:@"Not Connection" :@"SignUp Failed :(" :0];
            }
        }
    }
    
    //예외처리
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"SignUp Failed :(" :@"Error!" :0];
    }
}

//예외처리
- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title message:msg delegate:self cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}

- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];
}



@end
