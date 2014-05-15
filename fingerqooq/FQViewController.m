//
//  FQViewController.m
//  fingerqooq
//
//  Created by 이상진 on 2014. 5. 13..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "FQViewController.h"


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
    

    [mainScrollView setDelegate:self];
    [mainScrollView setContentSize:CGSizeMake(320*3, VIEW_HEIGHT)];
    [mainScrollView setScrollEnabled:YES];
    [mainScrollView setContentOffset:CGPointMake(320, 0) animated:false];
    [mainScrollView setBounces:false];
    
    
    contentsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320*3, VIEW_HEIGHT)];
    [contentsView setBackgroundColor:[UIColor colorWithRed:233/255.0 green:234/255.0 blue:237/255.0 alpha:1]];
    
    [mainScrollView addSubview:contentsView];
    
    
    //////////첫번째 아티클 시작/////////////////////
    
    CGRect firstArticleFrame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    
    
    NSString *htmlString1 = @"<p>“아아, 마치 죄인이 된 듯한 심정입니다.”</p>     <p>전화가 어렵게 연결됐다. 수화기 너머로 벨소리가 10번도 넘게 이어졌다. 아직 통화는 어렵겠지. 포기하고 그만 전화기의 종료 단추를 누르려는 순간, 그가 다급한 목소리로 전화를 받았다. 하긴, 결과가 궁금한 게 어디 나뿐일까. 분명 여기저기에서 걸려오는 숱한 전화에 시달렸을 게다.</p>     <p>‘죄인’. 두 글자가 헌법재판소의 결정만큼이나 가슴에 깊이 꽂혔다. 차마 봄기운이 다 퍼지지도 않은 4월의 하늘을 넘어온 전파가 건네준 그의 첫 마디였다. 참담함과 허탈함. 전화 통화일 뿐인데도 그 심정이 남김없이 묻어났다. 어찌 된 것인가요? 라며 더는 추궁할 수 없었다. 다음에 보자며 기약 없는 약속을 내뱉고 그대로 전화를 끊었다. 4월24일, 헌법재판소가 ‘강제적 셧다운제’에 합헌 결정을 내린 바로 그 날, 이병찬 법무법인정진 변호사와의 통하는 그렇게 짧게 끝났다.</p>         <p>이병찬 변호사를 처음 만난 것은 지난 2011년 초였다. 햇수로만 벌써 4년이 흘렀다. 그때 국회 안팎에서는 셧다운제 도입으로 잡음이 심했다. 셧다운제를 도입해서는 안 된다는 얘기를 하는 이들은 이병찬 변호사 주위로 몰렸다. 이병찬 변호사도 반대 견해를 분명히 했던 이들 중 하나다. 셧다운제가 뭔지, 셧다운제가 왜 청소년의 권리를 제한하는 규제인 것인지. 게임과 정부 정책을 아우를 수 있는 전문가를 만나는 것이 어렵던 당시, 이병찬 변호사는 이른바 가장 좋은 ‘취재원’이었다.</p>     <p>일만 생기면 이병찬 변호사부터 찾았다. 셧다운제 반대 토론회나 세미나에 자주 얼굴을 내비쳤다. TV 토론회나 라디오에서도 이병찬 변호사는 셧다운제를 도입해야 한다는 이들과 맞섰다. 2011년 4월29일, 셧다운제가 국회 본회의를 통과했다. 이병찬 변호사가 셧다운제에 위헌소송을 준비한 것은 그 이후부터다. 지난 4월 헌법재판소의 셧다운제 합헌 판결은 셧다운제 위헌소송의 결말이자 이병찬 변호사의 노력에 대한 사회의 답변인 셈이다. 패잔병이 더이상 무슨 할 말이 있겠느냐며 저어하는 그의 어깨를 잡고, 어렵게 돌려세웠다. 당신이 왜 죄인입니까. 사회를 구성하고 있는 우리 모두의 잘못입니다.</p>     <p>“아이를 불행하게 만드는 것은 게임이 아니라는 것을 제 스스로의 경험으로 너무 잘 알아요. 학부모단체나 찬성하는 이들의 얘기를 들어보면 아이들이 게임 때문에 잠도 못 자고, 공부도 못 하고, 생활이 파괴되고 있다, 뭐 이렇게 얘기하는데, 나도 게임을 하며 살아왔기 때문에 게임을 스스로 통제하는 방법을 익히는 데 시간이 걸릴 뿐이지 진짜 원인은 과도한 입시 스트레스 때문이라고 확신하고 있었던 거죠.”</p>     <p>4년 전, 이병찬 변호사는 어쩌다 셧다운제와 연을 맺게 됐을까. 2010년 말, 그는 잘 다니던 대기업의 법무팀을 나왔다. 기업이 아닌 사회에 보탬이 되는 변호사를 꿈꿨다. 약간의 자유를 손에 쥐고, 게임 쪽으로 슬쩍 발길을 돌릴 수 있었다. 원래 게임을 좋아한 성격 덕분이다. 게임 전문 웹진 게임메카에 e메일을 썼다. 게임 개발자나 게임을 좋아하는 이들을 위해 ‘법과 게임’을 주제로 담은 칼럼이 그렇게 시작됐다.</p>     <p>시기가 적절했다. 2010년 말부터 셧다운제 논의가 급물살을 탔다. 이병찬 변호사는 당시 칼럼에서 셧다운제는 위헌적 소지가 크다고 주장했다. 셧다운제는 당시 사회의 뜨거운 감자였다. MBC ’100분 토론’에서도 셧다운제가 논의될 정도였다. 여러 토론 프로그램에 불려다녔다. 여러 기자로부터 인터뷰 요청이 왔다. 자기가 셧다운제 위헌소송을 진행하게 되리라는 것을 당시의 그는 모르고 있었다.</p>     <p>“너무 크고 중대한 사안이라 혼자서 할 수 있을까, 이런 생각을 많이 했어요. 기업 법률자문만 하던, 이제 막 개업한 변호사가 하기에는 너무 어려운 일이 아닐까. 그런데 어느 순간 제가 아니면 안 될 것 같은 분위기가 됐더라고요.”(웃음)</p>     <p>워낙에 전문가가 없었던 탓이다. 사회에 여론은 들끓었지만, 그와 비례하게 전문가로부터 관심을 받은 사안은 아니었다. 주제가 게임인 탓이다. 게임은 언제나 우리 사회에서 하위문화일 뿐이니까. 이병찬 변호사는 청소년 두 명과 학부모 한 명과 함께 2011년 10월28일 헌법재판소에 셧다운제 헌법소원 청구서를 제출했다.</p>         <p>혹시 그는 결말을 예상하고 있었을까. 4년 뒤 셧다운제에 합헌 결정이 나오리라는 것을 말이다. 오히려 위헌 결정을 받을 것이라고 기대하는 목소리가 컸다. 셧다운제를 반대하는 이들의 주장대로 셧다운제는 청소년이 자유롭게 즐길 권리를 제한하는 규제였으며, 자녀를 양육하는 가정의 고유한 권한에 국가가 개입하는 조처가 아닌가. 당연히 위헌 결정이 나올 것으로 생각한 이들은 그래서 이번 헌법재판소의 판결에 더 충격이 컸을 지도 모른다.</p>     <p>“만약 결말을 예상했더라도 싸울 수밖에 없었어요. 이길 수 있어서 싸웠다기보다는 분명 싸울 가치가 있는 싸움이었으니까.”</p>    <p>게임을 넘어서는 그 무언가에 관한 ‘가치’가 셧다운제 헌법소원에 있었다는 설명이다. 우리 사회 기저에 깔린 게임은 해로운 매체라는 인식. 건강을 위해서라면 국가가 나서서 청소년을 훈육해도 좋다는 후견주의적 관점. 그리고 셧다운제와 셧다운제 위헌 소송이 불러올 이러한 논의에 관한 사회적인 관심들. 이병찬 변호사는 셧다운제 위헌 소송이 우리 사회에 이같은 문제에 대한 폭넓은 논의를 불러오길 바랐다.</p>     <p>“사회가 성숙할수록 그런 논의가 진지하게 고민될 수 있지 않을까, 이런 기대가 있었던 것도 사실이고요. 안타까운 것은 헌법소원이 진행되는 과정에서도 그런 논의가 제대로 이루어지지 않은 것 같아요.”</p>     <p>말하자면, 셧다운제는 사회의 표상이다. 사회가 게임을 대하는 인식이 어떠한가를 보여주는 상징물이다. 실제로 셧다운제 때문에 심야 시간에 게임을 즐기지 못하는 청소년이 그리 많지 않다고 하더라도, 셧다운제가 게임 서비스 업체의 매출에 그리 큰 타격을 주는 것은 아니라고 하더라도 셧다운제에 반대 목소리를 높인 이들은 게임에 편견을 더하는 상징적인 셧다운제를 그냥 두고 볼 수 없었던 것이다.</p>     <p>셧다운제 위헌 소송이 진행되는 4년 동안 게임과 중독에 관한 의학적인 연구 결과가 나오지 않았다. 게임이 과연 ‘중독물질’인지, 게임이 정말 청소년의 건강에 유해한 영향을 끼치는지에 관한 과학적인 연구도 진행된 바 없다. 셧다운제 위헌 소송이 진행되는 사이에도 게임에 관한 사회적 논의는 정지된 상태 그대로를 유지했을 뿐이다. 결국 셧다운제 위헌소송은 우리 사회가 가진 편견의 벽을 넘지 못했다.</p>     <p>“게임에 대한 편견을 뛰어넘으려면, 부모가 직접 게임을 해봐야 한다고 봐요. 아이가 좋아하는 게임이 뭐고, 그 게임이 어떤 게임인가에 대해 이해하고 있으면 아이가 게임을 하는 방식이나 시간을 부모가 통제할 수 있겠죠. 아이들은 아빠가 왜 술을 먹고 늦게 집에 오는지 잘 모르잖아요. 아빠가 주말에 왜 잠만 자야 하는지 잘 몰라요. 아이가 직장인이 돼야 알 수 있는 것처럼 말이죠.”</p>     <p>아마 이 문제는 시간이 해결해주지 않을까. 시간이 약이라는 말만큼 무력한 말도 찾기 어렵지만 결국, 다시 결론은 시간으로 돌아왔다. 지금 게임을 즐기는 이들이 부모가 되고, 게임에 대한 이해도가 상대적으로 높은 이들이 자녀의 교육을 담당하게 될 때. 아마 그때는 게임을 보는 시선이 지금보다 한결 부드러워지지 않을런지.</p>";
    
    FQTextView *firstArticle = [[FQTextView alloc]initWithFrame:firstArticleFrame titleString:@"“지난 4년, 셧다운제가 아니라 편견과 싸웠습니다.”" titleImage:[UIImage imageNamed:@"background.jpg"] contentsString:htmlString1];
    
    [firstArticle initHighlightMenu];
    [contentsViews addObject:firstArticle];
    [contentsView addSubview:firstArticle];
    
    //////////첫번째 아티클 끝/////////////////////
    
    

    //////////두번째 아티클 시작/////////////////////
    
    CGRect secondArticleFrame = CGRectMake(320*1, 0, 320, self.view.frame.size.height);
    
    
    NSString *htmlString2 = @"<div class=\"entry-content\">    <blockquote><p>‘흥신소’는 돈을 받고 남의 뒤를 밟는 일을 주로 합니다. ‘네가 못 하는 일, 내가 대신 해 주겠다’는 뜻이죠. ‘블로터 흥신소’는 독자 여러분의 질문을 받고, 궁금한 점을 대신 알아봐 드리겠습니다. IT에 관한 질문이면 아낌없이 던져주세요. 알아봐 드리겠습니다. e메일(sideway@bloter.net), 페이스북(http://www.facebook.com/Bloter.net), 트위터(@bloter_news) 모두 좋습니다. ‘블로터 흥신소’는 언제나 영업 중입니다.</p></blockquote>                                                                                                                                                                                                      <blockquote><p>“내 구글 계정 가족에게 물려줄 수 있나요?” – 블로터닷넷 최호섭</p></blockquote>                                                                                                                                                                                                      <p>흥신소는 의뢰를 받아야 하는데 제가 궁금한 점이 생겨서 좀 알아봤습니다. 무거운 주제를 이야기하려고 합니다. 바로 ‘죽음’입니다. 어떻게 보면 우리는 쉽게 죽음을 이야기합니다. ‘힘들어 죽겠다’. ‘배고파 죽겠다’처럼 과장된 표현들을 일상 생활에서 별뜻없이 씁니다. 아마 이런 농담을 웃으면서 할 수 있는 것도 생각해보면 ‘죽음은 남의 이야기’이라는 생각 때문일지도 모르겠습니다.</p>                                                                                                                                                                                                      <p>하지만 살다보면 재난이나 사고처럼 예측하지 못한 일들이 벌어집니다. 누구에게나 위험은 찾아옵니다. 그 상황에서 스마트폰의 정보는 중요한 정보가 되기도 합니다. 벌써 한 달 가까이 온 국민을 안타깝게 한 세월호 사고에서도 카카오톡 메시지가 중요한 증거가 됐고, 혹시 모를 사진이나 영상 정보가 네이버 N드라이브 같은 클라우드에 담겨 있지 않을까 하는 이야기도 나옵니다. 하지만 다른 한편으로 개인의 사생활이 모두 기록되는 디지털 정보가 낱낱이 공개되는 것도 덥석 받아들이기는 쉽지 않은 일입니다. 디지털 유산, 어떻게 받아들여야 하고 어디까지 물려줄 수 있는 것일까요?</p>                                                                                                                                                                                                      <p><a href=\"http://www.bloter.net/wp-content/uploads/2013/03/appstore.jpg\" rel=\"lightbox[192164]\" title=\"(-.-)a “구글 계정도 가족에게 물려줄 수 있나요?\" \"=\"\" class=\"cboxElement\"><img class=\"aligncenter size-full wp-image-146393\" alt=\"appstore\" src=\"http://www.bloter.net/wp-content/uploads/2013/03/appstore.jpg\" width=\"310\" height=\"300\"></a></p>                                                                                                                                                                                                      <p><strong>디지털 유품의 가치와 사생활</strong></p>                                                                                                                                                                                                      <p>제 스스로도 적지 않은 유료 앱과 콘텐츠를 구입하고 있습니다. 똑같은 재화를 종이책으로, CD로, 설치본이 담긴 디스크로 구입했더라면 그저 타인에게 넘겨주면 되겠지요. 하지만 내 모든 정보가 들어 있는 계정에 구매 내역과 권한이 기록되기 때문에 아무리 가족이라고 해도 아이디와 비밀번호를 선뜻 넘겨주는 건 쉽지 않습니다. 구매 내역만 넘겨줄 수는 없을까요?</p>                                                                                                                                                                                                      <p>얼마 전 영국에서도 사망한 어머니가 남긴 아이패드의 핀번호를 몰라 기기를 쓸 수 없게 된 한 이용자 사례가 소개됐습니다. 상속 절차가 까다롭기도 하거니와 법적 절차에 따른 비용이 들 수도 있습니다.</p>                                                                                                                                                                                                      <p>고인에게도 명백한 사생활이 있고, 죽어서도 누군가에게, 특히 가족에게 보이고 싶지 않은 이야기들을 갖고 있을 수 있습니다. 이를 가족이라는 이유로 무조건 넘겨주는 것도 문제겠지요. 상속이 안 된다면 문제지만 사생활이 담긴 계정 정보를 넘겨주는 것은 까다롭게 할 필요가 충분합니다. 요즘 특히나 강조되는 ‘잊혀질 권리’와 연결지을 수도 있겠습니다.</p>                                                                                                                                                                                                      <p><a href=\"http://www.bloter.net/wp-content/uploads/2011/12/Gmail_iOS_20111216.jpg\" rel=\"lightbox[192164]\" title=\"(-.-)a “구글 계정도 가족에게 물려줄 수 있나요?\" \"=\"\" c2ass=\"cboxElement\"><img class=\"aligncenter size-full wp-image-88007\" alt=\"Gmail_iOS_20111216\" src=\"http://www.bloter.net/wp-content/uploads/2011/12/Gmail_iOS_20111216.jpg\" width=\"310\" height=\"375\"></a></p>                                                                                                                                                                                                      <p>유족이 고인의 디지털 정보를 얻는 건 꽤 제한적입니다. 특히 정보통신망법에 의해 국내 사업자들은 특정인의 계정 정보를 타인에게 넘겨주는 것을 매우 조심스러워합니다. 실제로 해외에서는 사후 디지털 정보를 싹 지워주는 ‘디지털 장의사’라는 새로운 비즈니스가 생겨나기도 했습니다. 망자 스스로가 남기고 싶은 것, 물려주고 싶은 것, 지우고 싶은 것에 대한 권리를 줄 필요가 있지만 아직 사회적으로 심각한 논의는 이뤄지지 않는 듯합니다.</p>                                                                                                                                                                                                      <p>일단 사후 계정의 인계는 둘로 나눠볼 수 있습니다. 우선 계정 접근 자체에 대한 권한입니다. e메일, SNS, 블로그, 홈페이지 등의 내용을 가족이 물려받아 쓸 수 있는 것인지에 대한 이야기입니다. 사망한 가족의 페이스북, 트위터, 미니홈피 등을 상속할 수 있냐는 것이지요.</p>                                                                                                                                                                                                      <p>다른 하나는 특정 계정으로 구입한 무형의 재산, 즉 앱이나 음악, 영상 등의 콘텐츠를 상속할 수 있느냐입니다. 애플의 아이튠즈 계정, 구글의 G메일 계정이 대표적인 예가 되겠지요. T스토어나 멜론도 예외는 아닙니다. 하나둘 모은 앱 뿐 아니라 전자책, 음악, 영상 등 콘텐츠들을 점차 현물 대신 가상 콘텐츠로 구입하다보니 그 양은 날로 늘어나는데, 나중에 그대로 사라진다고 생각하면 아쉽기 그지없습니다.</p>                                                                                                                                                                                                      <p><strong>구글·애플, 서류 갖추면 권리 이전</strong></p>                                                                                                                                                                                                      <p>일단 국내 서비스들은 계정을 넘겨주는 것을 매우 조심스러워합니다. 반면 해외, 특히 우리가 많이 쓰는 미국 기업 서비스들은 사망한 사용자의 계정을 합법적인 대리인에게 넘겨주는 문제를 고민하고 있습니다. 다만 절차는 필요합니다. 계정 소유권을 넘기는 행위이기 때문이지요.</p>                                                                                                                                                                                                      <p>우리가 가장 많이 쓰는 구글과 애플의 계정은 가족이 물려받을 수 있습니다. 구글의 경우에는 이름, 주소, e메일 주소, 신분증, 사망증명서 그리고 사망자가 신청자에게 e메일을 보낸 헤더 정보가 필요합니다. 관계가 있는 가족이라는 증명인 셈이지요. 사망증명서는 사망진단서일 텐데 영문으로 발급되지 않으면 번역전문가가 직접 번역하고 공증한 번역본이 필요합니다. 모든 것을 클라우드와 웹에서 처리하길 좋아하는 구글이지만, 이 서류들은 우편이나 팩스 등으로 보내야 합니다.</p>                                                                                                                                                                                                      <p>구글에 메일을 보내기만 하면 모든 게 해결되는 건 아닙니다. 법적 검토 절차가 필요합니다. 아무래도 상속권자라는 증명과 당사자의 상속 정보 등을 함께 제시하면 이 단계가 수월할 겁니다.</p>                                                                                                                                                                                                      <p>구글은 독특한 서비스가 하나 더 있습니다. ‘휴면 계정 관리자’입니다. 일정 기간 동안 계정을 쓰지 않으면 계정에 연결된 또 다른 계정으로 구글 서비스의 일부를 접근할 수 있습니다. e메일, 드라이브, 구글플러스, 블로그, 유튜브, 피카사 등에 담긴 데이터를 내려받을 수 있도록 특정 계정에 권한이 부여됩니다. 이렇게 권한을 이어받은 이는 필요에 따라 본 계정을 삭제할 수 있는 권한도 갖게 됩니다. 잊혀질 권리도 부여하는 것이지요.&nbsp;뜻하지 않은 사고나 실종 등 갑작스러운 일을 당했을 때 누군가에게 내 계정 정보를 미리 접근하도록 한 것입니다. 휴면 계정의 판단은 계정에 직접 접속하는 것 뿐 아니라 스마트폰 사용정보, 안드로이드 체크인 등 다양한 방법으로 아예 접근하지 않을 때 작동합니다.</p>";
    
    FQTextView *secondArticle = [[FQTextView alloc]initWithFrame:secondArticleFrame titleString:@"(-.-)a “구글 계정도 가족에게 물려줄 수 있나요?”" titleImage:[UIImage imageNamed:@"titleImage1.jpg"] contentsString:htmlString2];
    //    [secondArticle setTitleString:@"test"];
    
    [contentsViews addObject:secondArticle];
    [contentsView addSubview:secondArticle];
    
    //////////두 번째 아티클 끝/////////////////////
    
    
    
    
    //////////두번째 아티클 시작/////////////////////
    
    CGRect thirdArticleFrame = CGRectMake(320*2, 0, 320, self.view.frame.size.height);
    
    
    NSString *htmlString3 = @"<div class=\"entry-content\">    <p>호로로로로로로로ㅗ로로로로ㅗ로로로로로로로로ㅗ로로롤</p>";
    
    FQTextView *thirdArticle = [[FQTextView alloc]initWithFrame:thirdArticleFrame titleString:@"3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333" titleImage:[UIImage imageNamed:@"titleImage2.jpg"] contentsString:htmlString3];
    //    [secondArticle setTitleString:@"test"];
    
    [contentsViews addObject:thirdArticle];
    [contentsView addSubview:thirdArticle];
    
    //////////세 번째 아티클 끝/////////////////////
    
    
    touchableView = [[UIView alloc]initWithFrame:self.view.bounds];
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
    for(int i = 0; i < 3; i++) {
        FQTextView * view = contentsViews[i];
        [view setFrame:CGRectMake(self.view.bounds.size.width*i, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    }
}

@end
