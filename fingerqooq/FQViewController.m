//
//  FQViewController.m
//  fingerqooq
//
//  Created by 이상진 on 2014. 5. 13..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "FQViewController.h"
#import "UIImage+ImageEffects.h"


#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define MAIN_COLOR 0xe74c3c

@interface FQViewController ()

@end

@implementation FQViewController

@synthesize contentsTextView;
@synthesize mainScrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //하이라이트 메뉴 부분
    NSMutableArray *menuItems = [[[UIMenuController sharedMenuController] menuItems] mutableCopy];
    if (!menuItems) {
        menuItems = [[NSMutableArray alloc]init];
    }
    UIMenuItem *highlightMenuItem = [[UIMenuItem alloc]initWithTitle:@"하이라이트" action:@selector(highlightText:)];
    [menuItems addObject:highlightMenuItem];
    [[UIMenuController sharedMenuController] setMenuItems:menuItems];

    
    [mainScrollView setContentSize:CGSizeMake(320*3, self.view.frame.size.height)];
    [mainScrollView setScrollEnabled:YES];
    
    
    UIView *contentsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 640, self.view.frame.size.height)];
    [contentsView setBackgroundColor:[UIColor colorWithRed:233/255.0 green:234/255.0 blue:237/255.0 alpha:1]];
    [mainScrollView addSubview:contentsView];
    
    
    ///////////////////////////////
    myTextView = [[FQTextView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    myTextView.delegate = self;
    
    [myTextView initInset];
//    [myTextView setBackgroundColor:[UIColor whiteColor]];
    
    NSString *htmlString1 = @"<p>“아아, 마치 죄인이 된 듯한 심정입니다.”</p>     <p>전화가 어렵게 연결됐다. 수화기 너머로 벨소리가 10번도 넘게 이어졌다. 아직 통화는 어렵겠지. 포기하고 그만 전화기의 종료 단추를 누르려는 순간, 그가 다급한 목소리로 전화를 받았다. 하긴, 결과가 궁금한 게 어디 나뿐일까. 분명 여기저기에서 걸려오는 숱한 전화에 시달렸을 게다.</p>     <p>‘죄인’. 두 글자가 헌법재판소의 결정만큼이나 가슴에 깊이 꽂혔다. 차마 봄기운이 다 퍼지지도 않은 4월의 하늘을 넘어온 전파가 건네준 그의 첫 마디였다. 참담함과 허탈함. 전화 통화일 뿐인데도 그 심정이 남김없이 묻어났다. 어찌 된 것인가요? 라며 더는 추궁할 수 없었다. 다음에 보자며 기약 없는 약속을 내뱉고 그대로 전화를 끊었다. 4월24일, 헌법재판소가 ‘강제적 셧다운제’에 합헌 결정을 내린 바로 그 날, 이병찬 법무법인정진 변호사와의 통하는 그렇게 짧게 끝났다.</p>         <p>이병찬 변호사를 처음 만난 것은 지난 2011년 초였다. 햇수로만 벌써 4년이 흘렀다. 그때 국회 안팎에서는 셧다운제 도입으로 잡음이 심했다. 셧다운제를 도입해서는 안 된다는 얘기를 하는 이들은 이병찬 변호사 주위로 몰렸다. 이병찬 변호사도 반대 견해를 분명히 했던 이들 중 하나다. 셧다운제가 뭔지, 셧다운제가 왜 청소년의 권리를 제한하는 규제인 것인지. 게임과 정부 정책을 아우를 수 있는 전문가를 만나는 것이 어렵던 당시, 이병찬 변호사는 이른바 가장 좋은 ‘취재원’이었다.</p>     <p>일만 생기면 이병찬 변호사부터 찾았다. 셧다운제 반대 토론회나 세미나에 자주 얼굴을 내비쳤다. TV 토론회나 라디오에서도 이병찬 변호사는 셧다운제를 도입해야 한다는 이들과 맞섰다. 2011년 4월29일, 셧다운제가 국회 본회의를 통과했다. 이병찬 변호사가 셧다운제에 위헌소송을 준비한 것은 그 이후부터다. 지난 4월 헌법재판소의 셧다운제 합헌 판결은 셧다운제 위헌소송의 결말이자 이병찬 변호사의 노력에 대한 사회의 답변인 셈이다. 패잔병이 더이상 무슨 할 말이 있겠느냐며 저어하는 그의 어깨를 잡고, 어렵게 돌려세웠다. 당신이 왜 죄인입니까. 사회를 구성하고 있는 우리 모두의 잘못입니다.</p>     <p>“아이를 불행하게 만드는 것은 게임이 아니라는 것을 제 스스로의 경험으로 너무 잘 알아요. 학부모단체나 찬성하는 이들의 얘기를 들어보면 아이들이 게임 때문에 잠도 못 자고, 공부도 못 하고, 생활이 파괴되고 있다, 뭐 이렇게 얘기하는데, 나도 게임을 하며 살아왔기 때문에 게임을 스스로 통제하는 방법을 익히는 데 시간이 걸릴 뿐이지 진짜 원인은 과도한 입시 스트레스 때문이라고 확신하고 있었던 거죠.”</p>     <p>4년 전, 이병찬 변호사는 어쩌다 셧다운제와 연을 맺게 됐을까. 2010년 말, 그는 잘 다니던 대기업의 법무팀을 나왔다. 기업이 아닌 사회에 보탬이 되는 변호사를 꿈꿨다. 약간의 자유를 손에 쥐고, 게임 쪽으로 슬쩍 발길을 돌릴 수 있었다. 원래 게임을 좋아한 성격 덕분이다. 게임 전문 웹진 게임메카에 e메일을 썼다. 게임 개발자나 게임을 좋아하는 이들을 위해 ‘법과 게임’을 주제로 담은 칼럼이 그렇게 시작됐다.</p>     <p>시기가 적절했다. 2010년 말부터 셧다운제 논의가 급물살을 탔다. 이병찬 변호사는 당시 칼럼에서 셧다운제는 위헌적 소지가 크다고 주장했다. 셧다운제는 당시 사회의 뜨거운 감자였다. MBC ’100분 토론’에서도 셧다운제가 논의될 정도였다. 여러 토론 프로그램에 불려다녔다. 여러 기자로부터 인터뷰 요청이 왔다. 자기가 셧다운제 위헌소송을 진행하게 되리라는 것을 당시의 그는 모르고 있었다.</p>     <p>“너무 크고 중대한 사안이라 혼자서 할 수 있을까, 이런 생각을 많이 했어요. 기업 법률자문만 하던, 이제 막 개업한 변호사가 하기에는 너무 어려운 일이 아닐까. 그런데 어느 순간 제가 아니면 안 될 것 같은 분위기가 됐더라고요.”(웃음)</p>     <p>워낙에 전문가가 없었던 탓이다. 사회에 여론은 들끓었지만, 그와 비례하게 전문가로부터 관심을 받은 사안은 아니었다. 주제가 게임인 탓이다. 게임은 언제나 우리 사회에서 하위문화일 뿐이니까. 이병찬 변호사는 청소년 두 명과 학부모 한 명과 함께 2011년 10월28일 헌법재판소에 셧다운제 헌법소원 청구서를 제출했다.</p>         <p>혹시 그는 결말을 예상하고 있었을까. 4년 뒤 셧다운제에 합헌 결정이 나오리라는 것을 말이다. 오히려 위헌 결정을 받을 것이라고 기대하는 목소리가 컸다. 셧다운제를 반대하는 이들의 주장대로 셧다운제는 청소년이 자유롭게 즐길 권리를 제한하는 규제였으며, 자녀를 양육하는 가정의 고유한 권한에 국가가 개입하는 조처가 아닌가. 당연히 위헌 결정이 나올 것으로 생각한 이들은 그래서 이번 헌법재판소의 판결에 더 충격이 컸을 지도 모른다.</p>     <p>“만약 결말을 예상했더라도 싸울 수밖에 없었어요. 이길 수 있어서 싸웠다기보다는 분명 싸울 가치가 있는 싸움이었으니까.”</p>    <p>게임을 넘어서는 그 무언가에 관한 ‘가치’가 셧다운제 헌법소원에 있었다는 설명이다. 우리 사회 기저에 깔린 게임은 해로운 매체라는 인식. 건강을 위해서라면 국가가 나서서 청소년을 훈육해도 좋다는 후견주의적 관점. 그리고 셧다운제와 셧다운제 위헌 소송이 불러올 이러한 논의에 관한 사회적인 관심들. 이병찬 변호사는 셧다운제 위헌 소송이 우리 사회에 이같은 문제에 대한 폭넓은 논의를 불러오길 바랐다.</p>     <p>“사회가 성숙할수록 그런 논의가 진지하게 고민될 수 있지 않을까, 이런 기대가 있었던 것도 사실이고요. 안타까운 것은 헌법소원이 진행되는 과정에서도 그런 논의가 제대로 이루어지지 않은 것 같아요.”</p>     <p>말하자면, 셧다운제는 사회의 표상이다. 사회가 게임을 대하는 인식이 어떠한가를 보여주는 상징물이다. 실제로 셧다운제 때문에 심야 시간에 게임을 즐기지 못하는 청소년이 그리 많지 않다고 하더라도, 셧다운제가 게임 서비스 업체의 매출에 그리 큰 타격을 주는 것은 아니라고 하더라도 셧다운제에 반대 목소리를 높인 이들은 게임에 편견을 더하는 상징적인 셧다운제를 그냥 두고 볼 수 없었던 것이다.</p>     <p>셧다운제 위헌 소송이 진행되는 4년 동안 게임과 중독에 관한 의학적인 연구 결과가 나오지 않았다. 게임이 과연 ‘중독물질’인지, 게임이 정말 청소년의 건강에 유해한 영향을 끼치는지에 관한 과학적인 연구도 진행된 바 없다. 셧다운제 위헌 소송이 진행되는 사이에도 게임에 관한 사회적 논의는 정지된 상태 그대로를 유지했을 뿐이다. 결국 셧다운제 위헌소송은 우리 사회가 가진 편견의 벽을 넘지 못했다.</p>     <p>“게임에 대한 편견을 뛰어넘으려면, 부모가 직접 게임을 해봐야 한다고 봐요. 아이가 좋아하는 게임이 뭐고, 그 게임이 어떤 게임인가에 대해 이해하고 있으면 아이가 게임을 하는 방식이나 시간을 부모가 통제할 수 있겠죠. 아이들은 아빠가 왜 술을 먹고 늦게 집에 오는지 잘 모르잖아요. 아빠가 주말에 왜 잠만 자야 하는지 잘 몰라요. 아이가 직장인이 돼야 알 수 있는 것처럼 말이죠.”</p>     <p>아마 이 문제는 시간이 해결해주지 않을까. 시간이 약이라는 말만큼 무력한 말도 찾기 어렵지만 결국, 다시 결론은 시간으로 돌아왔다. 지금 게임을 즐기는 이들이 부모가 되고, 게임에 대한 이해도가 상대적으로 높은 이들이 자녀의 교육을 담당하게 될 때. 아마 그때는 게임을 보는 시선이 지금보다 한결 부드러워지지 않을런지.</p>";
    
    [myTextView setTextWithHtmlString:htmlString1];
    
    
    [myTextView setFont:[UIFont systemFontOfSize:20]];
    [myTextView setTextColor:UIColorFromRGB(0x444444)];
    [myTextView setEditable:false];
    
    
    
    //테스트이미지.
    CGRect titleImageRect = CGRectMake(0, 0, 320, self.view.frame.size.height);
    testImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.jpg"]];
    [testImageView setFrame:titleImageRect];
    [myTextView addSubview:testImageView ];
    //테스트 블러
    blurView = [[UIView alloc]initWithFrame:titleImageRect];
    [blurView setBackgroundColor:[UIColor blackColor]];
    [blurView setAlpha:0.4];
    [myTextView addSubview:blurView];
    
    //테스트 제목
    testTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height-150, 300, 150)];
    [testTitle setText:@"“지난 4년, 셧다운제가 아니라 편견과 싸웠습니다.”"];
    [testTitle setFont:[UIFont boldSystemFontOfSize:34]];
    [testTitle setTextColor:[UIColor whiteColor]];
    [testTitle setNumberOfLines:0];
    [testTitle setLineBreakMode:NSLineBreakByWordWrapping];
    [testTitle sizeToFit];
    [testTitle setMinimumScaleFactor:2.0];
    testTitle.adjustsFontSizeToFitWidth = YES;
    
    [myTextView addSubview:testTitle];
    
    UIView *textBgView = [UIView new];
    [textBgView setFrame:CGRectMake(0, self.view.frame.size.height, 320, self.view.frame.size.height)];
    [textBgView setBackgroundColor:[UIColor whiteColor]];
    [myTextView addSubview:textBgView];
    
    [myTextView sendSubviewToBack:textBgView];
    [myTextView sendSubviewToBack:blurView];
    [myTextView sendSubviewToBack:testImageView];
    
    
    
    [contentsView addSubview:myTextView];
