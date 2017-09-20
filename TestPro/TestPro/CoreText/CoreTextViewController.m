//
//  CoreTextViewController.m
//  iOSPro
//
//  Created by 王颂阳 on 2017/8/14.
//  Copyright © 2017年 王颂阳. All rights reserved.
//

#import "CoreTextViewController.h"
#import <CoreText/CoreText.h>
#import "DrawRectViewController.h"
#import "SYAlertView.h"
#import "SYOpenCountProtocolView.h"
#import "StoryViewController.h"

@interface CoreTextViewController ()<SYOpenCountProtocolViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *ShowContentLabel;
@end

@implementation CoreTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hidesBottomBarWhenPushed = NO;
    self.navigationItem.title = @"CoreText";
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

- (IBAction)firstButtonAction:(UIButton *)sender {
    
    NSMutableAttributedString *mabString = [[NSMutableAttributedString alloc] initWithString:@"This is a test of characterAttribute. 中文字符"];
    
    // 调大字体
    CTFontRef font = CTFontCreateWithName(CFSTR("Georgia"), 40, NULL);
    [mabString addAttribute:(id)kCTFontAttributeName value:(__bridge id)font range:NSMakeRange(0, 4)];
    self.ShowContentLabel.attributedText = mabString;
    
    DrawRectViewController *vc = [[DrawRectViewController alloc] init];
    vc.jz_wantsNavigationBarVisible = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)secondButtonAction:(UIButton *)sender {
    
    // 设置斜体字
    NSMutableAttributedString *mabString = [[NSMutableAttributedString alloc] initWithString:@"This is a test of characterAttribute. 中文字符"];
    CTFontRef font = CTFontCreateWithName((CFStringRef)[UIFont italicSystemFontOfSize:20].fontName, 14, NULL);
    [mabString addAttribute:(id)kCTFontAttributeName value:(__bridge id)font range:NSMakeRange(0, mabString.length - 1)];
    
    self.ShowContentLabel.attributedText = mabString;
    
    SYOpenCountProtocolView *view = [[SYOpenCountProtocolView alloc] init];
    view.backgroundColor = [UIColor redColor];
    view.delegate = self;
    SYAlertView *alert = [[SYAlertView alloc] initAlertWithSubView:view];
    [alert addButton:@"确定" actionHandler:^{
        
    }];
    alert.grayBgCanResponse = YES;
    [alert show];
}

- (IBAction)thirdButtonAction:(UIButton *)sender {
    
    NSMutableAttributedString *mabString = [[NSMutableAttributedString alloc] initWithString:@"This is a test of characterAttribute. 中文字符"];

    // 设置字符间隔
    long number = 10;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
    [mabString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(3, 10)];
    self.ShowContentLabel.attributedText = mabString;
    
    float aFloat;
    NSString *aString = @"2.342dd4342.234dsd234.2342sd342.2344sd234s";
    NSScanner *scanner = [NSScanner scannerWithString:aString];
    while ([scanner scanCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:NULL]) {
    
        [scanner scanFloat:&aFloat];
        NSLog(@"====>>%f",aFloat);
    }
//    [scanner scanCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:NULL];
    
    float nextFloat;
    // 遇到非float字符即停止
    [scanner scanFloat:&nextFloat];
    NSLog(@"====>>%f",nextFloat);
    
    NSDictionary *cookDic = @{NSHTTPCookieName:@"CookName",
                              NSHTTPCookieValue:@"这是一个CookValue",
                              NSHTTPCookieDomain:@"CookDomain",
                              NSHTTPCookiePath:@"/"};
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookDic];
    // 如果当前CookieStorage中存在于CookDic相同的Name、Domain、Path，则原来的则被替换掉
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    
    NSDictionary *cookDicTwo = @{NSHTTPCookieName:@"CookNameTwo",
                              NSHTTPCookieValue:@"这是一个CookValue",
                              NSHTTPCookieDomain:@"CookDomain",
                              NSHTTPCookiePath:@"/"};
    NSHTTPCookie *cookieTwo = [NSHTTPCookie cookieWithProperties:cookDicTwo];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieTwo];
    
    NSDictionary *cookDicThree = @{NSHTTPCookieName:@"CookName",
                              NSHTTPCookieValue:@"这是一个CookValue",
                              NSHTTPCookieDomain:@"CookDomain",
                              NSHTTPCookiePath:@"/"};
    NSHTTPCookie *cookieThree = [NSHTTPCookie cookieWithProperties:cookDicThree];
    // 如果当前CookieStorage中存在于CookDic相同的Name、Domain、Path，则原来的则被替换掉
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieThree];
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
