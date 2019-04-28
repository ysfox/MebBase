//
//  UIImage+Extension.h
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

#import <UIKit/UIKit.h>

enum {
    enSvCropClip,               // clip模式下，旋转后的图片和原图一样大，部分图片区域会被裁剪掉
    enSvCropExpand,             // expand模式下，旋转后的图片可能会比原图大，所有的图片信息都会保留，剩下的区域会是全透明的
};
typedef NSInteger SvCropMode;

enum {
    enSvResizeScale,            // 拉伸填充。即不管目标尺寸中宽高的比例如何，我们都将对原图进行拉伸，使之充满整个目标图像
    enSvResizeAspectFit,        // 保持比例显示。即缩放后尽量使原图最大，同事维持原图本身的比例，剩余区域将会做全透明的填充
    enSvResizeAspectFill,       // 保持比例填充。即缩放后的图像依旧保持原图比例的基础上进行填充，部分图片可能会被裁剪
};
typedef NSInteger SvResizeMode;

@interface UIImage (Extension)

/**
 *  圆形图片
 *
 *  @return 返回圆形图片
 */
- (instancetype)circleImage;



/**
 *  返回原始模式的图片
 *
 *  @param name 图片的名称
 *
 *  @return 返回原始模式的图片
 */
+ (UIImage *)originImageWithName:(NSString *)name;



/**
 *  返回中心拉伸的图片
 *
 *  @param name 图片的名称
 *
 *  @return 返回拉伸的图片
 */
+(UIImage *)stretchedImageWithName:(NSString *)name;



/**
 *  颜色转换成图像
 *
 *  @param color 给定的颜色
 *
 *  @return 返回返回创建的图片
 */
+(UIImage *)imageFromColor:(UIColor *)color;


/**
 *  颜色转换成图像
 *
 *  @param color 给定指定的颜色
 *  @param size  给定指定的尺寸
 *
 *  @return 返回创建的图片
 */
