//
//  SYAlertView.m
//  RunTime
//
//  Created by 王颂阳 on 2017/5/22.
//  Copyright © 2017年 WSY. All rights reserved.
//

#import "SYAlertView.h"
#import "SYAlertButton.h"

#define kDefaultHeight 180
#define kDefaultWidth 300
#define SYScreenHeight [UIScreen mainScreen].bounds.size.height
#define SYScreenWidth [UIScreen mainScreen].bounds.size.width
#define ItemTextNormalColot [UIColor colorWithHexString:@"ffbe1a"]

@interface SYAlertView ()<UITextFieldDelegate,UIGestureRecognizerDelegate>

/** 按钮数组 */
@property (nonatomic,strong) NSMutableArray<SYAlertButton *> *buttonArray;

/** TF数组 */
@property (nonatomic,strong) NSMutableArray<UITextField *> *textFieldArray;

/** Label数组 */
@property (nonatomic,strong) NSMutableArray<UILabel *> *labelArray;

/** 内容承载 */
@property (nonatomic,strong) UIView *contentView;

/** ×按钮 */
@property (nonatomic,strong) UIButton *hideBtn;

/** Title */
@property (nonatomic,strong) UILabel *titleLabel;

/** Message */
@property (nonatomic,strong) UILabel *messageLabel;

/** ImageView */
@property (nonatomic,strong) UIImageView *titleImage;

/** alert Type */
@property (nonatomic,assign) SYAlertViewType alertType;

/** 输入完成回调 */
@property (nonatomic,copy) void (^inputCallBack)(NSString *inputString);

/** 消失回调 */
@property (nonatomic,copy) void (^hideCallBack)(BOOL isFinsh);

/** 按钮相应结束后的回调 */
@property (nonatomic,copy) void (^textfiledReturnKeyCompleter)(BOOL isFinsh);

/** 需要展示的自定义View */
@property (nonatomic,strong) UIView *showView;

@end

@implementation SYAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initAlertWithType:(SYAlertViewType)alertType {
    
    self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    if (self) {
        
        self.alertType = alertType;
        
        [self setUp];
        
        [self initSubViews];
        
        [self setUpUIWithAlertType:alertType];

    }
    return self;
}


- (instancetype)initAlertWithSubView:(UIView *)subView {
    
    self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    if (self) {
        
        [self setUp];
        
        [self initSubViews];
        
        [self setUpAlertWithSubView:subView];
    }
    return self;
}


- (void)setUp {
    
    self.buttonArray = [NSMutableArray new];
    
    self.textFieldArray = [NSMutableArray new];
    
    self.labelArray = [NSMutableArray new];
    
    self.grayBgCanResponse = NO;
}

- (void)initSubViews {
    
    self.tag = 3001;
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDefaultWidth, kDefaultHeight)];
    self.contentView.center = self.center;
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 10.0f;
    [self addSubview:self.contentView];
    
    self.hideBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.contentView.frame) - 35, 5, 30, 30)];
//    [self.hideBtn setTitle:@"X" forState:UIControlStateNormal];
//    [self.hideBtn setTitleColor:ItemTextNormalColot forState:UIControlStateNormal];
    [self.hideBtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    [self.hideBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.hideBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
}

- (void)tapGestureAction:(UITapGestureRecognizer *)sender {

    [self hideWithCompleteHandler:nil];
}

#pragma mark --- UIGestureRecognizerDelegate ---

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if (!self.grayBgCanResponse) {
        return NO;
    }
    NSArray *classNameArray = @[@"UITextView",@"UITableViewCellContentView",@"UIButton"];
    
    BOOL isContain = CGRectContainsPoint(self.contentView.frame, [touch locationInView:self]);
    if (isContain) {
        return NO;
    }
    
    if ([classNameArray containsObject:NSStringFromClass([touch.view class])]) {
        return NO;
    }
    
    return YES;
}

#pragma mark --- Setup UI ---

- (void)setUpUIWithAlertType:(SYAlertViewType)alertType {
    
    switch (alertType) {
        case SYAlertViewTypeMutableText:
            
            [self setUpMutableTextType];
            
            break;
        case SYAlertViewTypeImageAndSingleText:
            
            [self setUpImageAndSingleTextType];
            
            break;
        case SYAlertViewTypeImageAndMutableText:
            
            [self setUpImageAndMutableTextType];
            
            break;
        case SYAlertViewTypeinputText:
            
            [self setUpInputTextType];
            
            break;
        case SYAlertViewTypeSubView:
   
            break;
        default:
            break;
    }
}

