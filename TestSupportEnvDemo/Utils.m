//
//  Utils.m
//  TestSupportEnvDemo
//
//  Created by chenting on 2021/7/15.
//

#import "Utils.h"

@implementation Utils
+(UIImage *)resizaImg:(UIImage *)img withImgSize:(CGSize)imgSize anonFrame:(CGRect)btnFrame

{

   img = [img stretchableImageWithLeftCapWidth:1 topCapHeight:1];

    

    CGFloat iamgeViewWidth = CGRectGetWidth(btnFrame);

    CGFloat imageWidth = imgSize.width;

    CGFloat imageHeight = CGRectGetHeight(btnFrame);

    CGFloat tempWidth = (iamgeViewWidth + imageWidth) / 2.0f;

    

   // 重新绘制Image

  UIGraphicsBeginImageContextWithOptions(CGSizeMake(tempWidth,imageHeight),NO, [UIScreen mainScreen].scale);

    [img drawInRect:CGRectMake(0,0, tempWidth,imageHeight)];

   UIImage * newImage =UIGraphicsGetImageFromCurrentImageContext();

   UIGraphicsEndImageContext();

    

   img= [newImage stretchableImageWithLeftCapWidth:tempWidth-1 topCapHeight:1];

   

    return img;

    

}
@end
