//
//  NanpaaAboutController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/23.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "NanpaaAboutController.h"
#import <WebKit/WebKit.h>
@interface NanpaaAboutController ()<WKNavigationDelegate,WKUIDelegate>

@end

@implementation NanpaaAboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([_strDj isEqualToString:UserAgreementUrl]) {
        self.titleLabel.text = @"Privacy policy";
    }else {
        self.titleLabel.text = @"Term of service";
    }
    
    // Do any additional setup after loading the view.
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_strDj]]];
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    [self.view addSubview:webView];
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {

}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {}

@end