// 多行文字
- (void)setUpMutableTextType {
    
    self.hideBtn.hidden = YES;
    
    self.contentView.frame = CGRectMake(0, 0, 300, 180);
    self.contentView.center = self.center;
    
    UILabel *firstLabel = [[UILabel alloc] init];
    firstLabel.font = KSystemFont(18);
    firstLabel.textColor = [UIColor colorWithHexString:@"333333"];
    firstLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:firstLabel];
    [self.labelArray addObject:firstLabel];
    
    UILabel *secondLabel = [[UILabel alloc] init];
    secondLabel.font = KSystemFont(18);
    secondLabel.textColor = [UIColor colorWithHexString:@"333333"];
    secondLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:secondLabel];
    [self.labelArray addObject:secondLabel];
    
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top).offset(48);
        make.height.equalTo(@20);
    }];
    
    [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(firstLabel.mas_bottom).offset(20);
        make.height.equalTo(@20);
    }];

}

// 图片+单行文字
- (void)setUpImageAndSingleTextType {
    
    self.hideBtn.hidden = YES;
    
    self.contentView.frame = CGRectMake(0, 0, kDefaultWidth, kDefaultHeight);
    self.contentView.center = self.center;
    
    self.titleImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.titleImage];
    
    UILabel *firstLabel = [[UILabel alloc] init];
    firstLabel.font = KSystemFont(17);
    firstLabel.textColor = [UIColor colorWithHexString:@"333333"];
    firstLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:firstLabel];
    [self.labelArray addObject:firstLabel];
    
    // 布局
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(24);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.titleImage.mas_bottom).offset(18);
        make.height.equalTo(@20);
    }];
}

// 图片+多行文字
- (void)setUpImageAndMutableTextType {
    
    self.hideBtn.hidden = YES;
    
    self.contentView.frame = CGRectMake(0, 0, kDefaultWidth, kDefaultHeight);
    self.contentView.center = self.center;
    
    self.titleImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.titleImage];
    
    UILabel *firstLabel = [[UILabel alloc] init];
    firstLabel.font = KSystemFont(18);
    firstLabel.textColor = [UIColor colorWithHexString:@"333333"];
    firstLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:firstLabel];
    [self.labelArray addObject:firstLabel];
    
    UILabel *secondLabel = [[UILabel alloc] init];
    secondLabel.font = KSystemFont(18);
    secondLabel.textColor = [UIColor colorWithHexString:@"333333"];
    secondLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:secondLabel];
    [self.labelArray addObject:secondLabel];
    
    
    // 布局
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(secondLabel.mas_top).offset(-8);
        make.height.equalTo(@18);
    }];
    
    [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-60);
        make.height.equalTo(@18);
    }];
}

// 输入框
- (void)setUpInputTextType {
    
    self.hideBtn.hidden = YES;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, CGRectGetWidth(self.contentView.frame), 24)];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.titleLabel.font = KSystemFont(20);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + 10, CGRectGetWidth(self.contentView.frame), 20)];
    self.messageLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.messageLabel.font = KSystemFont(15);
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.messageLabel];

}

// SubView
- (void)setUpAlertWithSubView:(UIView *)subView {
    
    self.showView = subView;
    
    self.hideBtn.hidden = YES;
    
    self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 50, 390);
    self.contentView.center = self.center;
    
    subView.frame = CGRectMake(0, 10, CGRectGetWidth(self.contentView.frame), 330);
    [self.contentView addSubview:subView];
}

#pragma mark --- Public Funcs ---

- (void)addButton:(NSString *)title actionHandler:(void (^)())actionHandler {
    
    [self addButton:title actionHandler:actionHandler afterCompleter:nil];
}

