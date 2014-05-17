//
//  FQViewController.m
//  fingerqooq
//
//  Created by 이상진 on 2014. 5. 13..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "FQViewController.h"
#import "AFNetworking.h"
#import "ProgressHUD.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define MAIN_COLOR 0xe74c3c

#define VIEW_HEIGHT self.view.frame.size.height

@interface FQViewController ()

@end

@implementation FQViewController

@synthesize mainScrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
	// Do any additional setup after loading the view, typically from a nib.
    
    contentsViews = [[NSMutableArray alloc]init];
    
    [self getArticlesFromServer];
    
    [mainScrollView setDelegate:self];
    [mainScrollView setContentSize:CGSizeMake(320*3, VIEW_HEIGHT)];
    [mainScrollView setScrollEnabled:YES];
    [mainScrollView setContentOffset:CGPointMake(320, 0) animated:false];
    [mainScrollView setBounces:false];
    [mainScrollView setShowsHorizontalScrollIndicator:false];
    
    contentsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320*3, VIEW_HEIGHT)];
    [contentsView setBackgroundColor:[UIColor colorWithRed:233/255.0 green:234/255.0 blue:237/255.0 alpha:1]];
    
    [mainScrollView addSubview:contentsView];
    
    
    
    
    
//    touchableView = [[UIView alloc]initWithFrame:self.view.bounds];
//    [touchableView setBackgroundColor:UIColorFromRGB(MAIN_COLOR)];
//    [touchableView setAlpha:0.10];
//    [touchableView addGestureRecognizer:firstArticle.panGestureRecognizer];
//    [touchableView addGestureRecognizer:secondArticle.panGestureRecognizer];
//    [touchableView addGestureRecognizer:mainScrollView.panGestureRecognizer];
//    [touchableView removeGestureRecognizer:mainScrollView.panGestureRecognizer];
//    [self.view addSubview:touchableView];
    
}


- (IBAction)test:(id)sender {
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{
    return true;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"터치다.");
}

#pragma mark -
#pragma mark 스크롤뷰 루프
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if(scrollView.contentOffset.x == 0) {
        CGPoint newOffset = CGPointMake(scrollView.bounds.size.width+scrollView.contentOffset.x, scrollView.contentOffset.y);
        [scrollView setContentOffset:newOffset];
        [self rotateViewsRight];
    }
    else if(scrollView.contentOffset.x == scrollView.bounds.size.width*2) {
        CGPoint newOffset = CGPointMake(scrollView.contentOffset.x-scrollView.bounds.size.width, scrollView.contentOffset.y);
        [scrollView setContentOffset:newOffset];
        [self rotateViewsLeft];
    }
}

-(void)rotateViewsRight {
    
    FQTextView *endView = [contentsViews lastObject];
    [contentsViews removeLastObject];
    [contentsViews insertObject:endView atIndex:0];
    [self setContentViewFrames];
    
}

-(void)rotateViewsLeft {
    FQTextView *endView = contentsViews[0];
    [contentsViews removeObjectAtIndex:0];
    [contentsViews addObject:endView];
    [self setContentViewFrames];
    
}

-(void) setContentViewFrames {
    
//    [ProgressHUD show:@"로딩중!"];
    for(int i = 0; i < 3; i++) {
        FQTextView * view = contentsViews[i];
        [view setFrame:CGRectMake(self.view.bounds.size.width*i, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    }
}

-(void)getArticlesFromServer{
//    __block id response;
    
//    __block int index = 0;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://10.73.45.130:8080/gradation/api/v1/articles/16" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        CGRect firstArticleFrame = CGRectMake(320*0, 0, 320, self.view.frame.size.height);
        
        
        NSString *htmlString= [responseObject objectForKey:@"contents"];
//        NSString *htmlString= @"<html><head></head><body><p>허허 이럴수가 한글만 되다니..</p><p>허허 이럴수가 한글만 되다니..</p><p>허허 이럴수가 한글만 되다니..</p><p>허허 이럴수가 한글만 되다니..</p><p>허허 이럴수가 한글만 되다니..</p><p>허허 이럴수가 한글만 되다니..</p><p>허허 이럴수가 한글만 되다니..</p><p>허허 이럴수가 한글만 되다니..</p></body></html>";
        
        
        
        NSString *titleString= [responseObject objectForKey:@"title"];
        
        NSString *imgString= [responseObject objectForKey:@"titleImg"];
        UIImage *titleImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgString]]];
        
        FQTextView *articleView = [[FQTextView alloc]initWithFrame:firstArticleFrame titleString:titleString titleImage:titleImg contentsString:htmlString];
        
        [articleView initHighlightMenu];
        [contentsViews addObject:articleView];
        [contentsView addSubview:articleView];

        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [ProgressHUD showError:@"에라이 에라다!"];
    }];
    
    [manager GET:@"http://10.73.45.130:8080/gradation/api/v1/articles/24" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        CGRect firstArticleFrame = CGRectMake(320*1, 0, 320, self.view.frame.size.height);
        
        
        NSString *htmlString= [responseObject objectForKey:@"contents"];
        
        NSString *titleString= [responseObject objectForKey:@"title"];
        
        NSString *imgString= [responseObject objectForKey:@"titleImg"];
        UIImage *titleImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgString]]];
        
        FQTextView *articleView = [[FQTextView alloc]initWithFrame:firstArticleFrame titleString:titleString titleImage:titleImg contentsString:htmlString];
        
        [contentsViews addObject:articleView];
        [contentsView addSubview:articleView];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [ProgressHUD showError:@"에라이 에라다!"];
    }];
    
    [manager GET:@"http://10.73.45.130:8080/gradation/api/v1/articles/25" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        CGRect firstArticleFrame = CGRectMake(320*2, 0, 320, self.view.frame.size.height);
        
        
        NSString *htmlString= [responseObject objectForKey:@"contents"];
        
        NSString *titleString= [responseObject objectForKey:@"title"];
        
        NSString *imgString= [responseObject objectForKey:@"titleImg"];
        UIImage *titleImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgString]]];
        
        FQTextView *articleView = [[FQTextView alloc]initWithFrame:firstArticleFrame titleString:titleString titleImage:titleImg contentsString:htmlString];
        
        [contentsViews addObject:articleView];
        [contentsView addSubview:articleView];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [ProgressHUD showError:@"에라이 에라다!"];
    }];
    
}

@end
