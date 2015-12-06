//
//  PlaceholderTextView.m
//  EasyNote
//
//  Created by Tengfei on 15/12/6.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "PlaceholderTextView.h"

@implementation PlaceholderTextView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //object：谁发出的通知
        [WBNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    
    return self;
}
-(void)textDidChange
{
    //重绘
    [self setNeedsDisplay];
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}
#pragma mark - 手动更改字体以及文字时 再次进行重绘
-(void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}


-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    //    setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect
{
    if (self.hasText) return;
    
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSFontAttributeName] = self.font;
    att[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    
    //    [self.placeholder drawAtPoint:CGPointMake(5, 10) withAttributes:nil];
    CGFloat x = 5;
    CGRect rrect = CGRectMake(x, 10, rect.size.width-2*x, CGFLOAT_MAX);
    [self.placeholder drawInRect:rrect withAttributes:att];
}

-(void)dealloc
{
    [WBNotificationCenter removeObserver:self];
}

/**
 selectedRange :
 1.本来是用来控制textView的文字选中范围
 2.如果selectedRange.length为0，selectedRange.location就是textView的光标位置
 
 关于textView文字的字体
 1.如果是普通文字（text），文字大小由textView.font控制
 2.如果是属性文字（attributedText），文字大小不受textView.font控制，应该利用NSMutableAttributedString的- (void)addAttribute:(NSString *)name value:(id)value range:(NSRange)range;方法设置字体
 **/


@end