- (void)addButton:(NSString *)title actionHandler:(void (^)())actionHandler afterCompleter:(void (^)(BOOL))completeHander {
    
    SYAlertButton *button = [[SYAlertButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:ItemTextNormalColot forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    button.SYActionBlock = actionHandler;
    button.buttonActionCompleter = completeHander;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonArray addObject:button];
    [self.contentView addSubview:button];
    
    
    [self layoutButtons];
}

- (void)addTextField:(NSString *)placeHolder inputHandler:(void (^)(NSString *))inputHandler {
    
    [self addTextField:placeHolder inputHandler:inputHandler completeHandleder:nil];
}

- (void)addTextField:(NSString *)placeHolder inputHandler:(void (^)(NSString *))inputHandler completeHandleder:(void (^)(BOOL))completeHander {
    
    self.textfiledReturnKeyCompleter = completeHander;
    
    self.inputCallBack = inputHandler;

    UITextField *tf = [[UITextField alloc] init];
    tf.placeholder = placeHolder;
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.textColor = [UIColor blackColor];
    tf.delegate = self;
    tf.returnKeyType = UIReturnKeyDone;
    [self.contentView addSubview:tf];
    
    [self.textFieldArray addObject:tf];
    
    [self layoutTextField];
    
    [self addKeyboardNotification];
}

- (void)hide {
    
    [self hideWithCompleteHandler:nil];
}

- (void)hideWithCompleteHandler:(void (^)(BOOL))completeHander {
    
    self.hideCallBack = completeHander;
    
    [UIView animateKeyframesWithDuration:0.2  delay:0.0 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
        
        self.contentView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        
        
    } completion:^(BOOL finished) {
        
        if (finished)
            
            [UIView animateWithDuration:0.3 animations:^{
                
                self.contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
                self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
                self.contentView.alpha = 0.0f;
            } completion:^(BOOL finished) {
                
                if (finished)
                    [self removeFromSuperview];
                
                [self performSelector:@selector(callHideBackWithFinish:) withObject:@(finished) afterDelay:0.3];
            }];
    }];
    
}

- (void)callHideBackWithFinish:(BOOL)finished {
    
    if (self.hideCallBack) {
        
        self.hideCallBack(finished);
    }
}

