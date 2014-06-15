//
//  FQFlickrViewController.h
//  fingerqooq
//
//  Created by 이상진 on 2014. 6. 14..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AFNetworking.h"

@interface FQFlickrViewController : UIViewController{
    AFHTTPRequestOperationManager *manager;
    
}

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
