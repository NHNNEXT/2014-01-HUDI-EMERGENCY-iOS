//
//  EMLoginViewController.m
//  EnjoyGallery
//
//  Created by LeeYoungNam on 4/14/14.
//  Copyright (c) 2014 EntusApps. All rights reserved.
//

#import "EMLoginViewController.h"
#import "EMSignUpViewController.h"
#import "EMPolaroidViewController.h"

@interface EMLoginViewController ()
@end

@implementation EMLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    _emailField.delegate = self;
    _pwField.delegate=self;
    
    
    //time bar hide
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    //placehoder color chage
    UIColor * gray =[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1];
    _emailField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Your Email" attributes:@{NSForegroundColorAttributeName: gray}];
    _pwField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: gray}];
    
    //button color & radius
    _loginButton.backgroundColor = [UIColor colorWithRed:(231/255.0) green:(76/255.0) blue:(60/255.0) alpha:1];
    _loginButton.layer.cornerRadius = 5.0f;
    
    //pwSet
    _pwField.secureTextEntry = YES;

    
    // Move the image
    [self moveImage:_bgImage duration:15.0 curve:UIViewAnimationCurveLinear x:100.0 y:30.0];
    
    //textFiled return key chnage
    _emailField.returnKeyType = UIReturnKeyNext;
    _pwField.returnKeyType = UIReturnKeyGo;
    
}

//keyboard return change -> next & login button
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if(theTextField==_emailField){
        [_pwField becomeFirstResponder];
    }else{
        [theTextField resignFirstResponder];
        [self actionLogin:self];
    }
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

- (void)moveImage:(UIImageView *)image duration:(NSTimeInterval)duration
            curve:(int)curve x:(CGFloat)x y:(CGFloat)y
{
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationRepeatAutoreverses:true];
    [UIView setAnimationRepeatCount:10000];
    
    // The transform matrix
    CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
    image.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)moveSignUp:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];


    if ([[UIScreen mainScreen]bounds].size.height == 568) {
        EMSignUpViewController *signUpViewController = (EMSignUpViewController*)[storyBoard  instantiateViewControllerWithIdentifier:@"signUpViewController"];
        [self presentViewController:signUpViewController animated:YES completion:Nil];
    }else{
        EMSignUpViewController *signUpViewController = (EMSignUpViewController*)[storyBoard  instantiateViewControllerWithIdentifier:@"3.5signUpViewController"];
        [self presentViewController:signUpViewController animated:YES completion:Nil];
    }


}



-(IBAction)actionLogin:(id)sender{
    NSInteger result = 0;
    @try {
        
        if([[self.emailField text] isEqualToString:@""] || [[self.pwField text] isEqualToString:@""] ) {
            [self alertStatus:@"Please enter Email and Password" :@"Login Failed :(" :0];
        } else {
            
            //set json
            NSDictionary *newDatasetInfo = [NSDictionary dictionaryWithObjectsAndKeys:self.emailField.text, @"email", self.pwField.text, @"password", nil];
            NSError *jsonError;
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:newDatasetInfo options:kNilOptions error:&jsonError];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            NSURL *url=[NSURL URLWithString:@"http://10.73.45.130:8080/gradation/intro/login"];
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
                    [self alertStatus:@"login success" :@"gogogogo!" :0];
                    
                    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                    EMPolaroidViewController *polaroidViewController = (EMPolaroidViewController*)[storyBoard  instantiateViewControllerWithIdentifier:@"polaroidViewController"];
                    [self presentViewController:polaroidViewController animated:YES completion:Nil];

                    
                    
                }else if (result == 202){
                    [self alertStatus:self.emailField.text :@"Plz verify email :)" :0];
                } else { //로그인 실패처리
                    NSString *error_msg = (NSString *) jsonData[@"message"];
                    [self alertStatus:error_msg :@"Login Failed :(" :0];
                }
            } else {//연결에러
                [self alertStatus:@"not Connection" :@"Login Failed :(" :0];
            }
        }
    }
    
    //예외처리
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Login Failed :(" :@"Error!" :0];
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



@end

