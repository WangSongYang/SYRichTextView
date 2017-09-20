//
//  DrawRectViewController.m
//  iOSPro
//
//  Created by 王颂阳 on 2017/8/14.
//  Copyright © 2017年 王颂阳. All rights reserved.
//

#import "DrawRectViewController.h"
#import "ContenView.h"
#import "CoreTextViewController.h"
#import "StoryViewController.h"
#import "NSAttributedString+HHHeight.h"
#import <CoreText/CoreText.h>

static inline CGFLOAT_TYPE CGFloat_ceil(CGFLOAT_TYPE cgfloat) {
#if CGFLOAT_IS_DOUBLE
    return ceil(cgfloat);
#else
    return ceil(cgfloat);
#endif
    
}

@interface DrawRectViewController ()<UIGestureRecognizerDelegate>

/** ContentView */
@property (nonatomic,strong) ContenView *myView;

@end

@implementation DrawRectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.myView = [[ContenView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    self.myView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myView];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    NSLog(@"侧滑代理啊啊啊啊");

    return YES;
}

- (void)panGestureAction:(UIGestureRecognizer *)gesture {
    
    NSLog(@"侧滑啊啊啊");
    
}

- (IBAction)jumpToNext:(UIButton *)sender {
    
    StoryViewController *coreTextVC = [[StoryViewController alloc] init];
    [self.navigationController pushViewController:coreTextVC animated:YES];
}

+ (CGFloat)valuateCellHeightWithString:(NSAttributedString *)abuString {
    CGFloat heightValue = 0;
    //string 为要计算高的NSAttributedString
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)abuString);
    
    //这里的高要设置足够大
    CGFloat height = CGFLOAT_MAX;
    CGRect drawingRect = CGRectMake(0, 0, SCREEN_WIDTH - 100, height);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    CFArrayRef lines = CTFrameGetLines(textFrame);
    CGPoint lineOrigins[CFArrayGetCount(lines)];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), lineOrigins);
    /******************
     * 最后一行原点y坐标加最后一行下行行高跟行距
     ******************/
    heightValue = 0;
    CGFloat line_y = (CGFloat)lineOrigins[CFArrayGetCount(lines)-1].y;  //最后一行line的原点y坐标
    CGFloat lastAscent = 0;//上行行高
    CGFloat lastDescent = 0;//下行行高
    CGFloat lastLeading = 0;//行距
    CTLineRef lastLine = CFArrayGetValueAtIndex(lines, CFArrayGetCount(lines)-1);
    CTLineGetTypographicBounds(lastLine, &lastAscent, &lastDescent, &lastLeading);
    //height - line_y为除去最后一行的字符原点以下的高度，descent + leading为最后一行不包括上行行高的字符高度
    heightValue = height - line_y + (CGFloat)(fabs(lastDescent) + lastLeading);
    heightValue = CGFloat_ceil(heightValue);
    
    return heightValue;
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
