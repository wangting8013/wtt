//
//  ItemListView.h
//  WTT--JD
//
//  Created by W on 2017/4/1.
//  Copyright © 2017年 wangting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemListView : UIView

@property(nonatomic,strong)NSArray *itemArray;
@property(nonatomic,strong)NSString *numKey;

@property (nonatomic, copy) void (^sureBtnBlock)(NSDictionary *);

-(void)setView;

@end
