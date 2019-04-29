//
//  UIImage+Extentsion.m
//  AFNetworking
//
//  Created by meb on 2019/4/25.
//**********************************
//     ______    _______          **
//    /\  __ \  /\   ___\         **
//    \ \  __C  \ \  \___         **
//     \ \_____\ \ \_____\        **
//      \/_____/  \ \             **
//                 \F\      Ysfox **
//**********************************

#import "UIImage+Extension.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>
#import <ImageIO/ImageIO.h>

#if __has_feature(objc_arc)
#define toCF (__bridge CFTypeRef)
#define fromCF (__bridge id)
#else
#define toCF (CFTypeRef)
#define fromCF (id)
#endif

// This category supports only iOS 7+, although it should be easy to add 6- support.

static NSString *const kAssetImageBaseFileName = @"LaunchImage";

// Asset catalog part

static CGFloat const kAssetImage4inchHeight = 568.;
static CGFloat const kAssetImage35inchHeight = 480.;
static CGFloat const kAssetImage6PlusScale = 3.;

static NSString *const kAssetImageiOS8Prefix = @"-800";
static NSString *const kAssetImageiOS7Prefix = @"-700";
static NSString *const kAssetImagePortraitString = @"-Portrait";
static NSString *const kAssetImageLandscapeString = @"-Landscape";
static NSString *const kAssetImageiPadPostfix = @"~ipad";
static NSString *const kAssetImageHeightFormatString = @"-%.0fh";
static NSString *const kAssetImageScaleFormatString = @"@%.0fx";

// IB based part
static NSString *const kAssetImageLandscapeLeftString = @"-LandscapeLeft";
static NSString *const kAssetImagePathToFileFormatString = @"~/Library/Caches/LaunchImages/%@/%@";
static NSString *const kAssetImageSizeFormatString = @"{%.0f,%.0f}";

@implementation UIImage (Extension)

/**
 *  圆形图片
 *
 *  @return 返回圆形图片
 */
