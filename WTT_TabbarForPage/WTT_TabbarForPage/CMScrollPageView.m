//
//  CMScrollPageView.m
//  MoviesStore 2.0
//
//  Created by wangting on 15/6/4.
//  Copyright (c) 2015年 caimiao. All rights reserved.
//

#import "CMScrollPageView.h"

#define DEF_UICOLORFROMRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define DEF_COLOR_RGB(r,g,b)         [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]

#define SM_DEVICE_WIDTH       self.frame.size.width
#define SM_DEVICE_HEIGHT       self.frame.size.height
#define SM_BUTTON_HEIGHT 40.0

@interface CMScrollPageView(){
    
    NSInteger CMCurrentPage;
    BOOL CMNeedUseDelegate;
    
    //标题记录按钮
    UIButton *recordButton;
    
    //移动标识
    UIView *moveView;
}

@property (nonatomic,retain) UIScrollView *CMScrollView;

/**
 *  标题数组
 */
@property (nonatomic, strong) NSMutableArray *items;

/**
 *  标题按钮数组
 */
@property (nonatomic, strong) NSMutableArray *buttonArray;


@end

@implementation CMScrollPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CMNeedUseDelegate = YES;
        
        self.backgroundColor = [UIColor clearColor];
        
        if (self.CMScrollView == nil) {
            self.CMScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,  self.frame.size.width,  self.frame.size.height)];
            
            self.CMScrollView.pagingEnabled = YES;
            self.CMScrollView.delegate = self;
            self.CMScrollView.showsHorizontalScrollIndicator = NO;
            
            //默认值设置
            //分割线
            self.topLineColor = DEF_UICOLORFROMRGB(0xe7e7e7);
            self.middleLineColor = DEF_UICOLORFROMRGB(0xe7e7e7);
            self.bottomLineColor = DEF_UICOLORFROMRGB(0xe7e7e7);
            
            //移动标识
            self.move_type = lineViewType;
            self.moveViewWidth_percent = 1;
            
            //标签字体大小 颜色
            self.itemFont = [UIFont systemFontOfSize:15];
            self.itemSelectColor = [UIColor blackColor];//DEF_COLOR_RGB(251, 79, 10)
            self.itemUnSelectColor = DEF_COLOR_RGB(150, 150, 150);
            
            self.headerBackgroundColor = [UIColor whiteColor];
            self.moveViewColor = DEF_COLOR_RGB(251, 79, 10);
            
            
        }
        [self addSubview:self.CMScrollView];
    }
    return self;
}

#pragma mark 添加ScrollowViewd的ContentView

-(void)setContentOfView:(NSArray *)CMViewArray{
    
    CGFloat Y = 0;
    
    if (self.items.count>0) {
        Y = SM_BUTTON_HEIGHT;
    }
    
    for (int i = 0; i < [CMViewArray count]; i++) {
        
        [CMViewArray[i] setFrame:CGRectMake( self.frame.size.width * i, Y,  self.frame.size.width, self.frame.size.height - Y)];
        
        [self.CMScrollView addSubview:CMViewArray[i]];
    }
    [self.CMScrollView setContentSize:CGSizeMake(self.frame.size.width * [CMViewArray count], 0)];
}



/**
 *  设置标头
 *
 *  @param firstItem 第一个
 *  @param otherItem 后N个。。。
 */
-(void)setItems:(NSString *)firstItem otherItems:(NSString *)otherItem, ...{
    
    va_list args ;
    va_start(args, otherItem);
    
    self.items = [[NSMutableArray alloc] init];
    [self.items addObject:firstItem];
    
    for (NSString *str = otherItem; str != nil; str = va_arg(args,NSString*)) {
        
        [self.items addObject:str];
    }
    va_end(args);
    
    [self setSegmentControl];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    CMNeedUseDelegate = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (self.CMScrollView.contentOffset.x+320/2.0) / 320;
    if (CMCurrentPage == page) {
        return;
    }
    CMCurrentPage= page;
    _selectedPageIndex = CMCurrentPage;
    [self selectedSegmentIndex:CMCurrentPage];
}

