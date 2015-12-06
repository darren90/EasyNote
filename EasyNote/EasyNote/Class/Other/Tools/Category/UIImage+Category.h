//
//  UIImage+Category.h
//  SmartNote
//
//  Created by Tengfei on 15/9/15.
//  Copyright (c) 2015年 ftf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)
- (UIImage *) imageWithTintColor:(UIColor *)tintColor;

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;
@end