//    [myTextView setBackgroundColor:[UIColor clearColor]];
    
    
    
    //////////////////////////////////////////
    
    
    
    
    
    myTextView2 = [[FQTextView alloc]initWithFrame:CGRectMake(320, 0, 320, self.view.frame.size.height)];
    [myTextView2 setBackgroundColor:[UIColor whiteColor]];
    
    
    NSString *htmlString2 = @"<div>aslkfslkflsdkjskjadsdklajlsdkjskldjkjlsdsdkjlsdkjldskjlsdlkjdskljdlskj</div>";
    
    NSAttributedString *attributedString2 = [[NSAttributedString alloc] initWithData:[htmlString2 dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    myTextView2.attributedText = attributedString2;
    
    [myTextView2 setFont:[UIFont systemFontOfSize:20]];
    [myTextView2 setEditable:false];
    
    
  
    
    
    [contentsView addSubview:myTextView2];
    
    
    myTextView3 = [[FQTextView alloc]initWithFrame:CGRectMake(320*2, 0, 320, self.view.frame.size.height)];
    [myTextView3 setBackgroundColor:[UIColor whiteColor]];
    
    [myTextView3 setFont:[UIFont systemFontOfSize:20]];
    [myTextView3 setEditable:false];

    NSString *htmlString = @"<h1>Header</h1><h2>Subheader</h2><p>Some <em>text</em></p><img src='http://blogs.babble.com/famecrawler/files/2010/11/mickey_mouse-1097.jpg' width=70 height=100 />";
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    myTextView3.attributedText = attributedString;
    
    [contentsView addSubview:myTextView3];
    
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"like after"];
//    
//    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
//    textAttachment.image = textImage;
//    
//    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
//    
//    [attributedString replaceCharactersInRange:NSMakeRange(4, 1) withAttributedString:attrStringWithImage];
    
    
    
    
    
    
    
}




