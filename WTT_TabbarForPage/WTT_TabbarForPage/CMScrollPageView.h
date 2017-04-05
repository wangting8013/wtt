//
//  CMScrollPageView.h
//  MoviesStore 2.0
//
//  Created by wangting on 15/6/4.
//  Copyright (c) 2015年 caimiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    lineViewType = 0,//线的形式
    backgroundViewType//背景view形式
} moveViewType;

@interface CMScrollPageView : UIView<UIScrollViewDelegate>


/**
 *  选择类目下标
 */
@property (nonatomic, assign) NSInteger selectedPageIndex;


/**
 *  头部背景颜色
 */
@property (nonatomic, strong) UIColor *headerBackgroundColor;


/////////////////////分割线/////////////////////
/**
 *  上分割线
 */
@property (nonatomic, strong) UIColor *topLineColor;


/**
 *  按钮间分割线
 */
@property (nonatomic, strong) UIColor *middleLineColor;


/**
 *  下分割线
 */
@property (nonatomic, strong) UIColor *bottomLineColor;

/////////////////////移动标识/////////////////////

/**
 * 移动标识的样式
 */
@property (nonatomic, assign) moveViewType move_type;

/**
 *  移动标识颜色
 */
@property (nonatomic, strong) UIColor *moveViewColor;

/**
 *  移动标识view的大小 只限百分比
 */
@property (nonatomic, assign) CGFloat moveViewWidth_percent;


/////////////////////标签字体 颜色/////////////////////
/**
 *  字体
 */
@property (nonatomic, strong) UIFont *itemFont;

/**
 *  选中颜色
 */
@property (nonatomic, strong) UIColor *itemSelectColor;

/**
 *  未选中颜色
 */
@property (nonatomic, strong) UIColor *itemUnSelectColor;


/**
 *  内容view
 *
 *  @param CMViewArray 页面数组
 */

-(void)setContentOfView:(NSArray *)CMViewArray;


/**
 *  设置标头
 *
 *  @param firstItem 第一个
 *  @param otherItem 后N个。。。
 */
-(void)setItems:(NSString *)firstItem otherItems:(NSString *)otherItem,... NS_REQUIRES_NIL_TERMINATION;

@property(nonatomic,copy)void (^btnClickBlock)(int);

@end
