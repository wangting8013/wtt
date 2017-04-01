//
//  ItemSelectView.m
//  WTT--JD
//
//  Created by W on 2017/4/1.
//  Copyright © 2017年 wangting. All rights reserved.
//

#define DEFAULT_COLOR [UIColor colorWithRed:245.0/255.0f green:245.0/255.0f blue:245.0/255.0f alpha:1.0f]

#import "ItemListView.h"
#import "itemButton.h"

@interface ItemListView()

@property (nonatomic,strong)UIScrollView *itemScrollView;
@property (nonatomic,strong)NSMutableDictionary *recordDictionary;

@end

@implementation ItemListView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = DEFAULT_COLOR;
        self.recordDictionary = [[NSMutableDictionary alloc]init];
        
        [self creatBottomView];
    }
    
    return self;
}

-(void)setItemArray:(NSArray *)itemArray{
    _itemArray = itemArray;
    
    [self setView];
}


-(void)setView{
    
    if (self.itemScrollView) {
        [self.itemScrollView removeFromSuperview];
    }
    
    self.itemScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40.0, self.frame.size.width, self.frame.size.height - 80.0)];
    self.itemScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.itemScrollView];
    
    //横线间隙
    CGFloat rowLineW = 15.0;
    //纵向间隙
    CGFloat colLineW = 25.0;
    //每行个数
    int rowNum = 2;
    //按钮长度
    CGFloat btnW = (self.frame.size.width - (rowNum+1)*rowLineW)/2;
    //按钮高度
    CGFloat btnH = 30;
    NSInteger count = self.itemArray.count;
    
    //获取之前选择的记录
    NSArray *array = [[NSArray alloc]initWithArray:[self.recordDictionary objectForKey:self.numKey]];
    
    for (int i=0; i<count; i++) {
        
        CGFloat x = (i/count*(self.frame.size.width - rowLineW*rowNum))+i%count%2*(btnW+rowLineW)+rowLineW;
        
        itemButton *btn = [[itemButton alloc]initWithFrame:CGRectMake(x, i%count/rowNum*(btnH+colLineW) + colLineW, btnW, btnH)];
        btn.tag = i;
        [btn setTitle:self.itemArray[i] forState:UIControlStateNormal];
        if([array containsObject:[NSString stringWithFormat:@"%ld",btn.tag]]){
            btn.selected = YES;
            btn.lineView.hidden = NO;
            btn.selectImageView.hidden = NO;
        }
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.itemScrollView addSubview:btn];
        
    }
    
    [self.itemScrollView setContentSize:CGSizeMake(0, count/2*55+ count%2*55 + 25) ];
    

}

-(void)btnClick:(id)sender{
    
    itemButton *btn = (itemButton *)sender;
    
    btn.lineView.hidden = btn.selected;
    btn.selectImageView.hidden = btn.selected;
    
    btn.selected = !btn.selected;
}

-(void )creatBottomView{
    
    UIButton *clearButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 40.0, self.frame.size.width/2, 40)];
    [clearButton setTitle:@"重置" forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    clearButton.titleLabel.font = [UIFont systemFontOfSize:12];
    clearButton.backgroundColor = DEFAULT_COLOR;
    
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2, self.frame.size.height - 40.0, self.frame.size.width/2, 40)];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:12];
    sureButton.backgroundColor = [UIColor redColor];
    
    
    [self addSubview:clearButton];
    [self addSubview:sureButton];
    
    [clearButton addTarget:self action:@selector(clearClick:) forControlEvents:UIControlEventTouchUpInside];
    [sureButton addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)clearClick:(id)sender{
    //清除记录
    [self.recordDictionary removeObjectForKey:self.numKey];
    
    [self setView];
}

-(void)sureClick:(id)sender{
    
    //记录选择的数据
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    for ( UIView *view in self.itemScrollView.subviews) {
        
        UIButton *btn  = (UIButton *)view;
        if ([btn isKindOfClass:[UIButton class]]&& btn.selected) {
            
            [array addObject:[NSString stringWithFormat:@"%ld",btn.tag]];
        }
    }
    
    if (array.count) {
        [self.recordDictionary addEntriesFromDictionary:@{self.numKey:array}];
    }
    
    //调用Block 传递数据 收缩视图
    if (_sureBtnBlock) {
        _sureBtnBlock(self.recordDictionary);
    }
}

@end
