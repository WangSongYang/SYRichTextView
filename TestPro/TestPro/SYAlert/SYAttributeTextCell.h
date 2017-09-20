//
//  SYAttributeTextCell.h
//  RunTime
//
//  Created by 王颂阳 on 2017/5/25.
//  Copyright © 2017年 WSY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYAttributeTextCellItem : NSObject

/** 文本 */
@property (nonatomic,strong) NSString *text;

/** 链接文本 */
@property (nonatomic,strong) NSArray *linkTextArray;

/** 选中状态 */
@property (nonatomic,assign) BOOL selectFlag;

@property (nonatomic,assign) NSInteger index;

@end

@protocol SYAttributeTextCellDelegate <NSObject>

- (void)userClickedLinkUrlString:(NSString *)urlString;

- (void)userSelectCellAtIndex:(NSInteger)index;

@end

@interface SYAttributeTextCell : UITableViewCell

/** delegate */
@property (nonatomic,weak) id<SYAttributeTextCellDelegate> delegate;

/** item */
@property (nonatomic,strong) SYAttributeTextCellItem *item;

+ (CGFloat)heightForSYAttributeTextCellItem:(SYAttributeTextCellItem *)item;

@end