#pragma mark 移动ScrollView到某个页面
-(void)moveScrollowViewAthIndex:(NSInteger)aIndex{
    
    if (_selectedPageIndex >=0) {
        aIndex = _selectedPageIndex;
    }
    
    CMNeedUseDelegate = NO;
    self.CMScrollView.contentOffset = CGPointMake(self.frame.size.width * aIndex, 0);
    CMCurrentPage= aIndex;
    _selectedPageIndex = CMCurrentPage;
    [self selectedSegmentIndex:CMCurrentPage];
}


#pragma mark 按钮设置
-(void)setSegmentControl{
    
    for (UIView *view in self.subviews) {
        if (view.tag == 4044) {
            [view removeFromSuperview];
        }
    }
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame),self.frame.size.height<SM_BUTTON_HEIGHT?self.frame.size.height:SM_BUTTON_HEIGHT)];
    headerView.backgroundColor = self.headerBackgroundColor;
    headerView.tag = 4044;
    [self addSubview:headerView];
    
    NSInteger segmentWidth = SM_DEVICE_WIDTH/[self.items count];
    
    self.buttonArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<[self.items count];i++) {
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i*(SM_DEVICE_WIDTH/[self.items count]), 0, segmentWidth, headerView.frame.size.height)];
        
        button.titleLabel.font = _itemFont;
        
        [button setTitle:self.items[i] forState:UIControlStateNormal];
        
        [button setTitleColor:self.itemUnSelectColor forState:UIControlStateNormal];
        
        [button setBackgroundColor:[UIColor clearColor]];
        
        if (_selectedPageIndex==i || (!_selectedPageIndex && i==0)) {
            
            [button setTitleColor:_itemSelectColor forState:UIControlStateNormal];
            
            recordButton = button;
            
            
            
            //移动标识
            moveView = [[UIView alloc]initWithFrame:CGRectMake(0,0,
                                                                    button.frame.size.width*_moveViewWidth_percent,
                                                                    (_move_type == lineViewType?2:button.frame.size.height*0.7))];
            
            moveView.center = CGPointMake(button.center.x, (_move_type == lineViewType?headerView.frame.size.height-1.5:button.center.y));
            moveView.backgroundColor = _moveViewColor;
            if (self.move_type == backgroundViewType) {
                moveView.layer.cornerRadius = 2;
                moveView.layer.masksToBounds = YES;
            }
            [headerView addSubview:moveView];
        }
        
        button.tag = i;
        
        [button addTarget:self action:@selector(segementButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.buttonArray addObject:button];
        
        [self addSubview:button];
        
        
        
        UIView *middleLineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(button.frame)*i-1, SM_BUTTON_HEIGHT/4, 1, SM_BUTTON_HEIGHT/2)];
        middleLineView.tag = 333;
        middleLineView.backgroundColor = _middleLineColor;
        [headerView addSubview:middleLineView];
    }
    
    //上分割线
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    topLineView.backgroundColor = _topLineColor;
    topLineView.tag = 666;
    [headerView addSubview:topLineView];
    
    //下分割线
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(headerView.frame)-0.5, self.frame.size.width, 0.5)];
    bottomLineView.backgroundColor = _bottomLineColor;
    bottomLineView.tag = 999;
    [headerView addSubview:bottomLineView];
}


#pragma mark 点击事件

-(void)segementButtonClick:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    
    if (_btnClickBlock) {
        _btnClickBlock(btn.tag);
    }
    
    //scroll移动
    
    [self moveScrollowViewAthIndex:btn.tag];
    
    self.selectedPageIndex = btn.tag;
    
    [self changeSelectButton:btn];
}


-(void)changeSelectButton:(UIButton *)btn{
    
    [recordButton setTitleColor:self.itemUnSelectColor forState:UIControlStateNormal];
    
    [self.buttonArray removeObjectAtIndex:recordButton.tag];
    [self.buttonArray insertObject:recordButton atIndex:recordButton.tag];
    
    [btn setTitleColor:_itemSelectColor forState:UIControlStateNormal];
    
    recordButton = btn;
    
    [self.buttonArray removeObjectAtIndex:btn.tag];
    [self.buttonArray insertObject:recordButton atIndex:btn.tag];
    
    [self moveframe:btn.frame.origin.x];
}

