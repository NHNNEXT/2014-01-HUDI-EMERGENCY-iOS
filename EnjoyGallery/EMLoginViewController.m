//
//  EMLoginViewController.m
//  EnjoyGallery
//
//  Created by LeeYoungNam on 4/14/14.
//  Copyright (c) 2014 EntusApps. All rights reserved.
//

#import "EMLoginViewController.h"
#import "EMSignUpViewController.h"

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
    
    //button color & radius
    _loginButton.backgroundColor = [UIColor colorWithRed:(178/255.0) green:(177/255.0) blue:(201/255.0) alpha:1];
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
        //connect "login action "
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
    EMSignUpViewController *signUpViewController = [[EMSignUpViewController alloc]init];
    [self.view addSubview:signUpViewController.view];
    [UIView beginAnimations:@"flipview" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];


    [UIView commitAnimations];
}
@end

