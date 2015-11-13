//
//  LiteraryDetailViewController.m
//  ProjectAlpha
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 com.sunshuaiqi. All rights reserved.
//

#import "LiteraryDetailViewController.h"

#define kLiteraryDetailUrl(ID) [NSString stringWithFormat:@"http://apiv3.pento.cn/api/pin/content/%ld/show.json?token=Kx2S9nE0iHgbbSbeDdh2",ID]

#import <AVOSCloud.h>
#import "LoginViewController.h"
#import <SVProgressHUD.h>
#import "FavoriteModel.h"
#import "FavoriteHandle.h"
#import "ProjectAlpha-Swift.h"
@interface LiteraryDetailViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView * webView; // 网页视图
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView; // 进度轮
@property (nonatomic,strong) UIView *opaqueview; // 透明视图


@end

@implementation LiteraryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 返回按钮
    UIBarButtonItem * backBI = [[UIBarButtonItem alloc] initWithImage:[AlphaIcons imageOfBackArrowWithFrame:CGRectMake(0, 0, 30, 30)] style:UIBarButtonItemStylePlain target:self action:@selector(didClickBackBI)];
    backBI.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backBI;
    
    
    // 收藏按钮
    UIBarButtonItem * favoriteBI = [[UIBarButtonItem alloc] initWithImage:[AlphaIcons imageOfFavoriteModernizedWithFrame:CGRectMake(0, 0, 25, 25)] style:UIBarButtonItemStylePlain target:self action:@selector(didClickFavorite)];
     favoriteBI.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = favoriteBI;
    
    //把favorhandle的isViaClickFavorite置为NO(判断是否是从收藏页面到登录页的)
    [FavoriteHandle sharedHandle].isViaClickFavorite = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:@"userLogIn" object:nil];
    
    [self addSubViews];
    [self parseData];
    
}

#pragma mark --- 返回事件
- (void)didClickBackBI
{

    [self.navigationController popViewControllerAnimated:YES];
    
}


//登陆成功执行的方法
- (void)loginSuccess:(NSNotification *)notification
{
    if ([FavoriteHandle sharedHandle].isViaClickFavorite == YES) {
        
        [self didClickFavorite];
    }
}


#pragma mark -- 收藏事件
- (void)didClickFavorite
{
    // 用户已经登录直接收藏
    if ([AVUser currentUser]) {
        NSMutableArray * modelArray = [NSMutableArray array];
        
        NSArray * array = [[FavoriteHandle sharedHandle] qureyData];
        for (FavoriteModel * model in array) {
            
            if ([model.ID integerValue]== self.ID) {
                
                [modelArray addObject:model];
                
                [SVProgressHUD showSuccessWithStatus:@"已经收藏过了" maskType:SVProgressHUDMaskTypeBlack];
                [FavoriteHandle sharedHandle].isViaClickFavorite = NO;
            }
        }
        
        if (modelArray.count==0) {
            [[FavoriteHandle sharedHandle] insertDataWithID:[NSString stringWithFormat:@"%ld",(long)self.ID] title:self.title imgUrl:self.imgUrl paragraph:nil];
            [SVProgressHUD showSuccessWithStatus:@"收藏成功" maskType:SVProgressHUDMaskTypeGradient];
            
            [FavoriteHandle sharedHandle].isViaClickFavorite = NO;
        }
        

    }else {
        
        // 未登录先登录后收藏
        UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"温情提示" message:@"亲，登录后才能收藏哦" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            // 登录
            LoginViewController * loginVC = [LoginViewController new];
            [self.navigationController pushViewController:loginVC animated:YES];
            
        }];
        [alter addAction:action1];
        [alter addAction:action2];
        [self presentViewController:alter animated:YES completion:nil];
        

       [FavoriteHandle sharedHandle].isViaClickFavorite = YES;
       
    }

}