- (instancetype)circleImage{
    // 开启上下文
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 画圆
    CGRect rect = {CGPointZero, self.size};
    CGContextAddEllipseInRect(context, rect);
    
    //裁减绘制
    CGContextClip(context);
    [self drawInRect:rect];
    
    //获取图片并关闭上下文
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  返回原始模式的图片
 *
 *  @param name 图片的名称
 *
 *  @return 返回原始模式的图片
 */
+ (UIImage *)originImageWithName:(NSString *)name {
    return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


/**
 *  返回中心拉伸的图片
 *
 *  @param name 图片的名称
 *
 *  @return 返回拉伸的图片
 */
+(UIImage *)stretchedImageWithName:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    int leftCap = image.size.width * 0.5;
    int topCap = image.size.height * 0.5;
    return [image stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
}

/**
 *  颜色转换成图像
 *
 *  @param color 给定的颜色
 *
 *  @return 返回返回创建的图片
 */
+(UIImage *)imageFromColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    int leftCap = img.size.width * 0.5;
    int topCap = img.size.height * 0.5;
    return [img stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
    return img;
}


/**
 *  颜色转换成图像
 *
 *  @param color 给定指定的颜色
 *  @param size  给定指定的尺寸
 *
 *  @return 返回创建的图片
 */
+(UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size{
    @autoreleasepool {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context,color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
    }
}


/**
 *  从指定的包种获取到对应的名称的图片
 *
 *  @param bundleName 指定的包名称
 *  @param name       指定的图片的名称
 *
 *  @return 返回对应的图片
 */
+(UIImage *)imageFromBundleName:(NSString *)bundleName
                      imageName:(NSString *)name{
    return [UIImage imageNamed:[bundleName stringByAppendingPathComponent:name]];
}

/**
 *  等比例缩放图片
 *
 *  @param size 指定的尺寸
 *
 *  @return 返回缩放后的图片
 */
-(UIImage *)scaleToSize:(CGSize)size{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1){
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }else{
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


//这里有错误，需要处理
/**
 *  缩放图片到指定尺寸
 *
 *  @param targetSize 指定的目标尺寸
 *
 *  @return 返回图片
 */
-(UIImage *)resizeToTargetSize:(CGSize)targetSize{
    CGSize size = self.size;
    CGFloat widthRatio = targetSize.width  / self.size.width;
    CGFloat heightRatio = targetSize.height / self.size.height;
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGSize newSize = CGSizeZero;
    if(widthRatio > heightRatio) {
        newSize = CGSizeMake(scale * floor(size.width * heightRatio), scale * floor(size.height * heightRatio));
    } else {
        newSize = CGSizeMake(scale * floor(size.width * widthRatio), scale * floor(size.height * widthRatio));
    }
    CGRect rect = CGRectMake(0, 0, floor(newSize.width), floor(newSize.height));
    CGRectMake(0, 0, floor(newSize.width), floor(newSize.height));
    [self drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


/**
 *  最大化中心方块图片
 *
 *  @return 返回放大的图片
 */
-(UIImage *)largestCenteredSquareImage{
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGFloat originalWidth  = self.size.width * scale;
    CGFloat originalHeight = self.size.height * scale;
    
    CGFloat edge = CGFLOAT_MIN;
    if (originalWidth > originalHeight) {
        edge = originalHeight;
    } else {
        edge = originalWidth;
    }
    
    CGFloat posX = (originalWidth  - edge) / 2.0;
    CGFloat posY = (originalHeight - edge) / 2.0;
    
    CGRect cropSquare = CGRectMake(posX, posY, edge, edge);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, cropSquare);
    return [[UIImage alloc]initWithCGImage:imageRef scale:scale orientation:self.imageOrientation];
}


/**
 *  裁剪图片
 *
 *  @param rect 指定的尺寸
 *
 *  @return 裁剪后的图片
 */
-(UIImage*)subImageInRect:(CGRect)rect{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CFRelease(subImageRef);
    
    return smallImage;
}


/**
 *  裁剪指定尺寸的图片
 *
 *  @param rect 制定的裁剪尺寸
 *
 *  @return 返回裁剪的图片
 */
-(UIImage *)clipImageWithRect:(CGRect)rect{
    CGRect clipFrame = rect;
    CGImageRef refImage = CGImageCreateWithImageInRect(self.CGImage, clipFrame);
    UIImage *newImage = [UIImage imageWithCGImage:refImage];
    CGImageRelease(refImage);
    return newImage;
}


/**
 *  全屏显示图片
 *
 *  @param viewsize 视图的尺寸
 *
 *  @return 返回全屏尺寸图片
 */
-(UIImage *)imageFillSize:(CGSize)viewsize{
    CGSize size = self.size;
    CGFloat scalex = viewsize.width / size.width;
    CGFloat scaley = viewsize.height / size.height;
    CGFloat scale = MAX(scalex, scaley);
    
    UIGraphicsBeginImageContext(viewsize);
    
    CGFloat width = size.width * scale;
    CGFloat height = size.height * scale;
    
    float dwidth = ((viewsize.width - width) / 2.0f);
    float dheight = ((viewsize.height - height) / 2.0f);
    
    CGRect rect = CGRectMake(dwidth, dheight, size.width * scale, size.height * scale);
    [self drawInRect:rect];
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}


/**
 *  从顶部开始平铺图片
 *
 *  @param frameSize 图片尺寸
 *
 *  @return 返回平铺后的图片
 */
-(UIImage *)imageScaleAspectFillFromTop:(CGSize)frameSize{
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGFloat radio = self.size.height / self.size.width;
    CGFloat height = frameSize.height / radio;
    UIImage *adjustedImg = [self scaleToSize:CGSizeMake(frameSize.width * screenScale,
                                                        height)];
    adjustedImg = [adjustedImg subImageInRect:CGRectMake(0, 0, frameSize.width * screenScale,
                                                         frameSize.width * screenScale)];
    return adjustedImg;
}


/**
 *  设置当前图片的放大缩小尺寸
 *
 *  @return 返回尺寸
 */
-(CGRect)setMaxMinZoomScalesForCurrentBound;{
    if (!([self isKindOfClass:[UIImage class]]) || self == nil) {
        if (!([self isKindOfClass:[UIImage class]])) {
            return CGRectZero;
        }
    }
    
    CGSize boundsSize = [UIScreen mainScreen].bounds.size;
    CGSize imageSize = self.size;
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


/**
 *  调整图片方向
 *
 *  @return 返回调整后方向后的图片
 */
-(UIImage *)fixImageOrientaion{
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp)
        return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


/**
 *  修正图片的方向
 *
 *  @return 返回修正的图片的方法
 */
-(CGImageRef)correctOrientation{
    if (self.imageOrientation == UIImageOrientationDown) {
        //retaining because caller expects to own the reference
        CGImageRetain([self CGImage]);
        return [self CGImage];
    }
    UIGraphicsBeginImageContext(self.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.imageOrientation == UIImageOrientationRight) {
        CGContextRotateCTM (context, 90 * M_PI/180);
    } else if (self.imageOrientation == UIImageOrientationLeft) {
        CGContextRotateCTM (context, -90 * M_PI/180);
    } else if (self.imageOrientation == UIImageOrientationUp) {
        CGContextRotateCTM (context, 180 * M_PI/180);
    }
    
    [self drawAtPoint:CGPointMake(0, 0)];
    
    CGImageRef cgImage = CGBitmapContextCreateImage(context);
    UIGraphicsEndImageContext();
    
    return cgImage;
}


/**
 *  以指定的宽度为准裁剪图片
 *
 *  @param width 指定的宽度
 *
 *  @return 返回以裁剪后的图片
 */
-(UIImage *)resizeImageByWidth:(NSUInteger)width{
    CGImageRef imgRef = [self correctOrientation];
    CGFloat original_width  = CGImageGetWidth(imgRef);
    CGFloat original_height = CGImageGetHeight(imgRef);
    CGFloat ratio = width/original_width;
    CGImageRelease(imgRef);
    return [self drawImageInBounds: CGRectMake(0, 0, width, round(original_height * ratio))];
}



/**
 *  以制定的高度为准裁剪图片
 *
 *  @param height 指定的高度
 *
 *  @return 返回裁剪后的图片
 */
- (UIImage *)resizedImageByHeight:(NSUInteger)height{
    CGImageRef imgRef = [self correctOrientation];
    CGFloat original_width  = CGImageGetWidth(imgRef);
    CGFloat original_height = CGImageGetHeight(imgRef);
    CGFloat ratio = height/original_height;
    CGImageRelease(imgRef);
    return [self drawImageInBounds: CGRectMake(0, 0, round(original_width * ratio), height)];
}


/**
 *  以最小宽高比尺寸裁剪图片
 *
 *  @param size 指定的尺寸
 *
 *  @return 返回裁剪的图片
 */
- (UIImage *)resizedImageWithMinimumSize:(CGSize)size{
    CGImageRef imgRef = [self correctOrientation];
    CGFloat original_width  = CGImageGetWidth(imgRef);
    CGFloat original_height = CGImageGetHeight(imgRef);
    CGFloat width_ratio = size.width / original_width;
    CGFloat height_ratio = size.height / original_height;
    CGFloat scale_ratio = width_ratio > height_ratio ? width_ratio : height_ratio;
    CGImageRelease(imgRef);
    return [self drawImageInBounds: CGRectMake(0, 0, round(original_width * scale_ratio), round(original_height * scale_ratio))];
}


/**
 *  以最大宽高比尺寸裁剪图片
 *
 *  @param size 指定的尺寸
 *
 *  @return 返回裁剪的图片
 */
- (UIImage *)resizedImageWithMaximumSize:(CGSize)size{
    CGImageRef imgRef = [self correctOrientation];
    CGFloat original_width  = CGImageGetWidth(imgRef);
    CGFloat original_height = CGImageGetHeight(imgRef);
    CGFloat width_ratio = size.width / original_width;
    CGFloat height_ratio = size.height / original_height;
    CGFloat scale_ratio = width_ratio < height_ratio ? width_ratio : height_ratio;
    CGImageRelease(imgRef);
    return [self drawImageInBounds: CGRectMake(0, 0, round(original_width * scale_ratio), round(original_height * scale_ratio))];
}


/**
 *  在指定的区域中绘制图片
 *
 *  @param bounds 指定的区域
 *
 *  @return 返回绘制好的图片
 */
- (UIImage *)drawImageInBounds:(CGRect)bounds{
    UIGraphicsBeginImageContext(bounds.size);
    [self drawInRect: bounds];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
}


/**
 *  通过制定的尺寸裁剪图片
 *
 *  @param rect 指定的尺寸
 *
 *  @return 返回裁剪后图片
 */
- (UIImage*)croppedImageWithRect:(CGRect)rect{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect drawRect = CGRectMake(-rect.origin.x, -rect.origin.y, self.size.width, self.size.height);
    CGContextClipToRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
    [self drawInRect:drawRect];
    UIImage* subImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return subImage;
}

/**
 *  对图片压缩到指定大小
 *
 *  @param targetSize 指定大小
 *
 *  @return 返回压缩后的图片
 */
-(UIImage*)compressImageToSize:(CGSize)targetSize{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}


/**
 *  等比例缩放图片
 *
 *  @param scaleSize 缩放系数
 *
 *  @return 返回缩放后图片
 */
- (UIImage *)scaleImageToScale:(float)scaleSize{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scaleSize, self.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


/**
 *  自定义图片尺寸
 *
 *  @param reSize 尺寸
 *
 *  @return 返回自定义长宽的图片
 */
- (UIImage *)reSizeImageToSize:(CGSize)reSize{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [self drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}


/**
 *  存储图片到cache目录下
 *
 *  @param imageName 制定的图片名
 */
- (void)saveImageToCacheDir:(NSString *)imageName{
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    [UIImagePNGRepresentation(self) writeToFile:[cacheDir stringByAppendingPathComponent:imageName.lastPathComponent] atomically:YES];
}

/**
 *  存储图片到Document目录下
 *
 *  @param imageName 制定的图片名
 */
- (void)saveImageToDocumentDir:(NSString *)imageName{
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    [UIImagePNGRepresentation(self) writeToFile:[documentDir stringByAppendingPathComponent:imageName.lastPathComponent] atomically:YES];
}


/**
 *  存储图片到临时目录下
 *
 *  @param imageName 制定的图片名
 */
- (void)saveImageToTempDir:(NSString *)imageName{
    [UIImagePNGRepresentation(self) writeToFile:[NSTemporaryDirectory() stringByAppendingPathComponent:imageName.lastPathComponent] atomically:YES];
}

#pragma mark - AssetLaunchImage

/**
 *  当应用用Asset catalog方式做LaunchImage的时候，调用此方法获取对应设备的LaunchImage图片
 *
 *  @note 此方法可能返回nil，如果没有找到对应的图片
 *  @return 返回当前状态条方向的LaunchImage
 */
+ (UIImage *)assetLaunchImage{
    UIInterfaceOrientation statusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    return [UIImage assetLaunchImageWithOrientation:statusBarOrientation useSystemCache:YES];
}


/**
 * 获取应用的StoryBoard的LaunchImage图片
 *
 * @note 通过LaunchScreen.StoryBoard加载的本地图片 只需要两张本地图片iPhone 7和 7 plus尺寸的图取名为LaunchImage@2x.png 和LaunchImage@3x.png
 * @return 返回StoryBoard的LaunchImage，可能返回为空
 */
+ (UIImage *)getStoryBoardLaunchImage{
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    UIImageView * imageView=viewController.view.subviews[0];
    return imageView.image;
}

/**
 *  当应用用IB方式做LaunchImage的时候，调用此方法获取对应设备的LaunchImage图片
 *
 *  @return 返回当前状态条方向的LaunchImage
 */
+ (UIImage *)interfaceBuilderBasedLaunchImage{
    UIInterfaceOrientation statusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    return [UIImage interfaceBuilderBasedLaunchImageWithOrientation:statusBarOrientation useSystemCache:YES];
}


/**
 * 获取应用的Asset的LaunchImage图片
 *
 * @note 需要四张本地图片 放入LaunchImage即可,不包括横屏和竖屏
 * @return 返回Asset的LaunchImage，可能返回为空
 */
+ (UIImage *)getAssetLaunchImage{
    
    NSString *viewOrientation = @"Portrait";
//    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
//        viewOrientation = @"Landscape";
//    }
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    CGSize viewSize = [UIApplication sharedApplication].keyWindow.bounds.size;
    for (NSDictionary* dict in imagesDict){
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    return [UIImage imageNamed:launchImageName];
}




/**
 *  当应用采用IB方式创建LaunchImage的时候，采用此此方法获取对应LaunchImage
 *
 *  @note 此方法如果没有找到该图片则返回nil
 *  @param orientation 需要查找图片的方向
 *  @param cache       是否需要系统缓存该图片
 *
 *  @return 返回指定方向的LaunchImage
 */
+ (UIImage *)interfaceBuilderBasedLaunchImageWithOrientation:(UIInterfaceOrientation)orientation
                                              useSystemCache:(BOOL)cache{
    UIScreen *screen = [UIScreen mainScreen];
    CGFloat screenHeight = screen.bounds.size.height;
    CGFloat screenWidth = screen.bounds.size.width;
    BOOL portrait = UIInterfaceOrientationIsPortrait(orientation);
    if ((screenHeight > screenWidth && !portrait) || (screenWidth > screenHeight && portrait)) {
        CGFloat temp = screenWidth;
        screenWidth = screenHeight;
        screenHeight = temp;
    }
    NSMutableString *imageNameString = [NSMutableString stringWithString:kAssetImageBaseFileName];
    NSString *orientationString = portrait ? kAssetImagePortraitString : kAssetImageLandscapeLeftString;
    [imageNameString appendString:orientationString];
    
    [imageNameString appendFormat:kAssetImageSizeFormatString, screenWidth, screenHeight];
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
    NSString *pathToFile = [[NSString
                             stringWithFormat:kAssetImagePathToFileFormatString, bundleID, imageNameString] stringByExpandingTildeInPath];
    if (cache) {
        return [UIImage imageNamed:pathToFile];
    } else {
        CGFloat scale = screen.scale;
        NSData *data = [NSData dataWithContentsOfFile:pathToFile];
        return [UIImage imageWithData:data scale:scale];
    }
}



/**
 *  当应用采用Asset Catalog的方式设置LanuchImage的时候，调用此方法获取指定方向的LaunchImage
 *
 *  @note 此方法如果没有找到对应的图片则返回nil
 *  @param orientation 指定获取图片的方向
 *  @param cache       是否系统可以缓存此图片
 *
 *  @return 返回指定方向的LaunchImage
 */
+ (UIImage *)assetLaunchImageWithOrientation:(UIInterfaceOrientation)orientation useSystemCache:(BOOL)cache{
    UIScreen *screen = [UIScreen mainScreen];
    CGFloat screenHeight = screen.bounds.size.height;
    if ([screen respondsToSelector:@selector(convertRect:toCoordinateSpace:)]) {
        screenHeight = [screen.coordinateSpace convertRect:screen.bounds toCoordinateSpace:screen.fixedCoordinateSpace]
        .size.height;
    }
    CGFloat scale = screen.scale;
    BOOL portrait = UIInterfaceOrientationIsPortrait(orientation);
    BOOL isiPhone = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone);
    BOOL isiPad = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
    NSMutableString *imageNameString = [NSMutableString stringWithString:kAssetImageBaseFileName];
    if (isiPhone &&
        screenHeight > kAssetImage4inchHeight) { // currently here will be launch images for iPhone 6 and 6 plus
        [imageNameString appendString:kAssetImageiOS8Prefix];
    } else {
        [imageNameString appendString:kAssetImageiOS7Prefix];
    }
    if (scale >= kAssetImage6PlusScale || isiPad) {
        NSString *orientationString = portrait ? kAssetImagePortraitString : kAssetImageLandscapeString;
        [imageNameString appendString:orientationString];
    }
    
    if (isiPhone && screenHeight > kAssetImage35inchHeight) {
        [imageNameString appendFormat:kAssetImageHeightFormatString, screenHeight];
    }
    
    if (cache) {
        if (isiPad) {
            [imageNameString appendString:kAssetImageiPadPostfix];
        }
        return [UIImage imageNamed:imageNameString];
    } else {
        if (scale > 1) {
            [imageNameString appendFormat:kAssetImageScaleFormatString, scale];
        }
        if (isiPad) {
            [imageNameString appendString:kAssetImageiPadPostfix];
        }
        NSData *data =
        [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageNameString ofType:@"png"]];
        return [UIImage imageWithData:data scale:scale];
    }
}



/**
 *  当应用采用Asset catalog方式加载LaunchImage的时候，采用此方法获取到指定尺寸的LaunchImage
 *
 *  @note 注意此方法只能用于iOS8以上
 *  @param size  指定的尺寸
 *  @param cache 是否系统可以缓存此图片
 *
 *  @return 返回指定方向的图片
 */
+ (UIImage *)assetLaunchImageWithSize:(CGSize)size useSystemCache:(BOOL)cache{
    UIInterfaceOrientation orientation =
    (size.height > size.width) ? UIInterfaceOrientationPortrait : UIInterfaceOrientationLandscapeLeft;
    return [UIImage assetLaunchImageWithOrientation:orientation useSystemCache:cache];
}


/**
 *  当应用采用采用IB方式加载LaunchImage的时候，调用此方法获取指定图片并调用iOS8的旋转方法转换成指定尺寸的图片
 *
 *  @param size  尺寸决定旋转的方向（例如height>width则是portrait）
 *  @param cache 是否需要缓存该图片
 *
 *  @return 返回指定方向的图片
 */
+ (UIImage *)interfaceBuilderBasedLaunchImageWithSize:(CGSize)size useSystemCache:(BOOL)cache{
    UIInterfaceOrientation orientation =
    (size.height > size.width) ? UIInterfaceOrientationPortrait : UIInterfaceOrientationLandscapeLeft;
    return [UIImage interfaceBuilderBasedLaunchImageWithOrientation:orientation useSystemCache:cache];
}


/**
 将文字转换成图片
 
 @param string 文字
 @param attributes 文字书写
 @param size 文字c尺寸
 @return 返回绘制后的图片
 */
+ (UIImage *)imageFromString:(NSString *)string
                  attributes:(NSDictionary *)attributes
                        size:(CGSize)size{
    /* 使用方式
     NSString *string = @"字";
     NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
     [paragraphStyle setAlignment:NSTextAlignmentCenter];
     [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
     [paragraphStyle setLineSpacing:15.f];  //行间距
     [paragraphStyle setParagraphSpacing:2.f];//字符间距
     
     NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:12],
     NSForegroundColorAttributeName : [UIColor blueColor],
     NSBackgroundColorAttributeName : [UIColor clearColor],
     NSParagraphStyleAttributeName : paragraphStyle, };
     
     UIImage *image1  = [self imageFromString:string attributes:attributes size:imgview.bounds.size];
     */
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [string drawInRect:CGRectMake(0, 0, size.width, size.height) withAttributes:attributes];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



/**
 根据视图来创建图片
 
 @param view 传递的视图
 @return 返回创建好的图片
 */
+ (UIImage *)imageForView:(UIView *)view{
    /* 使用方式
     UILabel *temptext  = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
     temptext.text = @"好";
     temptext.textColor = [UIColor whiteColor];
     temptext.textAlignment = NSTextAlignmentCenter;
     UIImage *image  = [self imageForView:temptext];
     */
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    else
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



#pragma mark - other
/**
 *  以任意角度旋转图片
 *
 *  @param radian   给定的弧度制
 *  @param cropMode 裁切模式
 *
 *  @return 返回旋转后图片
 */
- (UIImage*)rotateImageWithRadian:(CGFloat)radian cropMode:(SvCropMode)cropMode
{
    CGSize imgSize = CGSizeMake(self.size.width * self.scale, self.size.height * self.scale);
    CGSize outputSize = imgSize;
    if (cropMode == enSvCropExpand) {
        CGRect rect = CGRectMake(0, 0, imgSize.width, imgSize.height);
        rect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeRotation(radian));
        outputSize = CGSizeMake(CGRectGetWidth(rect), CGRectGetHeight(rect));
    }
    
    UIGraphicsBeginImageContext(outputSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, outputSize.width / 2, outputSize.height / 2);
    CGContextRotateCTM(context, radian);
    CGContextTranslateCTM(context, -imgSize.width / 2, -imgSize.height / 2);
    
    [self drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


/**
 *  图片缩放
 *
 *  @param newSize    缩放的尺寸
 *  @param resizeMode 缩放的模式
 *
 *  @return 返回缩放后的图片
 */
- (UIImage*)resizeImageToSize:(CGSize)newSize resizeMode:(SvResizeMode)resizeMode
{
    CGRect drawRect = [self caculateDrawRect:newSize resizeMode:resizeMode];
    
    UIGraphicsBeginImageContext(newSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, CGRectMake(0, 0, newSize.width, newSize.height));
    
    CGContextSetInterpolationQuality(context, 0.8);
    
    [self drawInRect:drawRect blendMode:kCGBlendModeNormal alpha:1];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

// caculate drawrect respect to specific resize mode
- (CGRect)caculateDrawRect:(CGSize)newSize resizeMode:(SvResizeMode)resizeMode
{
    CGRect drawRect = CGRectMake(0, 0, newSize.width, newSize.height);
    
    CGFloat imageRatio = self.size.width / self.size.height;
    CGFloat newSizeRatio = newSize.width / newSize.height;
    
    switch (resizeMode) {
        case enSvResizeScale:
        {
            // scale to fill
            break;
        }
        case enSvResizeAspectFit:                    // any remain area is white
        {
            CGFloat newHeight = 0;
            CGFloat newWidth = 0;
            if (newSizeRatio >= imageRatio) {        // max height is newSize.height
                newHeight = newSize.height;
                newWidth = newHeight * imageRatio;
            }
            else {
                newWidth = newSize.width;
                newHeight = newWidth / imageRatio;
            }
            
            drawRect.size.width = newWidth;
            drawRect.size.height = newHeight;
            
            drawRect.origin.x = newSize.width / 2 - newWidth / 2;
            drawRect.origin.y = newSize.height / 2 - newHeight / 2;
            
            break;
        }
        case enSvResizeAspectFill:
        {
            CGFloat newHeight = 0;
            CGFloat newWidth = 0;
            if (newSizeRatio >= imageRatio) {        // max height is newSize.height
                newWidth = newSize.width;
                newHeight = newWidth / imageRatio;
            }
            else {
                newHeight = newSize.height;
                newWidth = newHeight * imageRatio;
            }
            
            drawRect.size.width = newWidth;
            drawRect.size.height = newHeight;
            
            drawRect.origin.x = newSize.width / 2 - newWidth / 2;
            drawRect.origin.y = newSize.height / 2 - newHeight / 2;
            
            break;
        }
        default:
            break;
    }
    
    return drawRect;
}



/**
 *  图片裁减
 *
 *  @param cropRect 指定的区域
 *
 *  @return 返回裁减后的图片
 */
- (UIImage*)cropImageWithRect:(CGRect)cropRect
{
    CGRect drawRect = CGRectMake(-cropRect.origin.x , -cropRect.origin.y, self.size.width * self.scale, self.size.height * self.scale);
    
    UIGraphicsBeginImageContext(cropRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, CGRectMake(0, 0, cropRect.size.width, cropRect.size.height));
    
    [self drawInRect:drawRect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  任意形状裁剪图片
 *
 *  @param pointArr 装的形状点的数组
 *
 *  @return 返回裁减后的图片
 */
- (UIImage*)cropImageWithPath:(NSArray*)pointArr
{
    if (pointArr.count == 0) {
        return nil;
    }
    
    CGPoint *points = malloc(sizeof(CGPoint) * pointArr.count);
    for (int i = 0; i < pointArr.count; ++i) {
        points[i] = [[pointArr objectAtIndex:i] CGPointValue];
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * self.scale, self.size.height * self.scale));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    CGContextAddLines(context, points, pointArr.count);
    CGContextClosePath(context);
    CGRect boundsRect = CGContextGetPathBoundingBox(context);
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(boundsRect.size);
    context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, CGRectMake(0, 0, boundsRect.size.width, boundsRect.size.height));
    
    CGMutablePathRef  path = CGPathCreateMutable();
    CGAffineTransform transform = CGAffineTransformMakeTranslation(-boundsRect.origin.x, -boundsRect.origin.y);
    CGPathAddLines(path, &transform, points, pointArr.count);
    
    CGContextBeginPath(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    [self drawInRect:CGRectMake(-boundsRect.origin.x, -boundsRect.origin.y, self.size.width * self.scale, self.size.height * self.scale)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGPathRelease(path);
    UIGraphicsEndImageContext();
    
    return image;
}



/**
 *  使用像素创建UIImage
 *
 *  @param data      给定的像素数据
 *  @param width     宽度
 *  @param height    高度
 *  @param alphaInfo alpha信息
 *
 *  @return 返回创建的图片
 */
+ (UIImage*)createImageWithData:(Byte*)data width:(NSInteger)width height:(NSInteger)height alphaInfo:(CGImageAlphaInfo)alphaInfo
{
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    if (!colorSpaceRef) {
        NSLog(@"Create ColorSpace Error!");
    }
    CGContextRef bitmapContext = CGBitmapContextCreate(data, width, height, 8, width * 4, colorSpaceRef, kCGImageAlphaPremultipliedLast);
    if (!bitmapContext) {
        NSLog(@"Create Bitmap context Error!");
        CGColorSpaceRelease(colorSpaceRef);
        return nil;
    }
    
    CGImageRef imageRef = CGBitmapContextCreateImage(bitmapContext);
    UIImage *image = [[UIImage alloc] initWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    CGColorSpaceRelease(colorSpaceRef);
    CGContextRelease(bitmapContext);
    
    return image;
}

/*===========================================================*/

/*
 * @图片逆时针旋转90度
 */
- (UIImage*)rotate90CounterClockwise
{
    UIImage *image = nil;
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeft];
            break;
        }
        case UIImageOrientationDown:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRight];
            break;
        }
        case UIImageOrientationLeft:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDown];
            break;
        }
        case UIImageOrientationRight:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUp];
            break;
        }
        case UIImageOrientationUpMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRightMirrored];
            break;
        }
        case UIImageOrientationDownMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeftMirrored];
            break;
        }
        case UIImageOrientationLeftMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUpMirrored];
            break;
        }
        case UIImageOrientationRightMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDownMirrored];
            break;
        }
        default:
            break;
    }
    
    return image;
}

