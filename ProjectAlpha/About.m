//
//  ViewController.m
//  ProjectAlpha
//
//  Created by Sunshuaiqi on 11/10/15.
//  Copyright © 2015 com.sunshuaiqi. All rights reserved.
//

#import "About.h"

@interface About ()

@end

@implementation About

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:scrollView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15 /375.0 * ScreenWidth,CGRectGetMaxY(self.navigationController.navigationBar.frame)+44 / 667.0 *ScreenHeight, CGRectGetWidth(self.view.frame)-30/375.0 * ScreenWidth,40 / 667.0 * ScreenHeight)];
    [scrollView addSubview:label];
    label.text = @"免责声明";
    label.textAlignment = NSTextAlignmentCenter;
    
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)* 1.3);
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.firstLineHeadIndent = 20 /375.0 *ScreenWidth;
    paragraphStyle.paragraphSpacing =  10 / 667.0 *ScreenHeight;
    paragraphStyle.lineSpacing = 5 / 667.0 *ScreenHeight;
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMinX(label.frame),CGRectGetMaxY(label.frame),CGRectGetWidth(label.frame), CGRectGetHeight(self.view.frame)- 88 / 667.0 *ScreenHeight)];
    [scrollView addSubview:textView];
    textView.textAlignment = NSTextAlignmentCenter;
    textView.attributedText = [[NSAttributedString alloc] initWithString: @"1.一切移动客户端用户在下载并浏览APP手机APP软件时均被视为已经仔细阅读本条款并完全同意。凡以任何方式登陆本应用，或直接、间接使用本应用资料者，均被视为自愿接受本网站相关声明和用户服务协议的约束。\n2. 简读APP应用（以下简称“本应用”）各个版块内容，来源于各媒体网站，本应用仅为用户提供链接和转码阅读，不涉及任何人工编辑和整理，也不对任何来源于第三方的内容承担责任，用户可选择去原处阅读原文内容。\n任何网站、单位或个人的网站内容若不想被本应用收录，您可及时通知我们，或者在您网站页面中明确加注拒绝收录的标记，否则，本应用将依照惯例将其收录。\n任何网站、单位或个人认为本应用涉嫌侵犯您的版权，您应该及时向我们提供书面权利通知（联系方式：492645926@qq.com），并提供身份证明、权属证明及侵权情况说明等投诉材料。我们将依法进行处理。\n\n\
                               简读APP研发团队" attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    textView.editable = NO;
    label.backgroundColor = [UIColor clearColor];
    textView.backgroundColor = [UIColor clearColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[AlphaIcons imageOfBackArrowWithFrame:CGRectMake(0, 0, 30, 30)] style:UIBarButtonItemStylePlain target:self action:@selector(dissMissAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}

- (void)dissMissAction{
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
