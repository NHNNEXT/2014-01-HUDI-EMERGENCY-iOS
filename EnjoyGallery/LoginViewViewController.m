//
//  LoginViewViewController.m
//  EnjoyGallery
//
//  Created by LeeYoungNam on 4/14/14.
//  Copyright (c) 2014 EntusApps. All rights reserved.
//

#import "LoginViewViewController.h"

@interface LoginViewViewController ()
@end

@implementation LoginViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    
    //button color & radius
    _loginButton.backgroundColor = [UIColor colorWithRed:(76/255.0) green:(217/255.0) blue:(100/255.0) alpha:1];
    _loginButton.layer.cornerRadius = 5.0f;
    _signUpButton.backgroundColor = [UIColor colorWithRed:(143/255.0) green:(150/255.0) blue:(144/255.0) alpha:1];

    
    // Move the image
    [self moveImage:_bgImage duration:15.0
              curve:UIViewAnimationCurveLinear x:100.0 y:30.0];
    
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

@end

