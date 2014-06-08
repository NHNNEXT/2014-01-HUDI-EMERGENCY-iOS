//
//  FQViewController.m
//  fingerqooq
//
//  Created by 이상진 on 2014. 5. 13..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "FQViewController.h"
#import "ProgressHUD.h"
#import "FQTableView.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define MAIN_COLOR 0xe74c3c

#define VIEW_HEIGHT self.view.frame.size.height
#define VIEW_WIDTH self.view.frame.size.width

@interface FQViewController ()

@end

@implementation FQViewController

@synthesize mainScrollView;
@synthesize FBID;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
	// Do any additional setup after loading the view, typically from a nib.
    
    contentsViews = [[NSMutableArray alloc]init];
    

    
    [mainScrollView setDelegate:self];
    [mainScrollView setContentSize:CGSizeMake(320*2, VIEW_HEIGHT)];
    [mainScrollView setScrollEnabled:YES];
//    [mainScrollView setContentOffset:CGPointMake(320, 0) animated:false];
    [mainScrollView setBounces:false];
    [mainScrollView setShowsHorizontalScrollIndicator:false];
    
    contentsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320*2, VIEW_HEIGHT)];
    [contentsView setBackgroundColor:[UIColor colorWithRed:233/255.0 green:234/255.0 blue:237/255.0 alpha:1]];
    
    [mainScrollView addSubview:contentsView];
    

    
    //dataArray설정
    dataArray = [NSMutableArray new];
    
    //AFNetwork 설정
    manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@"http://10.73.45.130:8080/gradation/api/v1/articles" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (int i = 0; i<[responseObject count]; i++) {
            [dataArray addObject:responseObject[i]];
        }
        [self initTableView];
        [self getArticlesFromServer:[[dataArray firstObject] objectForKey:@"id"]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [ProgressHUD showError:@"에라이 에라다!"];
    }];
    
    articleView = [FQTextView new];
    articleView.viewControllerRef = self;
    [articleView initHighlightMenu];
    
//    [self test];
    
    
//    touchableView = [[UIView alloc]initWithFrame:self.view.bounds];
//    [touchableView setBackgroundColor:UIColorFromRGB(MAIN_COLOR)];
//    [touchableView setAlpha:0.10];
//    [touchableView addGestureRecognizer:firstArticle.panGestureRecognizer];
//    [touchableView addGestureRecognizer:secondArticle.panGestureRecognizer];
//    [touchableView addGestureRecognizer:mainScrollView.panGestureRecognizer];
//    [touchableView removeGestureRecognizer:mainScrollView.panGestureRecognizer];
//    [self.view addSubview:touchableView];
    
//    [self dismissViewControllerAnimated:NO completion:nil];
    
}


