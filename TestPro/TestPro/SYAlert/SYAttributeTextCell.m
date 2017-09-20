//
//  SYAttributeTextCell.m
//  RunTime
//
//  Created by 王颂阳 on 2017/5/25.
//  Copyright © 2017年 WSY. All rights reserved.
//

#import "SYAttributeTextCell.h"
#import "NSAttributedString+HHHeight.h"
#import <CoreText/CoreText.h>

#define isIphone5   CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568))

@implementation SYAttributeTextCellItem

@end

@interface SYAttributeTextCell ()<UITextViewDelegate>

/** 显示文字 */
@property (nonatomic,strong) UITextView *textView;

/** 选中按钮 */
@property (nonatomic,strong) UIButton *selectBtn;

/** cell高度 */
@property (nonatomic,assign) CGFloat cellHeight;

@end

@implementation SYAttributeTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    
    self.textView = [[UITextView alloc] init];
    self.textView.delegate = self;
    self.textView.editable = NO;
    self.textView.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"5183F7"],NSUnderlineColorAttributeName: [UIColor colorWithHexString:@"5183F7"],NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    self.textView.scrollEnabled = NO;
    self.textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.contentView addSubview:self.textView];

    self.selectBtn = [[UIButton alloc] init];
    [self.selectBtn setImage:[UIImage imageNamed:@"动漫.jpg"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"动漫.jpg"] forState:UIControlStateSelected];
    [self.selectBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.contentView addSubview:self.selectBtn];
    
    
    // 布局
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.selectBtn.mas_right);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.contentView.mas_top);
        make.height.equalTo(@33);
    }];
}


+ (CGFloat)heightForSYAttributeTextCellItem:(SYAttributeTextCellItem *)item {
    
    NSAttributedString *attrString = [self translateToAttributedStringWithitem:item];
    return [attrString heightWithconstrainedToWidth:SCREEN_WIDTH - 100] + 16;
}

- (void)buttonAction:(UIButton *)sender {
    
    sender.selected = !sender.isSelected;
    
    if ([self.delegate respondsToSelector:@selector(userSelectCellAtIndex:)]) {
        
        [self.delegate userSelectCellAtIndex:self.item.index];
    }
}

#pragma mark --- Setter ---

- (void)setItem:(SYAttributeTextCellItem *)item {
        
    self.selectBtn.selected = item.selectFlag;
    
    NSAttributedString *attrString = [[self class] translateToAttributedStringWithitem:item];
    self.textView.attributedText = attrString;
    
    CGFloat height = [attrString heightWithconstrainedToWidth:SCREEN_WIDTH - 100];
    
    NSLog(@"tvheight === %f",height);
    [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.selectBtn.mas_right);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.contentView.mas_top);
        make.height.equalTo(@(height));
    }];
}

#pragma mark --- UITextViewDelegate ---

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    NSString *urlString = [self.textView.text substringWithRange:characterRange];
    if ([self.delegate respondsToSelector:@selector(userClickedLinkUrlString:)]) {
        [self.delegate userClickedLinkUrlString:urlString];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    NSString *urlString = [self.textView.text substringWithRange:characterRange];
    if ([self.delegate respondsToSelector:@selector(userClickedLinkUrlString:)]) {
        if (iOS10) {
            return YES;
        }
        [self.delegate userClickedLinkUrlString:urlString];
    }
    return YES;

}

#pragma mark --- Pravite Funcs ---

+ (NSAttributedString *)translateToAttributedStringWithitem:(SYAttributeTextCellItem *)item {
    
    NSMutableAttributedString *toString = [[NSMutableAttributedString alloc] initWithString:item.text];
    NSMutableArray *rangArray = [NSMutableArray array];
    for (NSString *linkText in item.linkTextArray) {
        [rangArray addObject:[NSValue valueWithRange:[item.text rangeOfString:linkText]]];
    }
    for (NSInteger index = 0;index < item.linkTextArray.count; index++) {
        [toString addAttribute:NSLinkAttributeName value:[item.linkTextArray objectAtIndex:index] range:[rangArray[index] rangeValue]];
    }
    [toString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, toString.length - 1)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5.0f;
    paragraphStyle.minimumLineHeight = 5.0f;
    [toString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, toString.length -1)];

    return toString;
}

@end