-(void)highlightText:(id)sender{
    [myTextView setHighlightText];
    [myTextView2 setHighlightText];
    [myTextView3 setHighlightText];
}



//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *theTouch = [touches anyObject];
//    if ([theTouch tapCount] == 2) {
//        NSLog(@"dfgdfggddfg");
//        [self becomeFirstResponder];
//        UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:@"하이라이트" action:@selector(changeColor:)];
//        UIMenuController *menuCont = [UIMenuController sharedMenuController];
//        
//        [menuCont setTargetRect:myTextView.frame inView:myTextView];
//        
//        menuCont.arrowDirection = UIMenuControllerArrowLeft;
//        menuCont.menuItems = [NSArray arrayWithObject:menuItem];
//        [menuCont setMenuVisible:YES animated:YES];
//    }
//}
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {}
//
//- (BOOL)canBecomeFirstResponder { return YES; }
//
//- (void)changeColor:(id)sender {
////    if ([self.viewColor isEqual:[UIColor blackColor]]) {
////        self.viewColor = [UIColor redColor];
////    } else {
////        self.viewColor = [UIColor blackColor];
////    }
////    [self setNeedsDisplay];
//    NSLog(@"눌림!");
//}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double scrollOffsetY = scrollView.contentOffset.y;
    if (scrollOffsetY<=0) {
        [testImageView setFrame:CGRectMake(0, scrollOffsetY, CGRectGetWidth(testImageView.frame), CGRectGetHeight(testImageView.frame))];
        [blurView setFrame:CGRectMake(0, scrollOffsetY, CGRectGetWidth(testImageView.frame), CGRectGetHeight(testImageView.frame))];
        [testTitle setFrame:CGRectMake(10, (self.view.frame.size.height-150)-(scrollOffsetY*0.8), CGRectGetWidth(testTitle.frame), CGRectGetHeight(testTitle.frame))];
        return;
    }
//
//    
    [testImageView setFrame:CGRectMake(0, (scrollOffsetY*0.3), CGRectGetWidth(testImageView.frame), CGRectGetHeight(testImageView.frame))];
    [blurView setFrame:CGRectMake(0, (scrollOffsetY*0.3), CGRectGetWidth(testImageView.frame), CGRectGetHeight(testImageView.frame))];
//    [testTitle setFrame:CGRectMake(10, (self.view.frame.size.height-150)-(scrollOffsetY*1), CGRectGetWidth(testTitle.frame), CGRectGetHeight(testTitle.frame))];
    
    if (scrollOffsetY/self.view.frame.size.height*1.2 >= 0.4) {
        
        [blurView setAlpha:scrollOffsetY/self.view.frame.size.height*1.2];
    }
//    NSLog(@"%f",scrollOffsetY);
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{
    return true;
}

@end
