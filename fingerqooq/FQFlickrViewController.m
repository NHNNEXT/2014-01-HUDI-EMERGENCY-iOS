//
//  FQFlickrViewController.m
//  fingerqooq
//
//  Created by 이상진 on 2014. 6. 14..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "FQFlickrViewController.h"

#define LICENSE 6
#define APIKEY @"55ad9dcb5cc69be0c7746a974aa9bda4"

@implementation FQFlickrViewController

-(void)viewDidLoad{
    manager = [AFHTTPRequestOperationManager manager];
    
    
}
- (IBAction)search:(id)sender {
    
    NSString *flickrURL = @"https://api.flickr.com/services/rest/";
    
    NSDictionary *param = @{@"method":@"flickr.photos.search",
                            @"api_key":APIKEY,
                            @"text":self.searchTextField.text,
                            @"par_page":@10,
                            @"format":@"json",
                            @"nojsoncallback":@1,
                            @"license":@LICENSE
                            };
    
    
    [manager GET:flickrURL parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"%@",[[[responseObject objectForKey:@"photos"] objectForKey:@"photo"]firstObject]);
        NSDictionary *photoInfo = [[[responseObject objectForKey:@"photos"] objectForKey:@"photo"]firstObject];
        
//        NSLog(@"%@",photoInfo);
        
        NSString *stringPhotoURL = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_b.jpg",
                              [photoInfo objectForKey:@"farm"],[photoInfo objectForKey:@"server"],[photoInfo objectForKey:@"id"],[photoInfo objectForKey:@"secret"]];
        NSURL *photoURL = [NSURL URLWithString:stringPhotoURL];
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:photoURL]];
        
        [self.imageView setImage:image];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

@end