-(void)initTableView{
    /////테이블뷰
    
    
    CGRect fMain = CGRectMake(0, 0, 320, VIEW_HEIGHT);
    
    FQTableView *listTableView = [[FQTableView alloc]initWithFrame:CGRectMake(0, 0, 320, VIEW_HEIGHT)];
    UIView *overlayView = [[UIView alloc]initWithFrame:fMain];
    [overlayView setBackgroundColor:[UIColor blackColor]];
    [overlayView setAlpha:0.8f];
    
    
    UIImageView *listBackgroundImageView = [[UIImageView alloc]initWithFrame:fMain];
    [listBackgroundImageView setImage:[UIImage imageNamed:@"titleImage1.jpg"]];
    [listBackgroundImageView addSubview:overlayView];
    
    [listTableView setBackgroundView:listBackgroundImageView];
    
    
    [listTableView setDelegate:self];
    [listTableView setDataSource:self];
    
    
    //    [listTableView setDataSource:[NSArray arrayWithObjects:@"하나", nil]];
    
    // tableFooterView를 정의. 사전에 tableFooterView가 기획되지 않았으므로 작은 영역으로 정의한다.
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 10)];
    
    // footerView가 화면에 보이지 않도록 배경은 투명하게
    footerView.backgroundColor = [UIColor clearColor];
    
    [listTableView setTableFooterView:footerView];
    
    listTableView.SeparatorInset = UIEdgeInsetsZero;
    
    [contentsView addSubview:listTableView];
    
    //메뉴바
    menuBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 44)];
    [menuBar setBackgroundColor:[UIColor whiteColor]];
    UIButton *btnLogout = [[UIButton alloc]init];
    UIButton *btnMyArticles = [[UIButton alloc]init];
    UIButton *btnAllArticles = [[UIButton alloc]init];
    
    //로그아웃버튼
    [btnLogout setFrame:CGRectMake(0, 0, 80, 44)];
    
    [btnLogout setTitle:@"Logout" forState:UIControlStateNormal];
    [btnLogout setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btnLogout addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    
    [menuBar addSubview:btnLogout];
    
    //마이아티클즈 버튼
    
    [btnMyArticles setFrame:CGRectMake(VIEW_WIDTH-110, 0, 100, 44)];
    
    [btnMyArticles setTitle:@"My Articles" forState:UIControlStateNormal];
    [btnMyArticles setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btnMyArticles addTarget:self action:@selector(myArticles) forControlEvents:UIControlEventTouchUpInside];
    
    [menuBar addSubview:btnMyArticles];
    
    //올아티클즈 버튼
    [btnAllArticles setFrame:CGRectMake(btnMyArticles.frame.origin.x-110, 0, 100, 44)];
    
    [btnAllArticles setTitle:@"All Articles" forState:UIControlStateNormal];
    [btnAllArticles setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btnAllArticles addTarget:self action:@selector(allArticles) forControlEvents:UIControlEventTouchUpInside];
    
    [menuBar addSubview:btnAllArticles];
    
    
    [listTableView setTableHeaderView:menuBar];
//    [contentsView addSubview:menuBar];
    
//    [listTableView reloadData];
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
    
//    if(scrollView.contentOffset.x == 0) {
//        CGPoint newOffset = CGPointMake(scrollView.bounds.size.width+scrollView.contentOffset.x, scrollView.contentOffset.y);
//        [scrollView setContentOffset:newOffset];
//        [self rotateViewsRight];
//    }
//    else if(scrollView.contentOffset.x == scrollView.bounds.size.width*2) {
//        CGPoint newOffset = CGPointMake(scrollView.contentOffset.x-scrollView.bounds.size.width, scrollView.contentOffset.y);
//        [scrollView setContentOffset:newOffset];
//        [self rotateViewsLeft];
//    }
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
    for(int i = 0; i < 3; i++) {
        FQTextView * view = contentsViews[i];
        [view setFrame:CGRectMake(self.view.bounds.size.width*i, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    }
}

-(void)getArticlesFromServer:(id)articleId{
//    __block id response;
    
//    __block int index = 0;
    
    if ([contentsViews count]) {
        NSLog(@"%d",(int)[contentsViews count]);
        [[contentsViews lastObject] removeFromSuperview];
        [contentsViews removeLastObject];
    }
    
    NSString *articleUrl = [NSString stringWithFormat:@"%@%@",@"http://10.73.45.130:8080/gradation/api/v1/articles/",articleId];
    
    [manager GET:articleUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        CGRect firstArticleFrame = CGRectMake(320*1, 0, 320, self.view.frame.size.height);
        
        
        NSString *htmlString= [responseObject objectForKey:@"contents"];
        
        
        
        NSString *titleString= [responseObject objectForKey:@"title"];
        
        NSString *imgString= [responseObject objectForKey:@"titleImg"];
        UIImage *titleImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgString]]];
        
        articleView = [[FQTextView alloc]initWithFrame:firstArticleFrame titleString:titleString titleImage:titleImg contentsString:htmlString];
        articleView.articleId = articleId;
        
        [contentsViews addObject:articleView];
        [contentsView addSubview:articleView];
        [mainScrollView setContentOffset:CGPointMake(320, 0) animated:true];
        
        [ProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [ProgressHUD showError:@"에라이 에라다!"];
    }];

    
}


#pragma mark -
#pragma mark 테이블뷰

//섹션과 row로 cell의 높이 설정
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int cellHeight = 50;
    return cellHeight;
}



//셀선택
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [ProgressHUD show:@"로딩중..."];
    [self getArticlesFromServer:[[dataArray objectAtIndex:indexPath.row] objectForKey:@"id"]];
    
}

//셀 표시
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CELL";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.textLabel.text = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"title"];
//    [cell.textLabel sizeToFit];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//섹션내아이템이몇개?
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}


#pragma mark -
#pragma mark 메뉴바 버튼 셀렉터들
- (void)logout:(id)sender {
    NSLog(@"눌림");
    [[FBSession activeSession]closeAndClearTokenInformation];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)myArticles{
    NSString *myarticleGetURL = [NSString stringWithFormat:@"http://10.73.45.130:8080/gradation/api/v1/myarticles/%@",FBID];

    [manager GET:myarticleGetURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [dataArray removeAllObjects];
        
        for (int i = 0; i<[responseObject count]; i++) {
            [dataArray addObject:responseObject[i]];
        }
        [self initTableView];
//        [self getArticlesFromServer:[[dataArray firstObject] objectForKey:@"id"]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [ProgressHUD showError:@"에라이 에라다!"];
    }];
}

- (void)allArticles{
    NSString *articleGetURL = @"http://10.73.45.130:8080/gradation/api/v1/articles";

    [manager GET:articleGetURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [dataArray removeAllObjects];
        
        for (int i = 0; i<[responseObject count]; i++) {
            [dataArray addObject:responseObject[i]];
        }
        [self initTableView];
        //        [self getArticlesFromServer:[[dataArray firstObject] objectForKey:@"id"]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [ProgressHUD showError:@"에라이 에라다!"];
    }];
}

@end
