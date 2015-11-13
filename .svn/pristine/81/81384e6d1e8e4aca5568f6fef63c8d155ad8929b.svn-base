//
//  QualityWebPageViewController.m
//  ProjectAlpha
//
//  Created by lanou3g on 11/11/15.
//  Copyright © 2015 com.sunshuaiqi. All rights reserved.
//

#import "QualityWebPageViewController.h"

@interface QualityWebPageViewController ()

@end

@implementation QualityWebPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://lp380490944.uboxi.com/blog/"]]];
    [self.view addSubview:webView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[AlphaIcons imageOfBackArrowWithFrame:CGRectMake(0, 0, 30, 30)] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}
- (void)backAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
