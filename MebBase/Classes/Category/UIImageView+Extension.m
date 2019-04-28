//
//  UIImageView+Extension.m
//  AFNetworking
//
//  Created by meb on 2019/4/26.
//**********************************
//     ______    _______          **
//    /\  __ \  /\   ___\         **
//    \ \  __C  \ \  \___         **
//     \ \_____\ \ \_____\        **
//      \/_____/  \ \             **
//                 \F\            **
//**********************************

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)

/**
 *  设置头像
 *
 *  @param url 头像的url
 */
- (void)setHeader:(NSString *)url{
    /*
     UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
     [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
     if (image == nil) return;
     self.image = [image circleImage];
     }];*/
}


/**
 *  根据当前图片视图设置放大缩小尺寸
 *
 *  @return 返回尺寸
 */
- (CGRect)setMaxMinZoomScalesForCurrentBoundWithImageView{
    if (!([self isKindOfClass:[UIImageView class]]) || self == nil || self.image == nil) {
        return CGRectZero;
    }
    
    if (!([self.image isKindOfClass:[UIImage class]]) || self.image == nil) {
        return CGRectZero;
    }
    
    CGSize boundsSize = [UIScreen mainScreen].bounds.size;
    CGSize imageSize = self.image.size;
    if (imageSize.width == 0 && imageSize.height == 0) {
        return CGRectZero;
    }
    
    //获取合适的缩放比例
    CGFloat xScale = boundsSize.width / imageSize.width;
    CGFloat yScale = boundsSize.height / imageSize.height;
    CGFloat minScale = MIN(xScale, yScale);
    if (xScale >= 1 && yScale >= 1) {
        minScale = MIN(xScale, yScale);
    }
    
    CGRect frameToCenter = CGRectZero;
    frameToCenter = CGRectMake(0, 0, imageSize.width * minScale, imageSize.height * minScale);
    
    //设置中心点
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = floorf((boundsSize.width - frameToCenter.size.width) / 2.0);
    }else{
        frameToCenter.origin.x = 0;
    }
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = floorf((boundsSize.height - frameToCenter.size.height) / 2.0);
    }else{
        frameToCenter.origin.y = 0;
    }
    
    return frameToCenter;
}





#pragma mark - 创建快捷方式
/**
 *  快速创建图片视图
 *
 *  @param imageName   图片名称
 *  @param contentMode 图片模式
 *
 *  @return 返回创建的图片视图
 */
+ (UIImageView *)imageViewWithImage:(NSString *)imageName
                        contentMode:(UIViewContentMode)contentMode{
    UIImage *image = [UIImage imageNamed:imageName];
    CGSize size = image.size;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    imageView.image = image;
    imageView.contentMode = contentMode;
    return imageView;
    
}



/**
 *  图片视图的分屏动画，裁剪一个图片视图的图片为指定尺寸的两部分，然后粘贴到指定的视图上，然后延时指定时间做分屏动画
 *
 *  @param topSize    截取顶部尺寸图片的尺寸
 *  @param bottomSize 截取底部尺寸的图片的尺寸
 *  @param parentView 父类视图
 *  @param delayTime  延时多少时间开始做分屏动画
 */
- (void)splitTopImageSize:(CGRect)topSize bottomImageSize:(CGRect)bottomSize addToView:(UIView *)parentView delayTime:(CGFloat)delayTime{
    UIImage *originalBigImage = self.image;
    
    UIImageView *topImgView = [[UIImageView alloc] initWithFrame:topSize];
    CGRect clipFrame = topSize;
    CGImageRef refImage = CGImageCreateWithImageInRect(originalBigImage.CGImage, clipFrame);
    UIImage *newImage = [UIImage imageWithCGImage:refImage];
    CGImageRelease(refImage);
    topImgView.image = newImage;
    [parentView addSubview:topImgView];
    
    
    UIImageView *bottomImgView = [[UIImageView alloc] initWithFrame:bottomSize];
    CGRect bclipFrame = bottomSize;
    CGImageRef brefImage = CGImageCreateWithImageInRect(originalBigImage.CGImage, bclipFrame);
    UIImage *bnewImage = [UIImage imageWithCGImage:brefImage];
    CGImageRelease(brefImage);
    bottomImgView.image = bnewImage;
    [parentView addSubview:bottomImgView];
    
    // 延时分屏动画，这里分屏动画可以做多种动画，这里我就不扩展了，默认是上下分屏
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.8f animations:^{
            CGRect tFrame = topImgView.frame;
            tFrame.origin.y = -topSize.size.height;
            topImgView.frame = tFrame;
            
            CGRect bFrame = bottomImgView.frame;
            bFrame.origin.y = bottomSize.size.height;
            bottomImgView.frame = bFrame;
        }];
    });
}

@end