- (void)show {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    [keyWindow addSubview:self];
    
    self.contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    
    [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.contentView.transform = CGAffineTransformMakeScale(1, 1);
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark --- Layout UI with alertType ---

- (void)layoutButtons {
    
    
    SYAlertButton *firstButton = [self.buttonArray firstObject];
    firstButton.tag = 1001;
    
    SYAlertButton *secondButton = [self.buttonArray lastObject];
    secondButton.tag = 1002;
    if (firstButton == secondButton) {
        
        firstButton.frame = CGRectMake(0, CGRectGetHeight(self.contentView.frame) - 50, CGRectGetWidth(self.contentView.frame), 50);
        firstButton.linePosition = SYAlertButtonLinePositionTop;
        firstButton.corner = SYAlertButtonCornerBottomSide;
        
        
    }else {
        
        firstButton.frame = CGRectMake(0, CGRectGetHeight(self.contentView.frame) - 50, CGRectGetWidth(self.contentView.frame)/2.0f, 50);
        firstButton.linePosition = SYAlertButtonLinePositionTop | SYAlertButtonLinePositionRight;
        firstButton.corner = SYAlertButtonCornerBottomLeft;
        
        secondButton.frame = CGRectMake(CGRectGetWidth(self.contentView.frame)/2.0f, CGRectGetHeight(self.contentView.frame) - 50, CGRectGetWidth(self.contentView.frame)/2.0f, 50);
        secondButton.linePosition = SYAlertButtonLinePositionTop;
        secondButton.corner = SYAlertButtonCornerBottomRight;
    }
}


- (void)layoutTextField {
    
    CGFloat contentWidth = 290;
    
    self.contentView.frame = CGRectMake(0, 0, contentWidth, 195);
    self.contentView.center = self.center;
    
    
    self.hideBtn.hidden = NO;
    self.hideBtn.frame = CGRectMake(contentWidth - 35, 5, 30, 30);;
    
    self.titleLabel.frame = CGRectMake(0, 35, contentWidth, 20);
    
    self.messageLabel.font = KSystemFont(12);
    self.messageLabel.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + 15, contentWidth, 15);
    
    UITextField *tf = [self.textFieldArray firstObject];
    tf.layer.borderColor = [UIColor colorWithHexString:@"999999 "].CGColor;
    tf.layer.borderWidth = 1.0f;
    tf.layer.masksToBounds = YES;
    tf.layer.cornerRadius = 4;
    tf.secureTextEntry = self.isSecrateStyle;
    tf.frame = CGRectMake(20, CGRectGetMaxY(self.titleLabel.frame) + 22, contentWidth - 40, 50);
    
}

#pragma mark --- Button Action ---

- (void)buttonAction:(SYAlertButton *)sender {
    
    if (self.alertType == SYAlertViewTypeinputText) {
        
        if (self.inputCallBack) {
            NSString *text = [self.textFieldArray firstObject].text;
            [self.textFieldArray.firstObject resignFirstResponder];
            self.inputCallBack(text);
            if (text.length == 0) {
                return;
            }
            [self hideWithCompleteHandler:self.textfiledReturnKeyCompleter];
            [self removeKeyboardNotification];
            return;
        }
    }else {
        
        if (sender.SYActionBlock) {
            sender.SYActionBlock();
        }
    }
    [self hideWithCompleteHandler:sender.buttonActionCompleter];
}


#pragma mark --- Setter ---

- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setMessageArray:(NSArray *)messageArray {
    
    _messageArray = [NSArray arrayWithArray:messageArray];
    
    if (self.alertType == SYAlertViewTypeinputText) {
        
        self.messageLabel.text = [messageArray firstObject];
        
        return;
    }
    
    for (NSInteger index = 0; index < messageArray.count; index++) {
        
        UILabel *messageLabel = [self.labelArray objectAtIndex:index];
        messageLabel.text = [messageArray objectAtIndex:index];
    }
}

- (void)setImageName:(NSString *)imageName {
    
    _imageName = imageName;
    
    self.titleImage.image = [UIImage imageNamed:imageName];
}

- (void)setHideCloseBtn:(BOOL)hideCloseBtn {
    
    _hideCloseBtn = hideCloseBtn;
    
    self.hideBtn.hidden = hideCloseBtn;
}

- (void)setButtonEnable:(BOOL)buttonEnable {
    
    _buttonEnable = buttonEnable;
    
    for (SYAlertButton *button in self.buttonArray) {
        [button setTitleColor: buttonEnable ? [UIColor colorWithHexString:@"ffbe1a"] : [UIColor colorWithHexString:@"bdbdbd"] forState:UIControlStateNormal];
        button.userInteractionEnabled = buttonEnable;
        
        button.backgroundColor = [UIColor colorWithHexString:@"ffffff"];//buttonEnable ? [UIColor colorWithHexString:@"ffffff"] : [UIColor colorWithHexString:@"dcdcdc"];
    }
}

- (void)setIsSecrateStyle:(BOOL)isSecrateStyle {
    
    _isSecrateStyle = isSecrateStyle;
    self.textFieldArray.firstObject.secureTextEntry = isSecrateStyle;
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    
    _placeHolder = placeHolder;
    
    [self.textFieldArray[0] setPlaceholder:placeHolder];
}

#pragma mark --- Getter ---

- (UIView *)showView {
    
    return _showView;
}

#pragma mark --- UITextFieldDelegate ---

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (self.inputCallBack) {
        
        self.inputCallBack(textField.text);
    }
    
    if (textField.text.length == 0) {
        return [textField resignFirstResponder];
    }
    [self hideWithCompleteHandler:self.textfiledReturnKeyCompleter];
    
    [self removeKeyboardNotification];

    return [textField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (range.location == 0 || range.length == 0) {
        
        return YES;
    }
    
    NSString *toString = [NSString stringWithFormat:@"%@%@",textField.text,string];
    
    if (toString.length > 20) {
        
        return NO;
    }
    
    return YES;
}

#pragma mark --- KeyBoard Notification ---

- (void)addKeyboardNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyboardNotification {
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

}

- (void)keyBoardWillShow:(NSNotificationCenter *)notification {
    
    // 键盘出现
    
    [UIView animateWithDuration:0.1 animations:^{
        
        self.contentView.center = CGPointMake(self.center.x, self.center.y - 100);
    }];
}

- (void)keyBoardWillHide:(NSNotificationCenter *)notification {
    
    // 键盘消失
    [UIView animateWithDuration:0.1 animations:^{
        
        self.contentView.center = CGPointMake(self.center.x, self.center.y);
        
    }];
}

@end