#pragma mark 设置选中按钮
-(void)selectedSegmentIndex:(NSInteger)index{
    if (index>=[self.items count]) {
        return;
    }
    
    UIButton *btn = self.buttonArray[index];
    
    [self changeSelectButton:btn];
}


-(void)moveframe:(CGFloat)width{
    
    [UIView animateWithDuration:0.35 animations:^{
        
        CGPoint center = CGPointMake(recordButton.center.x, moveView.center.y);
        
        moveView.center = center;
    }];
}




-(void)setSelectedPageIndex:(NSInteger)selectedPageIndex{
    _selectedPageIndex = selectedPageIndex;
    [self moveScrollowViewAthIndex:selectedPageIndex];
}


-(void)setHeaderBackgroundColor:(UIColor *)headerBackgroundColor{
    _headerBackgroundColor = headerBackgroundColor;
    
    UIView *headerView = (UIView *)[self viewWithTag:4044];
    headerView.backgroundColor = headerBackgroundColor;;
}

-(void)setTopLineColor:(UIColor *)topLineColor{
    _topLineColor = topLineColor;
    
    UIView *view = (UIView *)[self viewWithTag:666];
    view.backgroundColor = topLineColor;
}

-(void)setMiddleLineColor:(UIColor *)middleLineColor{
    
    _middleLineColor = middleLineColor;
    
    UIView *headerView = (UIView *)[self viewWithTag:4044];
    for (UIView *view in headerView.subviews) {
        if (view.tag == 333) {
            view.backgroundColor = middleLineColor;
        }
    }
}

-(void)setBottomLineColor:(UIColor *)bottomLineColor{
    _bottomLineColor = bottomLineColor;
    
    UIView *view = (UIView *)[self viewWithTag:999];
    view.backgroundColor = bottomLineColor;
}

-(void)setMove_type:(moveViewType)move_type{
    _move_type = move_type;
    
    CGFloat height = (self.frame.size.height<SM_BUTTON_HEIGHT?self.frame.size.height:SM_BUTTON_HEIGHT);
    
    CGRect frame =  moveView.frame;
    frame.size.height = (move_type == lineViewType?2:recordButton.frame.size.height*0.7);
    frame.origin.y = (move_type == lineViewType?height-1.5:(height-frame.size.height)/2);
    moveView.frame = frame;
    
    moveView.layer.cornerRadius = 2;
    moveView.layer.masksToBounds = YES;
}

-(void)setMoveViewColor:(UIColor *)moveViewColor{
    
    _moveViewColor = moveViewColor;
    moveView.backgroundColor = moveViewColor;
}

-(void)setItemFont:(UIFont *)itemFont{
    _itemFont = itemFont;
    if (self.buttonArray.count>0) {
        for (UIButton *button in self.buttonArray) {
            button.titleLabel.font = itemFont;
        }
    }
}

-(void)setItemSelectColor:(UIColor *)itemSelectColor{
    _itemSelectColor = itemSelectColor;
    [recordButton setTitleColor:itemSelectColor forState:UIControlStateNormal];
}


-(void)setItemUnSelectColor:(UIColor *)itemUnSelectColor{
    _itemUnSelectColor  = itemUnSelectColor;
    
    if (self.buttonArray.count>0) {
        for (UIButton *button in self.buttonArray) {
            if (button.tag!=recordButton.tag) {
                [button setTitleColor:itemUnSelectColor forState:UIControlStateNormal];
            }
        }
    }
}

-(void)setMoveViewWidth_percent:(CGFloat)moveViewWidth_percent{
    
    _moveViewWidth_percent = moveViewWidth_percent;
    
    if (moveViewWidth_percent>1) {
        _moveViewWidth_percent = 1;
    }
    if (moveViewWidth_percent<0) {
        _moveViewWidth_percent = 0;
    }
    
    CGRect frame = moveView.frame;
    frame.size.width = recordButton.frame.size.width*_moveViewWidth_percent;
    moveView.frame = frame;
    
    CGPoint center = CGPointMake(recordButton.center.x, moveView.center.y);
    moveView.center = center;
}

@end
