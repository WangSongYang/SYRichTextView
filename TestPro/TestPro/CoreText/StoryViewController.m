//
//  StoryViewController.m
//  iOSPro
//
//  Created by 王颂阳 on 2017/8/18.
//  Copyright © 2017年 王颂阳. All rights reserved.
//

#import "StoryViewController.h"
#import "DrawRectViewController.h"
#import "SYDeclareDisplayView.h"
#import "SYFrameParser.h"
#import "SYFrameParserConfig.h"
#import "SYCoreTextData.h"

@interface StoryViewController ()<UIGestureRecognizerDelegate>

/** TV */
@property (nonatomic,strong) UITextView *storyTextView;
/** 导航栏是否隐藏 */
@property (nonatomic,assign) BOOL navBarIsHidden;

@end

@implementation StoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor orangeColor];
//    [self fillTextToTextView];
    NSMutableArray *controllerArray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    UIViewController *deletedVC = [controllerArray objectAtIndex:(self.navigationController.viewControllers.count - 2)];
    if ([deletedVC isMemberOfClass:[DrawRectViewController class]]) {
        [controllerArray removeObject:deletedVC];
        self.navigationController.viewControllers = controllerArray.copy;
    }
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    [self setUpSubViews];
}

- (void)setUpSubViews {
    
    SYDeclareDisplayView *view = [[SYDeclareDisplayView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 30)];
    view.backgroundColor = [UIColor redColor];
    NSString *displayText = @"我已经仔细阅读客户协议并理解及同意所有的交易条款和条件、订单执行政策、一般风险披露陈述、利益冲突政策、客户分类、投资者赔偿基金和隐私协议。我同意受该协议条款的约束，在Origin开设交易账户并注资完全属于本人的主动意愿。";
    SYFrameParserConfig *config = [[SYFrameParserConfig alloc] init];
    config.width = self.view.bounds.size.width;
    config.linkArray = @[@"隐私协议",@"风险披露",@"客户协议"];
    config.contentOffset = UIEdgeInsetsMake(10, 10, 10, 10);
    view.textData = [SYFrameParser parserNormalString:displayText attConfig:config];
    [self.view addSubview:view];
}

- (void)backAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)fillTextToTextView {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"story" ofType:@"txt"];
    NSString *normalString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSMutableAttributedString *atbString = [[NSMutableAttributedString alloc] initWithString:normalString];
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    [attribute setObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName];
    [attribute setObject:[UIColor colorWithHexString:@"333333"] forKey:NSForegroundColorAttributeName];
    [attribute setObject:[NSNumber numberWithInt:5] forKey:NSKernAttributeName];
    [atbString addAttributes:attribute range:NSMakeRange(0, atbString.length)];
    self.storyTextView.attributedText = atbString;
}

#pragma mark --- Getter ---
- (UITextView *)storyTextView {
    if (!_storyTextView) {
        _storyTextView = [[UITextView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _storyTextView.editable = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_storyTextView addGestureRecognizer:tap];
        [self.view addSubview:_storyTextView];
    }
    return _storyTextView;
}

#pragma makr --- TapGestureAction ---

- (void)tapAction:(UIGestureRecognizer*)tap {
    self.navBarIsHidden = !self.navBarIsHidden;
    [self.navigationController setNavigationBarHidden:self.navBarIsHidden animated:YES];
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
