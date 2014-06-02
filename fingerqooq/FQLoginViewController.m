//
//  FQLoginViewController.m
//  fingerqooq
//
//  Created by 이상진 on 2014. 5. 29..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "FQLoginViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define MAIN_COLOR 0xe74c3c


@implementation FQLoginViewController

@synthesize pwField;
@synthesize idField;

-(void)viewDidLoad{
    manager = [AFHTTPRequestOperationManager manager];
    
    FBLoginView *loginView = [[FBLoginView alloc]init];
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 305);
    
    
    loginView.delegate = self;
    
    idField.layer.borderWidth = 1.0f;
    idField.layer.borderColor = [UIColor whiteColor].CGColor;
    idField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [idField setValue:[UIColor lightGrayColor]
                    forKeyPath:@"_placeholderLabel.textColor"];
    idField.delegate = self;
    pwField.layer.borderWidth = 1.0f;
    pwField.layer.borderColor = [UIColor whiteColor].CGColor;
    pwField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [pwField setValue:[UIColor lightGrayColor]
           forKeyPath:@"_placeholderLabel.textColor"];
    pwField.delegate = self;
    
    UIButton *loginButton = [[UIButton alloc]init];
//    [loginButton setFrame:CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 300)];
    loginButton.frame = CGRectMake((self.view.center.x - (loginView.frame.size.width / 2)), 250, loginView.frame.size.width, 40);
    loginButton.layer.borderWidth = 0.5f;
    loginButton.layer.cornerRadius = 5;
    loginButton.layer.borderColor = [UIColor clearColor].CGColor;
    
//    [loginButton setBackgroundColor:UIColorFromRGB(MAIN_COLOR)];
    [loginButton setBackgroundColor:[UIColor clearColor]];
    [loginButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [loginButton.layer setBorderWidth:1.0f];
    [loginButton setTitle:@"로그인" forState:UIControlStateNormal];
    
    
    
    UIButton *joinButton = [[UIButton alloc]init];
    joinButton.frame = CGRectMake((self.view.center.x - (loginView.frame.size.width / 2)), 450, loginView.frame.size.width, 40);
    joinButton.layer.borderWidth = 0.5f;
    joinButton.layer.cornerRadius = 5;
    joinButton.layer.borderColor = [UIColor clearColor].CGColor;
    
    [joinButton setBackgroundColor:[UIColor clearColor]];
    [joinButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [joinButton.layer setBorderWidth:1.0f];
    [joinButton setTitle:@"회원가입" forState:UIControlStateNormal];
    
    
    
//    [self.view setBackgroundColor:[UIColor colorWithRed:233/255.0 green:234/255.0 blue:237/255.0 alpha:1.0]];
    UIImageView *bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"blur3.jpg"]];
    [bgView setFrame:CGRectMake(0, 0, 640, self.view.frame.size.height)];
//    [bgView sizeToFit];
    
    [UIView beginAnimations:@"moveBg" context:nil];
    [UIView setAnimationDuration:90];
    [UIView setAnimationRepeatAutoreverses:true];
    [UIView setAnimationRepeatCount:1000];
    
    [bgView setFrame:CGRectMake(-320, 0, 640, self.view.frame.size.height)];
    
    [UIView commitAnimations];
    
    [self.view addSubview:bgView];
    
//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"blur2.png"]]];
    [self.view addSubview:loginButton];
    [self.view addSubview:loginView];
    [self.view addSubview:joinButton];
    [self.view sendSubviewToBack:bgView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //hides keyboard when another part of layout was touched
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
//    [self moveView:self.view y:0.0];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return true;
}

-(BOOL)prefersStatusBarHidden{
    return true;
}


-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
    NSDictionary *parameters = @{@"FBid":user.id,@"FBname":user.name};
    
    
    
    
    [manager POST:@"http://localhost:8080/gradation/FBLogin" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:[NSBundle mainBundle]];
        FQViewController *contentsViewController = (FQViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"contentsViewController"];

        [self presentViewController:contentsViewController animated:false completion:nil];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    
//    [manager POST:@"http://10.73.45.130:8080/gradation/FBLogin" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileURL:filePath name:@"image" error:nil];
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"Success: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
}

@end
