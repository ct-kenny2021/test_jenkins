//
//  ViewController.m
//  TestSupportEnvDemo
//
//  Created by chenting on 2021/6/29.
//

#import "ViewController.h"
#import "Utils.h"

@interface ViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UIButton *btn2;
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.label];
    [self.view addSubview:self.btn];
    [self.view addSubview:self.btn2];
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://wifiboilers1.rinnai.co.kr:9105/notice/noticeList_iphone.jsp"]]];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *s = request.URL.absoluteString;
    NSLog(@"shouldStartLoadWithRequest-->%@",s);
    return YES;
}

-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        _webView.delegate = self;
    }
    return _webView;
}

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 40)];
        _label.text = @"test env";
        _label.font = [UIFont systemFontOfSize:22.];
        _label.textColor = [UIColor blueColor];
    }
    return _label;
}

//145  57   290 114
//        293  57

-(UIButton *)btn{
//    293*2
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(50, 100, 293, 57);
//        [_btn setImage:[UIImage imageNamed:@"btn_heating_on"] forState:UIControlStateNormal];
//        [_btn setImage:[Utils resizaImg:[UIImage imageNamed:@"btn_heating_on"] withImgSize:CGSizeMake(293, 57) anonFrame:CGRectMake(50, 100, 293, 57)] forState:UIControlStateNormal];
        UIImage *image = [self dc_stretchLeftAndRightWithContainerSize:CGSizeMake(293, 57) baseImage:[UIImage imageNamed:@"btn_heating_on"]];
        [_btn setImage:image forState:UIControlStateNormal];
    }
    return _btn;
}


-(UIButton *)btn2{
    if (!_btn2) {
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn2.frame = CGRectMake(50, 300, 145, 57);
        [_btn2 setImage:[UIImage imageNamed:@"btn_heating_on"] forState:UIControlStateNormal];
    }
    return _btn2;
}


- (UIImage *)dc_stretchLeftAndRightWithContainerSize:(CGSize)size baseImage:(UIImage *)baseImage
{
    // 248 中间图片的宽  273 中间图片的高
    
//    145  57
    
    CGFloat top = (baseImage.size.height - 70)/2;
    CGFloat left = (baseImage.size.width - 40)/2;
    
    CGSize imageSize = baseImage.size;
    CGSize bgSize = size;
    
    //1.第一次拉伸下面 保护上面
   
    UIImage *image = [baseImage stretchableImageWithLeftCapWidth:left+40 topCapHeight:top+70];
    
    //第一次拉伸的距离之后图片总宽度
    CGFloat tempWidth = (bgSize.width)/2 + imageSize.width/2;
    CGFloat tempHeight = (bgSize.height)/2 + imageSize.height/2;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(image.size.width, tempHeight), NO, [UIScreen mainScreen].scale);
    
    [image drawInRect:CGRectMake(0, 0, tempWidth, tempHeight)];
    
    //拿到拉伸过的图片
    UIImage *firstStrechImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //2.第二次拉伸上面 保护下面
    
    UIImage *secondStrechImage = [firstStrechImage stretchableImageWithLeftCapWidth:left topCapHeight:top];
    
    return secondStrechImage;
}

@end
