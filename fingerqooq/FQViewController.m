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

#define SERVERIP fingqooq.com

@interface FQViewController ()

@end

@implementation FQViewController

@synthesize mainScrollView;
@synthesize FBID;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    
    contentsViews = [[NSMutableArray alloc]init];
    btnFlag = true;

    
    [mainScrollView setDelegate:self];
    [mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT)];
    [mainScrollView setScrollEnabled:YES];
    [mainScrollView setBounces:false];
    [mainScrollView setShowsHorizontalScrollIndicator:false];
    
    contentsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH*2, VIEW_HEIGHT)];
    [contentsView setBackgroundColor:[UIColor colorWithRed:233/255.0 green:234/255.0 blue:237/255.0 alpha:1]];
    
    [mainScrollView addSubview:contentsView];
    
    [self initMenuBar];

    
    //dataArray설정
    dataArray = [NSMutableArray new];
    
    //AFNetwork 설정
    manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@"http://fingqooq.com/api/v1/articles" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (int i = 0; i<[responseObject count]; i++) {
            [dataArray addObject:responseObject[i]];
        }
        [self initTableView];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [ProgressHUD showError:@"에라이 에라다!"];
    }];
    
    articleView = [FQTextView new];
    articleView.viewControllerRef = self;
    articleView.mainScrollView = mainScrollView;
    [articleView initHighlightMenu];
    
}


-(void)initTableView{
    /////테이블뷰
    
    
    CGRect fMain = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    
    listTableView = [[FQTableView alloc]initWithFrame:CGRectMake(0, 44, VIEW_WIDTH, VIEW_HEIGHT-44)];
    UIView *overlayView = [[UIView alloc]initWithFrame:fMain];
    [overlayView setBackgroundColor:[UIColor whiteColor]];
    [overlayView setAlpha:0.8f];
    
    
    UIImageView *listBackgroundImageView = [[UIImageView alloc]initWithFrame:fMain];
    [listBackgroundImageView addSubview:overlayView];
    
    [listTableView setBackgroundView:listBackgroundImageView];
    
    
    [listTableView setDelegate:self];
    [listTableView setDataSource:self];
    
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 10)];
    
    // footerView가 화면에 보이지 않도록 배경은 투명하게
    footerView.backgroundColor = [UIColor clearColor];
    
    [listTableView setTableFooterView:footerView];
    
    listTableView.SeparatorInset = UIEdgeInsetsZero;
    
    [contentsView addSubview:listTableView];
    [contentsView sendSubviewToBack:listTableView];
    
}


-(void)initMenuBar{
    
    //메뉴바
    menuBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 44)];
    [menuBar setBackgroundColor:[UIColor whiteColor]];
    UIButton *btnLogout = [[UIButton alloc]init];
    btnArticles = [[UIButton alloc]init];
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, menuBar.frame.size.height, menuBar.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = UIColorFromRGB(MAIN_COLOR).CGColor;
    [menuBar.layer addSublayer:bottomBorder];
    
    //로그아웃버튼
    [btnLogout setFrame:CGRectMake(0, 0, 80, 44)];
    
    [btnLogout setTitle:@"Logout" forState:UIControlStateNormal];
    [btnLogout setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btnLogout addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    
    [menuBar addSubview:btnLogout];
    
    //아티클즈 버튼
    
    [btnArticles setFrame:CGRectMake(VIEW_WIDTH-80, 0, 70, 44)];
    
    [btnArticles setTitle:@"My Q" forState:UIControlStateNormal];
    [btnArticles setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btnArticles addTarget:self action:@selector(sBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [menuBar addSubview:btnArticles];
    
    [contentsView addSubview:menuBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden{
    return true;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"터치다.");
}


-(void)getArticlesFromServer:(id)articleId{

    NSString *articleUrl = [NSString stringWithFormat:@"%@%@",@"http://fingqooq.com/api/v1/articles/",articleId];
    
    [manager GET:articleUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        CGRect firstArticleFrame = CGRectMake(VIEW_WIDTH*1, 0, VIEW_WIDTH, self.view.frame.size.height);
        
        
        NSString *htmlString= [responseObject objectForKey:@"contents"];
        
        
        
        NSString *titleString= [responseObject objectForKey:@"title"];
        
        NSString *imgString= [responseObject objectForKey:@"titleImg"];
        UIImage *titleImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgString]]];
        
        articleView = [[FQTextView alloc]initWithFrame:firstArticleFrame titleString:titleString titleImage:titleImg contentsString:htmlString];
        articleView.articleId = articleId;
        articleView.mainScrollView = mainScrollView;
        [contentsView addSubview:articleView];
        [mainScrollView setContentOffset:CGPointMake(VIEW_WIDTH, 0) animated:true];
        
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
    [mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH*2, VIEW_HEIGHT)];
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
    [cell.textLabel setTextColor:[UIColor blackColor]];
    cell.textLabel.text = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//섹션내아이템이몇개?
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}


#pragma mark -
#pragma mark 메뉴바 버튼 셀렉터들

-(void)sBtn{
    NSLog(@"??");
    if (btnFlag==true) {
        [self myArticles];
        [btnArticles setTitle:@"All Q" forState:UIControlStateNormal];
        
        btnFlag = false;
    }
    else {
        [self allArticles];
        [btnArticles setTitle:@"My Q" forState:UIControlStateNormal];
        
        btnFlag = true;
    }
}

- (void)logout:(id)sender {
    NSLog(@"눌림");
    [[FBSession activeSession]closeAndClearTokenInformation];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)myArticles{
    NSString *myarticleGetURL = [NSString stringWithFormat:@"http://fingqooq.com/api/v1/myarticles/%@",FBID];

    [manager GET:myarticleGetURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [dataArray removeAllObjects];
        
        for (int i = 0; i<[responseObject count]; i++) {
            [dataArray addObject:responseObject[i]];
        }
//        [listTableView reloadData];
        [listTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];

//        [self getArticlesFromServer:[[dataArray firstObject] objectForKey:@"id"]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [ProgressHUD showError:@"에라이 에라다!"];
    }];
}

- (void)allArticles{
    NSString *articleGetURL = @"http://fingqooq.com/api/v1/articles";

    [manager GET:articleGetURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [dataArray removeAllObjects];
        
        for (int i = 0; i<[responseObject count]; i++) {
            [dataArray addObject:responseObject[i]];
        }
        [listTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [ProgressHUD showError:@"에라이 에라다!"];
    }];
}

@end
