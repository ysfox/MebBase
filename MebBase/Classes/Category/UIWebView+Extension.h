//
//  UIWebView+Extension.h
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

#import <UIKit/UIKit.h>

@interface UIWebView (Extension)


#pragma mark - 获取网页中的数据

/**
 *  获取某个标签的结点个数
 *
 *  @param tag 节点名称
 *
 *  @return 返回节点索引
 */
- (int)nodeCountOfTag:(NSString *)tag;

/**
 *  获取当前页面URL
 *
 *  @return 返回当前页面URL
 */
- (NSString *) getCurrentURL;

/**
 *  获取标题
 *
 *  @return 返回标题
 */
- (NSString *) getTitle;

/**
 *  获取图片
 *
 *  @return 返回图片
 */
- (NSArray *) getImgs;

/**
 *  获取当前页面所有链接
 *
 *  @return 返回获前页面所有链接
 */
- (NSArray *) getOnClicks;

#pragma mark - 改变网页样式和行为
/**
 *  改变背景颜色
 *
 *  @param color 颜色对象
 */
- (void) setDomBackgroundColor:(UIColor *)color;

/**
 *  为所有图片添加点击事件(网页中有些图片添加无效)
 */
- (void) addClickEventOnImg;

/**
 *  改变所有图像的宽度
 *
 *  @param size 尺寸
 */
- (void) setImgWidth:(int)size;

/**
 *  改变所有图像的高度
 *
 *  @param size 尺寸
 */
- (void) setImgHeight:(int)size;

/**
 *  改变指定标签的字体颜色
 *
 *  @param color   颜色
 *  @param tagName 标签名称
 */
- (void) setFontColor:(UIColor *) color withTag:(NSString *)tagName;

/**
 *  改变指定标签的字体大小
 *
 *  @param size    尺寸
 *  @param tagName 标签名称
 */
- (void) setFontSize:(int) size withTag:(NSString *)tagName;


#pragma mark 在网页上画图
/**
 *  创建一个指定大小的画布
 *
 *  @param canvasId canvas的id名称
 *  @param width    宽度
 *  @param height   高度
 */
- (void)createCanvas:(NSString *)canvasId
               width:(NSInteger)width
              height:(NSInteger)height;

/**
 *  在指定位置创建一个指定大小的画布
 *
 *  @param canvasId canvas的id名称
 *  @param width    宽度
 *  @param height   高度
 *  @param x        x
 *  @param y        y
 */
- (void)createCanvas:(NSString *)canvasId
               width:(NSInteger)width
              height:(NSInteger)height
                   x:(NSInteger)x
                   y:(NSInteger)y;

/**
 *  绘制矩形填充  context.fillRect(x,y,width,height)
 *
 *  @param canvasId canvas的id名称
 *  @param x        x
 *  @param y        y
 *  @param width    宽度
 *  @param height   高度
 *  @param color    颜色
 */
- (void)fillRectOnCanvas:(NSString *)canvasId
                       x:(NSInteger)x
                       y:(NSInteger)y
                   width:(NSInteger)width
                  height:(NSInteger)height
                 uicolor:(UIColor *)color;

/**
 *  绘制矩形边框  context.strokeRect(x,y,width,height)
 *
 *  @param canvasId  canvas的id名称
 *  @param x         x
 *  @param y         y
 *  @param width     宽度
 *  @param height    高度
 *  @param color     颜色
 *  @param lineWidth 线宽
 */
- (void)strokeRectOnCanvas:(NSString *)canvasId
                         x:(NSInteger)x
                         y:(NSInteger)y
                     width:(NSInteger)width
                    height:(NSInteger)height
                   uicolor:(UIColor *)color
                 lineWidth:(NSInteger)lineWidth;


/**
 *  清除矩形区域  context.clearRect(x,y,width,height)
 *
 *  @param canvasId canvas的id名称
 *  @param x        x
 *  @param y        y
 *  @param width    宽度
 *  @param height   高度
 */
- (void)clearRectOnCanvas:(NSString *)canvasId
                        x:(NSInteger)x
                        y:(NSInteger)y
                    width:(NSInteger)width
                   height:(NSInteger) height;