/*
 * @图片顺时针旋转90度
 */
- (UIImage*)rotate90Clockwise
{
    UIImage *image = nil;
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRight];
            break;
        }
        case UIImageOrientationDown:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeft];
            break;
        }
        case UIImageOrientationLeft:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUp];
            break;
        }
        case UIImageOrientationRight:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDown];
            break;
        }
        case UIImageOrientationUpMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeftMirrored];
            break;
        }
        case UIImageOrientationDownMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRightMirrored];
            break;
        }
        case UIImageOrientationLeftMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDownMirrored];
            break;
        }
        case UIImageOrientationRightMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUpMirrored];
            break;
        }
        default:
            break;
    }
    
    return image;
}

/*
 * @图片旋转180度
 */
- (UIImage*)rotate180
{
    UIImage *image = nil;
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDown];
            break;
        }
        case UIImageOrientationDown:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUp];
            break;
        }
        case UIImageOrientationLeft:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRight];
            break;
        }
        case UIImageOrientationRight:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeft];
            break;
        }
        case UIImageOrientationUpMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDownMirrored];
            break;
        }
        case UIImageOrientationDownMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUpMirrored];
            break;
        }
        case UIImageOrientationLeftMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRightMirrored];
            break;
        }
        case UIImageOrientationRightMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeftMirrored];
            break;
        }
        default:
            break;
    }
    
    return image;
}

