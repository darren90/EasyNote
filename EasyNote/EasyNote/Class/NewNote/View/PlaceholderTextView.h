//
//  PlaceholderTextView.h
//  EasyNote
//
//  Created by Tengfei on 15/12/6.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView

@property (nonatomic,copy)NSString * placeholder;

@property (nonatomic,strong)UIColor * placeholderColor;
@end
