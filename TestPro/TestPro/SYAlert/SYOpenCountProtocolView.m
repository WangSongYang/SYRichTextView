//
//  SYOpenCountProtocolView.m
//  OriginFX
//
//  Created by 王颂阳 on 2017/6/6.
//  Copyright © 2017年 tianyi. All rights reserved.
//

#import "SYOpenCountProtocolView.h"
#import "SYAttributeTextCell.h"
#import "SYDeclareDisplayView.h"

@interface SYOpenCountProtocolView ()<UITableViewDelegate,UITableViewDataSource,SYAttributeTextCellDelegate>

/** 协议列表 */
@property (nonatomic,strong) UITableView *tableView;

/** dataSource */
@property (nonatomic,strong) NSArray<SYAttributeTextCellItem *> *dataSource;

@end

@implementation SYOpenCountProtocolView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpData];
        
        [self initSubView];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setUpData];
        
        [self initSubView];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

- (void)setUpData {
    
    SYAttributeTextCellItem *item1 = [[SYAttributeTextCellItem alloc] init];
    item1.text = @"我理解外汇和差价合约保证金含有较高损失风险因此可能不适合我，同时我可能不具备必要的经验和知识以了解其中所含风险。我已阅读并理解被提供的信息包括客户协议中的风险披露声明并愿意继续开户申请。";
    item1.selectFlag = NO;
    item1.linkTextArray = @[@"客户协议",@"风险披露"];
    
    SYAttributeTextCellItem *item2 = [[SYAttributeTextCellItem alloc] init];
    item2.text = @"我已经仔细阅读客户协议并理解及同意所有的交易条款和条件、订单执行政策、一般风险披露陈述、利益冲突政策、客户分类、投资者赔偿基金和隐私协议。我同意受该协议条款的约束，在Origin开设交易账户并注资完全属于本人的主动意愿。";
    item2.selectFlag = NO;
    item2.linkTextArray = @[@"客户协议",@"风险披露",@"隐私协议"];
    self.dataSource = @[item1,item2];
}

- (void)initSubView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.tableView];
    
//    SYDeclareDisplayView *displayOne = [[SYDeclareDisplayView alloc] init];
//    displayOne.displayText = self.dataSource[0].text;
//    [self addSubview:displayOne];
//    
//    SYDeclareDisplayView *displayTwo = [[SYDeclareDisplayView alloc] init];
//    displayTwo.displayText = self.dataSource[1].text;
//    [self addSubview:displayTwo];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    SYAttributeTextCell *cell = [[SYAttributeTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    SYAttributeTextCellItem *item = [self.dataSource objectAtIndex:indexPath.row];
    
    item.index = indexPath.row;
    
    cell.item = item;
    
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"cellHeight===%f",  [SYAttributeTextCell heightForSYAttributeTextCellItem:[self.dataSource objectAtIndex:indexPath.row]]);
    
    return [SYAttributeTextCell heightForSYAttributeTextCellItem:[self.dataSource objectAtIndex:indexPath.row]];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self userSelectCellAtIndex:indexPath.row];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 200, 40)];
    textLabel.textColor = [UIColor colorWithHexString:@"333333"];
    textLabel.font = [UIFont systemFontOfSize:17];
    textLabel.text = @"确认并接受协议:";
    [headerView addSubview:textLabel];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40.f;
}

#pragma mark --- SYAttributeTextCellDelegate ---

- (void)userClickedLinkUrlString:(NSString *)urlString {
    
    NSLog(@"%@",urlString);
    
    if ([self.delegate respondsToSelector:@selector(userClickedLinkUrlString:)]) {
        
        [self.delegate userClickedLinkUrlString:urlString];
    }

}

- (void)userSelectCellAtIndex:(NSInteger)index {
    
    SYAttributeTextCellItem *selectItem = [self.dataSource objectAtIndex:index];
    
    selectItem.selectFlag = !selectItem.selectFlag;
    
    [self.tableView reloadData];
    
    if ([self.delegate respondsToSelector:@selector(userSelectProtocolAtIndex:)]) {
        
        [self.delegate userSelectProtocolAtIndex:index];
    }
}

#pragma mark --- Getter ---

- (BOOL)isAllSelected {
    
    NSInteger selCount = 0;
    
    for (SYAttributeTextCellItem *item in self.dataSource) {
        
        if (item.selectFlag) {
            
            selCount += 1;
        }
    }
    if (selCount != 2) {
        return NO;
    }
    return YES;
}

#pragma mark ---------------------- 华丽的分割线 ------------------------

#pragma mark 使用CoreText绘制文字

- (void)drawRect:(CGRect)rect {
    
    
}




@end