/*
 * @图片旋转到正上方，也就是默认方向
 */
- (UIImage*)rotateImageToOrientationUp
{
    CGSize size = CGSizeMake(self.size.width * self.scale, self.size.height * self.scale);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, CGRectMake(0, 0, size.width, size.height));
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/*
 * @图片水平翻转
 */
- (UIImage*)flipHorizontal
{
    UIImage *image = nil;
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUpMirrored];
            break;
        }
        case UIImageOrientationDown:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDownMirrored];
            break;
        }
        case UIImageOrientationLeft:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRightMirrored];
            break;
        }
        case UIImageOrientationRight:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeftMirrored];
            break;
        }
        case UIImageOrientationUpMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUp];
            break;
        }
        case UIImageOrientationDownMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDown];
            break;
        }
        case UIImageOrientationLeftMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRight];
            break;
        }
        case UIImageOrientationRightMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeft];
            break;
        }
        default:
            break;
    }
    
    return image;
}

/*
 * @图片垂直翻转
 */
- (UIImage*)flipVertical
{
    UIImage *image = nil;
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDownMirrored];
            break;
        }
        case UIImageOrientationDown:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUpMirrored];
            break;
        }
        case UIImageOrientationLeft:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeftMirrored];
            break;
        }
        case UIImageOrientationRight:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRightMirrored];
            break;
        }
        case UIImageOrientationUpMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDown];
            break;
        }
        case UIImageOrientationDownMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUp];
            break;
        }
        case UIImageOrientationLeftMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeft];
            break;
        }
        case UIImageOrientationRightMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRight];
            break;
        }
        default:
            break;
    }
    
    return image;
}