+(UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size;


/**
 *  从指定的包种获取到对应的名称的图片
 *
 *  @param bundleName 指定的包名称
 *  @param name       指定的图片的名称
 *
 *  @return 返回对应的图片
 */
+(UIImage *)imageFromBundleName:(NSString *)bundleName
                      imageName:(NSString *)name;

/**
 *  等比例缩放图片
 *
 *  @param size 指定的尺寸
 *
 *  @return 返回缩放后的图片
 */
-(UIImage *)scaleToSize:(CGSize)size;

/**
 *  缩放图片到指定尺寸
 *
 *  @param targetSize 指定的目标尺寸
 *
 *  @return 返回图片
 */
-(UIImage *)resizeToTargetSize:(CGSize)targetSize;


/**
 *  最大化中心方块图片
 *
 *  @return 返回放大的图片
 */
-(UIImage *)largestCenteredSquareImage;


/**
 *  裁剪图片
 *
 *  @param rect 指定的尺寸
 *
 *  @return 裁剪后的图片
 */
-(UIImage*)subImageInRect:(CGRect)rect;


/**
 *  裁剪指定尺寸的图片
 *
 *  @param rect 制定的裁剪尺寸
 *
 *  @return 返回裁剪的图片
 */
-(UIImage *)clipImageWithRect:(CGRect)rect;


/**
 *  全屏显示图片
 *
 *  @param viewsize 视图的尺寸
 *
 *  @return 返回全屏尺寸图片
 */
-(UIImage *)imageFillSize:(CGSize)viewsize;


/**
 *  从顶部开始平铺图片
 *
 *  @param frameSize 图片尺寸
 *
 *  @return 返回平铺后的图片
 */
-(UIImage *)imageScaleAspectFillFromTop:(CGSize)frameSize;


/**
 *  设置当前图片的放大缩小尺寸
 *
 *  @return 返回尺寸
 */
-(CGRect)setMaxMinZoomScalesForCurrentBound;


/**
 *  调整图片方向
 *
 *  @return 返回调整后方向后的图片
 */
-(UIImage *)fixImageOrientaion;

/**
 *  修正图片的方向
 *
 *  @return 返回修正的图片的方法
 */
-(CGImageRef)correctOrientation;


/**
 *  以指定的宽度为准裁剪图片
 *
 *  @param width 指定的宽度
 *
 *  @return 返回以裁剪后的图片
 */
-(UIImage *)resizeImageByWidth:(NSUInteger)width;


/**
 *  以制定的高度为准裁剪图片
 *
 *  @param height 指定的高度
 *
 *  @return 返回裁剪后的图片
 */
- (UIImage *)resizedImageByHeight:(NSUInteger)height;


/**
 *  以最小宽高比尺寸裁剪图片
 *
 *  @param size 指定的尺寸
 *
 *  @return 返回裁剪的图片
 */
- (UIImage *)resizedImageWithMinimumSize:(CGSize)size;



/**
 *  以最大宽高比尺寸裁剪图片
 *
 *  @param size 指定的尺寸
 *
 *  @return 返回裁剪的图片
 */
- (UIImage *)resizedImageWithMaximumSize:(CGSize)size;


/**
 *  在指定的区域中绘制图片
 *
 *  @param bounds 指定的区域
 *
 *  @return 返回绘制好的图片
 */
- (UIImage *)drawImageInBounds:(CGRect)bounds;


/**
 *  通过制定的尺寸裁剪图片
 *
 *  @param rect 指定的尺寸
 *
 *  @return 返回裁剪后图片
 */
- (UIImage*)croppedImageWithRect:(CGRect)rect;

/**
 *  对图片压缩到指定大小
 *
 *  @param targetSize 指定大小
 *
 *  @return 返回压缩后的图片
 */
-(UIImage*)compressImageToSize:(CGSize)targetSize;


/**
 *  等比例缩放图片
 *
 *  @param scaleSize 缩放系数
 *
 *  @return 返回缩放后图片
 */
- (UIImage *)scaleImageToScale:(float)scaleSize;


/**
 *  自定义图片尺寸
 *
 *  @param reSize 尺寸
 *
 *  @return 返回自定义长宽的图片
 */
- (UIImage *)reSizeImageToSize:(CGSize)reSize;


/**
 *  存储图片到cache目录下
 *
 *  @param imageName 制定的图片名
 */
- (void)saveImageToCacheDir:(NSString *)imageName;


/**
 *  存储图片到Document目录下
 *
 *  @param imageName 制定的图片名
 */
- (void)saveImageToDocumentDir:(NSString *)imageName;


/**
 *  存储图片到临时目录下
 *
 *  @param imageName 制定的图片名
 */
- (void)saveImageToTempDir:(NSString *)imageName;

#pragma mark - AssetLaunchImage

/**
 *  当应用用Asset catalog方式做LaunchImage的时候，调用此方法获取对应设备的LaunchImage图片
 *
 *  @note 此方法可能返回nil，如果没有找到对应的图片
 *  @return 返回当前状态条方向的LaunchImage
 */
+ (UIImage *)assetLaunchImage;

/**
 *  当应用用IB方式做LaunchImage的时候，调用此方法获取对应设备的LaunchImage图片
 *
 *  @return 返回当前状态条方向的LaunchImage
 */
+ (UIImage *)interfaceBuilderBasedLaunchImage;


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
                                              useSystemCache:(BOOL)cache;


/**
 *  当应用采用Asset Catalog的方式设置LanuchImage的时候，调用此方法获取指定方向的LaunchImage
 *
 *  @note 此方法如果没有找到对应的图片则返回nil
 *  @param orientation 指定获取图片的方向
 *  @param cache       是否系统可以缓存此图片
 *
 *  @return 返回指定方向的LaunchImage
 */
+ (UIImage *)assetLaunchImageWithOrientation:(UIInterfaceOrientation)orientation useSystemCache:(BOOL)cache;


/**
 *  当应用采用Asset catalog方式加载LaunchImage的时候，采用此方法获取到指定尺寸的LaunchImage
 *
 *  @note 注意此方法只能用于iOS8以上
 *  @param size  指定的尺寸
 *  @param cache 是否系统可以缓存此图片
 *
 *  @return 返回指定方向的图片
 */
+ (UIImage *)assetLaunchImageWithSize:(CGSize)size useSystemCache:(BOOL)cache;


/**
 *  当应用采用采用IB方式加载LaunchImage的时候，调用此方法获取指定图片并调用iOS8的旋转方法转换成指定尺寸的图片
 *
 *  @param size  尺寸决定旋转的方向（例如height>width则是portrait）
 *  @param cache 是否需要缓存该图片
 *
 *  @return 返回指定方向的图片
 */
+ (UIImage *)interfaceBuilderBasedLaunchImageWithSize:(CGSize)size useSystemCache:(BOOL)cache;



/**
 将文字转换成图片
 
 @param string 文字
 @param attributes 文字书写
 @param size 文字c尺寸
 @return 返回绘制后的图片
 */
+ (UIImage *)imageFromString:(NSString *)string
                  attributes:(NSDictionary *)attributes
                        size:(CGSize)size;


/**
 根据视图来创建图片
 
 @param view 传递的视图
 @return 返回创建好的图片
 */
+ (UIImage *)imageForView:(UIView *)view;

#pragma mark - other
/**
 *  以任意角度旋转图片
 *
 *  @param radian   给定的弧度制
 *  @param cropMode 裁切模式
 *
 *  @return 返回旋转后图片
 */
- (UIImage*)rotateImageWithRadian:(CGFloat)radian cropMode:(SvCropMode)cropMode;


/**
 *  图片缩放
 *
 *  @param newSize    缩放的尺寸
 *  @param resizeMode 缩放的模式
 *
 *  @return 返回缩放后的图片
 */
- (UIImage*)resizeImageToSize:(CGSize)newSize resizeMode:(SvResizeMode)resizeMode;



/**
 *  图片裁减
 *
 *  @param cropRect 指定的区域
 *
 *  @return 返回裁减后的图片
 */
- (UIImage*)cropImageWithRect:(CGRect)cropRect;


/**
 *  任意形状裁剪图片
 *
 *  @param pointArr 装的形状点的数组
 *
 *  @return 返回裁减后的图片
 */
- (UIImage*)cropImageWithPath:(NSArray*)pointArr;




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
+ (UIImage*)createImageWithData:(Byte*)data width:(NSInteger)width height:(NSInteger)height alphaInfo:(CGImageAlphaInfo)alphaInfo;



/*===========================================================*/

/*
 * @图片顺时针旋转90度
 */
- (UIImage*)rotate90Clockwise;

/*
 * @图片逆时针旋转90度
 */
- (UIImage*)rotate90CounterClockwise;

/*
 * @图片旋转180度
 */
- (UIImage*)rotate180;

/*
 * @图片旋转到正上方，也就是默认方向
 */
- (UIImage*)rotateImageToOrientationUp;

/*
 * @图片水平翻转
 */
- (UIImage*)flipHorizontal;

/*
 * @图片垂直翻转
 */
- (UIImage*)flipVertical;

/*
 * @图片水平垂直都翻转
 */
- (UIImage*)flipAll;


/**
 * @拼接图片
 */
- (UIImage *)jointImage:(UIImage *)image;


/*===========================================================*/
/**
 *  倒影图片
 *
 *  @return 返回倒影图片
 */
- (UIImage *)reflectionImage;



#pragma mark - blur
/**
 *  模糊图片
 *
 *  @param blur 模糊度
 *
 *  @return 返回模糊后的图片
 */
- (UIImage *)boxblurImageWithBlur:(CGFloat)blur;


/**
 *  快速模糊图片
 *
 *  @return 返回模糊后他图片
 */
- (UIImage *)imgWithBlur;

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
         colorSaturationFactor:(CGFloat)colorSaturationFactor;


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
                       maskImage:(UIImage *)maskImage;



#pragma mark - other

/**
 *  截屏方法1(截取整个屏幕)
 *
 *  @return 截屏的图片
 */
+ (UIImage *)screenShot;



/**
 *  通过指定的颜色模板去创建一个新的图片对象
 *
 *  @param color 指定的颜色，必须不能为nil
 *
 *  @return 返回作色后的图片
 */
- (UIImage *)maskImageWithColor:(UIColor *)color;


/**
 *  通过指定颜色渲染图片
 *
 *  @param tintColor 渲染颜色
 *
 *  @return 返回渲染的图片
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;



#pragma mark - animatedGIF

/**
 *  播放图片动画
 *
 *  @param theData GIF图片数据，因为在GIF图片中每一帧都存储一个分割数据在每一厘秒单位
 *                 然而每一帧仅仅只有一张图片，并且整个周期是一个浮点数
 *                 为了处理这种匹配，我们把每一张从GIF中获取到的图片加到图片周期动画
 *
 *  @example 假如GIF包含三帧，从第零帧要经过3厘秒，第一帧需要9厘秒，第二帧需要15厘秒
 *           然后用每一帧的周期除以所有帧的周期时间的最大公分母，也就是3然后加上每一帧的结果时间
 *           比如第零帧3/3=1,接下来第一帧9/3=3,接下来第二帧15/3=5
 *
 *  @return 返回动画的每一帧率的图片
 */
+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)theData;


/**
 *  播放来自URL的的动画GIF，，也就是通过指定的GIF资源图片创建图片
 *
 *  @param theURL GIF资源图片地址，这里传递一张涂点的定位资源地址即可
 *
 *  @note 像上面的方法[UIImage animatedImageWithAnimatedGIFData:]，这里只是从theURL去读
 *        如果theURL不是文件，你可能需要在后台线程或者GCD对垒中调用去避免主线程阻塞
 *
 *  @return 返回创建的图片
 */
+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)theURL;

@end