#pragma mark -- 添加控件
- (void)addSubViews
{
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    
    // 让网页自己适配
    self.webView.scalesPageToFit = YES;
    
    // 顶端禁止下拉
    self.webView.scrollView.bounces = NO;
    
    // 设置代理，用来执行网页加载完成代理方法（控制网页大小）
    self.webView.delegate = self;
    
    //是否支持交互
    [self.webView setUserInteractionEnabled:YES];
    
    //Opaque为不透明的意思，这里为透明
    [self.webView setOpaque:NO];
    
    // 添加网页
    [self.view addSubview:self.webView];
    
     _webView.backgroundColor = [UIColor whiteColor];
    if ([userDefaults boolForKey:@"isNightMode"]) {
        // 夜间模式的颜色
        _webView.backgroundColor = NightBackgroundColor;
       
    } else {
    
        if ([userDefaults colorForKey:@"light"]) {
        // 主题对应颜色
        _webView.backgroundColor = [userDefaults colorForKey:@"light"];
        
      }
        
    }
    //opaqueview 用以做UIActivityIndicatorView的容器view
    _opaqueview = [[UIView alloc] initWithFrame:self.view.frame];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    _activityIndicatorView.layer.masksToBounds = YES;
    _activityIndicatorView.layer.cornerRadius = 5;
    _activityIndicatorView.backgroundColor = [UIColor blackColor];
    [_activityIndicatorView setCenter:_opaqueview.center];
    
    //颜色根据不同的界面自己调整（进度轮样式）
    [_activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhiteLarge];
    
    [_opaqueview setBackgroundColor:[UIColor whiteColor]];
   
    if ([userDefaults boolForKey:@"isNightMode"]) {
        
        _opaqueview.backgroundColor = NightBackgroundColor;
        
    } else {
        
        if ([userDefaults colorForKey:@"light"]) {
            
          _opaqueview.backgroundColor = [userDefaults colorForKey:@"light"];
        }
        
    }
    
    [self.view  addSubview:_opaqueview];
    [_opaqueview addSubview:_activityIndicatorView];
    
    
}

#pragma mark -- 解析数据
- (void)parseData
{
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:kLiteraryDetailUrl(self.ID) parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        // 得到json串
        NSDictionary * dataDic = responseObject;
        NSString * string = dataDic[@"data"];
        
    
        // 加载HTML格式内容
        [self.webView loadHTMLString:string baseURL:nil];
        
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];


}

#pragma mark --- 禁用超链接
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        return NO;
    }
    
    return YES;
}

//当网页视图已经开始加载一个请求之后得到通知

- (void) webViewDidStartLoad:(UIWebView  *)webView {
    [_activityIndicatorView startAnimating]; // 风火轮开始动画
    _opaqueview.hidden = NO;
   
}


//网页加载完毕代理
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [_activityIndicatorView stopAnimating]; //停止风火轮
    _opaqueview.hidden = YES; //隐藏
    
    // 设置图片大小
    [webView stringByEvaluatingJavaScriptFromString:
                 @"var script = document.createElement('script');"
                 "script.type = 'text/javascript';"
                 "script.text = \"function ResizeImages() { "
                 "var myimg,oldwidth;"
                 "var maxwidth = 600.0;" 
                 "for(i=0;i <document.images.length;i++){"
                 "myimg = document.images[i];"
                 "if(myimg.width > maxwidth){"
                 "oldwidth = myimg.width;"
                 "myimg.width = maxwidth;"
                 "}"
                 "}"
                 "}\";"
                 "document.getElementsByTagName('head')[0].appendChild(script);"];
    
    
    //添加调用JS执行的语句
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];

    
    // 设置字体颜色
    if ([userDefaults boolForKey:@"isNightMode"]) {
        
       [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor = 'gray'"];
    }else {
    
     [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor = 'black'"];
    
    }
    
    
    
    // 设置字体
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '280%'"];
    
    
   // padding 左右留白
    [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.padding='0px 44px 0px 44px';"];
    
    // 设置内容居中显示
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.verticalAlign = 'middle';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.textAlign = 'center';"];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