/*
 * @图片水平垂直都翻转
 */
- (UIImage*)flipAll
{
    return [self rotate180];
}

/**
 * @横向拼接图片
 */
- (UIImage *)jointImage:(UIImage *)image{
    CGSize size= CGSizeMake(self.size.width+image.size.width,self.size.height);
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [image drawInRect:CGRectMake(self.size.width, 0, image.size.width, image.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}


/*===========================================================*/

/**
 *  倒影图片
 *
 *  @return 返回倒影图片
 */
- (UIImage *)reflectionImage{
    // create a bitmap graphics context the size of the image
    CGContextRef mainViewContentContext = MyCreateBitmapContext(self.size.width, self.size.height);
    // In order to grab the part of the image that we want to render, we move the context origin to the
    // height of the image that we want to capture, then we flip the context so that the image draws upside down.
    CGContextTranslateCTM(mainViewContentContext, 0.0, self.size.height);
    CGContextScaleCTM(mainViewContentContext, 1.0, -1.0);
    
    // draw the image into the bitmap context
    CGContextDrawImage(mainViewContentContext, CGRectMake(0, 0, self.size.width, self.size.height), [self CGImage]);
    
    CGImageRef reflectionImage = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);
    
    // convert the finished reflection image to a UIImage
    UIImage * theImage = [UIImage imageWithCGImage:reflectionImage];
    // image is retained by the property setting above, so we can release the original
    CGImageRelease(reflectionImage);
    
    return theImage;
}

static CGContextRef MyCreateBitmapContext (int pixelsWide, int pixelsHigh) {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create the bitmap context
    CGContextRef bitmapContext = CGBitmapContextCreate (NULL, pixelsWide, pixelsHigh, 8,
                                                        0, colorSpace,
                                                        // this will give us an optimal BGRA format for the device:
                                                        (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    CGColorSpaceRelease(colorSpace);
    
    return bitmapContext;
}


#pragma mark - blur
/**
 *  模糊图片
 *
 *  @param blur 模糊度
 *
 *  @return 返回模糊后的图片
 */
- (UIImage *)boxblurImageWithBlur:(CGFloat)blur{
    //将图片转换成JPG,因为需要模糊，不需要透明和apla通道
    NSData *imageData = UIImageJPEGRepresentation(self, 1);
    UIImage* destImage = [UIImage imageWithData:imageData];
    
    //初始化图片输入输出缓冲，错误，像素缓冲参数
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = destImage.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    //将CGimageRef转换成图片缓冲数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //获取图片长宽，以及行字节，字节指针等数据
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    
    //创建图片输出缓冲
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    
    // 创建输入和输出流的中间缓冲用于处理图片的缓冲过度
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    
    //执行计算
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //清理数据
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    return returnImage;
    
}


/**
 *  快速模糊图片
 *
 *  @return 返回模糊后他图片
 */
- (UIImage *)imgWithBlur{
    return [self imgWithLightAlpha:0.1 radius:10 colorSaturationFactor:1];
}


/**
 *  通过指定的参数模糊图片
 *
 *  @param alpha                 透明度0~1，0为白，1为深灰色
 *  @param radius                模糊半径，默认是30，推荐3，半径越大越模糊，值越小越清楚
 *  @param colorSaturationFactor 色彩饱和度因子0~9，0是无彩色黑白灰，9是最鲜明的浓彩色，1是原色，默认1.8
 *
 *  @return 返回模糊后的图片
 */
- (UIImage *)imgWithLightAlpha:(CGFloat)alpha
                        radius:(CGFloat)radius
         colorSaturationFactor:(CGFloat)colorSaturationFactor{
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:alpha];
    return [self imgBluredWithRadius:radius tintColor:tintColor saturationDeltaFactor:colorSaturationFactor maskImage:nil];
}



/**
 *  模糊特效核心代码,封装了毛玻璃效果 参数:半径,颜色,色彩饱和度
 *
 *  @param blurRadius            模糊半径
 *  @param tintColor             渲染颜色
 *  @param saturationDeltaFactor 颜色饱和度因子
 *  @param maskImage             遮罩图片
 *
 *  @return 返回渲染模糊后的图片
 */
- (UIImage *)imgBluredWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage{
    
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            uint32_t radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // 开启上下文 用于输出图像
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // 开始画底图
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // 开始画模糊效果
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // 添加颜色渲染
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // 输出成品,并关闭上下文
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}


/**
 *  截屏方法1(截取整个屏幕)
 *
 *  @return 截屏的图片
 */
+ (UIImage *)screenShot{
    
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    CGFloat screen_height = [UIScreen mainScreen].bounds.size.height;
    CGFloat screen_scale = [UIScreen mainScreen].scale;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(screen_width * screen_scale, screen_height * screen_scale), YES, 0);
    [[[[UIApplication sharedApplication] keyWindow] layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef imageRef = viewImage.CGImage;
    CGRect rect = CGRectMake(0, 0, screen_width * screen_scale, screen_height * screen_scale);
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    return sendImage;
}


/**
 *  通过指定的颜色模板去创建一个新的图片对象
 *
 *  @param color 指定的颜色，必须不能为nil
 *
 *  @return 返回作色后的图片
 */
- (UIImage *)maskImageWithColor:(UIColor *)color{
    NSParameterAssert(color != nil);
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    UIImage *newImage = nil;
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(context, 1.0f, -1.0f);
        CGContextTranslateCTM(context, 0.0f, -(imageRect.size.height));
        
        CGContextClipToMask(context, imageRect, self.CGImage);
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, imageRect);
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    return newImage;
}


/**
 *  通过指定颜色渲染图片
 *
 *  @param tintColor 渲染颜色
 *
 *  @return 返回渲染的图片
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor{
    //保留住透明度，不透明参数，缩放因子
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    //绘制渲染色图片
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}


#pragma mark - animatedGIF

static int delayCentisecondsForImageAtIndex(CGImageSourceRef const source, size_t const i) {
    int delayCentiseconds = 1;
    CFDictionaryRef const properties = CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
    if (properties) {
        CFDictionaryRef const gifProperties = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
        if (gifProperties) {
            NSNumber *number = fromCF CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFUnclampedDelayTime);
            if (number == NULL || [number doubleValue] == 0) {
                number = fromCF CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFDelayTime);
            }
            if ([number doubleValue] > 0) {
                // Even though the GIF stores the delay as an integer number of centiseconds, ImageIO “helpfully” converts that to seconds for us.
                delayCentiseconds = (int)lrint([number doubleValue] * 100);
            }
        }
        CFRelease(properties);
    }
    return delayCentiseconds;
}

static void createImagesAndDelays(CGImageSourceRef source, size_t count, CGImageRef imagesOut[count], int delayCentisecondsOut[count]) {
    for (size_t i = 0; i < count; ++i) {
        imagesOut[i] = CGImageSourceCreateImageAtIndex(source, i, NULL);
        delayCentisecondsOut[i] = delayCentisecondsForImageAtIndex(source, i);
    }
}

static int sum(size_t const count, int const *const values) {
    int theSum = 0;
    for (size_t i = 0; i < count; ++i) {
        theSum += values[i];
    }
    return theSum;
}

static int pairGCD(int a, int b) {
    if (a < b)
        return pairGCD(b, a);
    while (true) {
        int const r = a % b;
        if (r == 0)
            return b;
        a = b;
        b = r;
    }
}

static int vectorGCD(size_t const count, int const *const values) {
    int gcd = values[0];
    for (size_t i = 1; i < count; ++i) {
        // Note that after I process the first few elements of the vector, `gcd` will probably be smaller than any remaining element.  By passing the smaller value as the second argument to `pairGCD`, I avoid making it swap the arguments.
        gcd = pairGCD(values[i], gcd);
    }
    return gcd;
}

static NSArray *frameArray(size_t const count, CGImageRef const images[count], int const delayCentiseconds[count], int const totalDurationCentiseconds) {
    int const gcd = vectorGCD(count, delayCentiseconds);
    size_t const frameCount = totalDurationCentiseconds / gcd;
    UIImage *frames[frameCount];
    for (size_t i = 0, f = 0; i < count; ++i) {
        UIImage *const frame = [UIImage imageWithCGImage:images[i]];
        for (size_t j = delayCentiseconds[i] / gcd; j > 0; --j) {
            frames[f++] = frame;
        }
    }
    return [NSArray arrayWithObjects:frames count:frameCount];
}

static void releaseImages(size_t const count, CGImageRef const images[count]) {
    for (size_t i = 0; i < count; ++i) {
        CGImageRelease(images[i]);
    }
}

static UIImage *animatedImageWithAnimatedGIFImageSource(CGImageSourceRef const source) {
    size_t const count = CGImageSourceGetCount(source);
    CGImageRef images[count];
    int delayCentiseconds[count]; // in centiseconds
    createImagesAndDelays(source, count, images, delayCentiseconds);
    int const totalDurationCentiseconds = sum(count, delayCentiseconds);
    NSArray *const frames = frameArray(count, images, delayCentiseconds, totalDurationCentiseconds);
    UIImage *const animation = [UIImage animatedImageWithImages:frames duration:(NSTimeInterval)totalDurationCentiseconds / 100.0];
    releaseImages(count, images);
    return animation;
}

static UIImage *animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceRef CF_RELEASES_ARGUMENT source) {
    if (source) {
        UIImage *const image = animatedImageWithAnimatedGIFImageSource(source);
        CFRelease(source);
        return image;
    } else {
        return nil;
    }
}

/**
 *  播放图片动画
 *
 *  @param data GIF图片数据，因为在GIF图片中每一帧都存储一个分割数据在每一厘秒单位
 *                 然而每一帧仅仅只有一张图片，并且整个周期是一个浮点数
 *                 为了处理这种匹配，我们把每一张从GIF中获取到的图片加到图片周期动画
 *
 *  @example 假如GIF包含三帧，从第零帧要经过3厘秒，第一帧需要9厘秒，第二帧需要15厘秒
 *           然后用每一帧的周期除以所有帧的周期时间的最大公分母，也就是3然后加上每一帧的结果时间
 *           比如第零帧3/3=1,接下来第一帧9/3=3,接下来第二帧15/3=5
 *
 *  @return 返回动画的每一帧率的图片
 */
+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)data {
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithData(toCF data, NULL));
}


/**
 *  播放来自URL的的动画GIF，，也就是通过指定的GIF资源图片创建图片
 *
 *  @param url GIF资源图片地址，这里传递一张涂点的定位资源地址即可
 *
 *  @note 像上面的方法[UIImage animatedImageWithAnimatedGIFData:]，这里只是从theURL去读
 *        如果theURL不是文件，你可能需要在后台线程或者GCD对垒中调用去避免主线程阻塞
 *
 *  @return 返回创建的图片
 */
+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)url {
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithURL(toCF url, NULL));
}

@end
