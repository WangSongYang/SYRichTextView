//
//  SYAlertView.h
//  RunTime
//
//  Created by 王颂阳 on 2017/5/22.
//  Copyright © 2017年 WSY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SYAlertViewType){
    
    SYAlertViewTypeMutableText,
    SYAlertViewTypeImageAndSingleText,
    SYAlertViewTypeImageAndMutableText,
    SYAlertViewTypeinputText,
    SYAlertViewTypeSubView
};

@interface SYAlertView : UIView

/** 标题 */
@property (nonatomic,strong) NSString *title;

/** 需要展示的自定义View */
@property (nonatomic,strong,readonly) UIView *showView;

/** 图片 */
@property (nonatomic,strong) NSString *imageName;

/** 提示消息 */
@property (nonatomic,strong) NSArray *messageArray;

/** 隐藏X按钮 */
@property (nonatomic,assign) BOOL hideCloseBtn;

/** 按钮是否可以点击 */
@property (nonatomic,assign) BOOL buttonEnable;

/** 灰色背景是否可以响应 */
@property (nonatomic,assign) BOOL grayBgCanResponse;

/** 输入框是否密文显示，默认为NO */
@property (nonatomic,assign) BOOL isSecrateStyle;

/** 占位符 */
@property (nonatomic,copy) NSString *placeHolder;

/**
 *   @desc 构造方法
 *
 *   @param alertType 展示类型
 **/
- (instancetype)initAlertWithType:(SYAlertViewType)alertType;

/**
 *   @desc 构造方法
 *   
 *   @param subView 需要展示的View
 **/
- (instancetype)initAlertWithSubView:(UIView *)subView;

/**
 *   @desc 添加按钮
 *
 *   @param title 按钮文字
 *
 *   @param actionHandler 响应回调
 **/
- (void)addButton:(NSString *)title actionHandler:(void (^)())actionHandler;

/**
 *   @desc 添加按钮
 *
 *   @param title 按钮文字
 *
 *   @param actionHandler 响应回调
 *
 *   @param completeHander 消失动画完成回调
 *
 **/
- (void)addButton:(NSString *)title actionHandler:(void (^)())actionHandler afterCompleter:(void(^)(BOOL isFinish))completeHander;

/**
 *   @desc 添加输入框
 **/
- (void)addTextField:(NSString *)placeHolder inputHandler:(void (^)(NSString *text))inputHandler;

/**
 *   @desc 添加输入框
 **/
- (void)addTextField:(NSString *)placeHolder inputHandler:(void (^)(NSString *text))inputHandler completeHandleder:(void (^)(BOOL isFinish))completeHander;

/**
 *   @desc 显示Alert
 **/
- (void)show;

/**
 *   @desc alert消失
 **/
- (void)hide;

/**
 *   @desc alert消失
 **/
- (void)hideWithCompleteHandler:(void(^)(BOOL isFinish))completeHander;
@end