/**
 *  绘制圆弧填充  context.arc(x, y, radius, starAngle,endAngle, anticlockwise)
 *
 *  @param canvasId      canvas的id名称
 *  @param x             x
 *  @param y             y
 *  @param r             半径
 *  @param startAngle    开始角度
 *  @param endAngle      结束角度
 *  @param anticlockwise 顺时针还是逆时针
 *  @param color         颜色
 */
- (void)arcOnCanvas:(NSString *)canvasId
            centerX:(NSInteger)x
            centerY:(NSInteger)y
             radius:(NSInteger)r
         startAngle:(float)startAngle
           endAngle:(float)endAngle
      anticlockwise:(BOOL)anticlockwise
            uicolor:(UIColor *)color;

/**
 *  绘制一条线段 context.moveTo(x,y)  context.lineTo(x,y)
 *
 *  @param canvasId  canvas的id名称
 *  @param x1        x
 *  @param y1        y
 *  @param x2        y
 *  @param y2        y
 *  @param color     颜色
 *  @param lineWidth 现款
 */
- (void)lineOnCanvas:(NSString *)canvasId
                  x1:(NSInteger)x1
                  y1:(NSInteger)y1
                  x2:(NSInteger)x2
                  y2:(NSInteger)y2
             uicolor:(UIColor *)color
           lineWidth:(NSInteger)lineWidth;

/**
 *  绘制一条折线
 *
 *  @param canvasId  canvas的id名称
 *  @param points    锚点
 *  @param color     颜色
 *  @param lineWidth 线宽
 */
- (void)linesOnCanvas:(NSString *)canvasId
               points:(NSArray *)points
             unicolor:(UIColor *)color
            lineWidth:(NSInteger)lineWidth;

/**
 *  绘制贝塞尔曲线 context.bezierCurveTo(cp1x,cp1y,cp2x,cp2y,x,y)
 *
 *  @param canvasId  canvas的id名称
 *  @param x1        x1
 *  @param y1        y1
 *  @param cp1x      cp1x
 *  @param cp1y      cp1y
 *  @param cp2x      cp2x
 *  @param cp2y      cp2y
 *  @param x2        x2
 *  @param y2        y2
 *  @param color     颜色
 *  @param lineWidth 线宽
 */
- (void)bezierCurveOnCanvas:(NSString *)canvasId
                         x1:(NSInteger)x1
                         y1:(NSInteger)y1
                       cp1x:(NSInteger)cp1x
                       cp1y:(NSInteger)cp1y
                       cp2x:(NSInteger)cp2x
                       cp2y:(NSInteger)cp2y
                         x2:(NSInteger)x2
                         y2:(NSInteger)y2
                   unicolor:(UIColor *)color
                  lineWidth:(NSInteger)lineWidth;




/**
 在webview上绘制canvas
 
 @param src 图片地址
 @param canvasId 要绘制canvas的元素id
 @param sx sx
 @param sy sy
 @param sw sw
 @param sh sh
 @param dx dx
 @param dy dy
 @param dw dw
 @param dh dh
 */
- (void)drawImage:(NSString *)src
         onCanvas:(NSString *)canvasId
               sx:(NSInteger)sx
               sy:(NSInteger)sy
               sw:(NSInteger)sw
               sh:(NSInteger)sh
               dx:(NSInteger)dx
               dy:(NSInteger)dy
               dw:(NSInteger)dw
               dh:(NSInteger)dh;


#pragma mark - 移除顶部和底部的阴影
-(void) removeShadow;
-(void) makeTransparent;
-(void) makeTransparentAndRemoveShadow;



#pragma mark - 添加头部和底部视图
@property (nonatomic,strong) UIView * headerView;
@property (nonatomic,strong) UIView * footerView;



#pragma mark - Local Storage

- (void)setLocalStorageString:(NSString *)string forKey:(NSString *)key;

- (NSString *)localStorageStringForKey:(NSString *)key;

- (void)removeLocalStorageStringForKey:(NSString *)key;

- (void)clearLocalStorage;

#pragma mark - Session Storage

- (void)setSessionStorageString:(NSString *)string forKey:(NSString *)key;

- (NSString *)sessionStorageStringForKey:(NSString *)key;

- (void)removeSessionStorageStringForKey:(NSString *)key;

- (void)clearSessionStorage;

@end
