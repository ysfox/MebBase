//
//  UIWebView+Extension.m
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

#import "UIWebView+Extension.h"
#import "UIColor+Extension.h"
#import <objc/runtime.h>
#define kHeaderViewTag 2200
#define kFooterViewTag 2201
static NSString * const kLocalStorageName = @"localStorage";
static NSString * const kSessionStorageName = @"sessionStorage";

@implementation UIWebView (Extension)

#pragma mark - 获取网页中的数据

/**
 *  获取某个标签的结点个数
 *
 *  @param tag 节点名称
 *
 *  @return 返回节点索引
 */
- (int)nodeCountOfTag:(NSString *)tag{
    NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('%@').length", tag];
    int len = [[self stringByEvaluatingJavaScriptFromString:jsString] intValue];
    return len;
}

/**
 *  获取当前页面URL
 *
 *  @return 返回当前页面URL
 */
- (NSString *)getCurrentURL{
    return [self stringByEvaluatingJavaScriptFromString:@"document.location.href"];
}

/**
 *  获取标题
 *
 *  @return 返回标题
 */
- (NSString *)getTitle{
    return [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}

/**
 *  获取图片
 *
 *  @return 返回图片
 */
- (NSArray *)getImgs{
    NSMutableArray *arrImgURL = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self nodeCountOfTag:@"img"]; i++) {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].src", i];
        [arrImgURL addObject:[self stringByEvaluatingJavaScriptFromString:jsString]];
    }
    return arrImgURL;
}

/**
 *  获取当前页面所有链接
 *
 *  @return 返回获前页面所有链接
 */
- (NSArray *)getOnClicks{
    NSMutableArray *arrOnClicks = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self nodeCountOfTag:@"a"]; i++) {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('a')[%d].getAttribute('onclick')", i];
        NSString *clickString = [self stringByEvaluatingJavaScriptFromString:jsString];
        [arrOnClicks addObject:clickString];
    }
    return arrOnClicks;
}

#pragma mark - 改变网页样式和行为
/**
 *  改变背景颜色
 *
 *  @param color 颜色对象
 */
- (void)setDomBackgroundColor:(UIColor *)color{
    NSString * jsString = [NSString stringWithFormat:@"document.body.style.backgroundColor = '%@'",[color webColorString]];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

/**
 *  为所有图片添加点击事件(网页中有些图片添加无效)
 */
- (void)addClickEventOnImg{
    for (int i = 0; i < [self nodeCountOfTag:@"img"]; i++) {
        //利用重定向获取img.src，为区分，给url添加'img:'前缀
        NSString *jsString = [NSString stringWithFormat:
                              @"document.getElementsByTagName('img')[%d].onclick = \
                              function() { document.location.href = 'img' + this.src; }",i];
        [self stringByEvaluatingJavaScriptFromString:jsString];
    }
}

/**
 *  改变所有图像的宽度
 *
 *  @param size 尺寸
 */
- (void) setImgWidth:(int)size{
    for (int i = 0; i < [self nodeCountOfTag:@"img"]; i++) {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].width = '%d'", i, size];
        [self stringByEvaluatingJavaScriptFromString:jsString];
        
        jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].style.width = '%dpx'", i, size];
        [self stringByEvaluatingJavaScriptFromString:jsString];
        
    }
}

/**
 *  改变所有图像的高度
 *
 *  @param size 尺寸
 */
- (void) setImgHeight:(int)size
{
    for (int i = 0; i < [self nodeCountOfTag:@"img"]; i++) {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].height = '%d'", i, size];
        [self stringByEvaluatingJavaScriptFromString:jsString];
        
        jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].style.height = '%dpx'", i, size];
        [self stringByEvaluatingJavaScriptFromString:jsString];
    }
}

/**
 *  改变指定标签的字体颜色
 *
 *  @param color   颜色
 *  @param tagName 标签名称
 */
- (void)setFontColor:(UIColor *)color withTag:(NSString *)tagName
{
    NSString *jsString = [NSString stringWithFormat:
                          @"var nodes = document.getElementsByTagName('%@'); \
                          for(var i=0;i<nodes.length;i++){\
                          nodes[i].style.color = '%@';}", tagName, [color webColorString]];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

/**
 *  改变指定标签的字体大小
 *
 *  @param size    尺寸
 *  @param tagName 标签名称
 */
- (void)setFontSize:(int)size withTag:(NSString *)tagName
{
    NSString *jsString = [NSString stringWithFormat:
                          @"var nodes = document.getElementsByTagName('%@'); \
                          for(var i=0;i<nodes.length;i++){\
                          nodes[i].style.fontSize = '%dpx';}", tagName, size];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

#pragma mark 在网页上画图
/**
 *  创建一个指定大小的画布
 *
 *  @param canvasId canvas的id名称
 *  @param width    宽度
 *  @param height   高度
 */
- (void)createCanvas:(NSString *)canvasId width:(NSInteger)width height:(NSInteger)height
{
    NSString *jsString = [NSString stringWithFormat:
                          @"var canvas = document.createElement('canvas');"
                          "canvas.id = %@; canvas.width = %ld; canvas.height = %ld;"
                          "document.body.appendChild(canvas);"
                          "var g = canvas.getContext('2d');"
                          "g.strokeRect(%ld,%ld,%ld,%ld);",
                          canvasId, (long)width, (long)height, 0L ,0L ,(long)width,(long)height];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

/**
 *  在指定位置创建一个指定大小的画布
 *
 *  @param canvasId canvas的id名称
 *  @param width    宽度
 *  @param height   高度
 *  @param x        x
 *  @param y        y
 */
- (void)createCanvas:(NSString *)canvasId width:(NSInteger)width height:(NSInteger)height x:(NSInteger)x y:(NSInteger)y{
    NSString *jsString = [NSString stringWithFormat:
                          @"var canvas = document.createElement('canvas');"
                          "canvas.id = %@; canvas.width = %ld; canvas.height = %ld;"
                          "canvas.style.position = 'absolute';"
                          "canvas.style.top = '%ld';"
                          "canvas.style.left = '%ld';"
                          "document.body.appendChild(canvas);"
                          "var g = canvas.getContext('2d');"
                          "g.strokeRect(%ld,%ld,%ld,%ld);",
                          canvasId, (long)width, (long)height, (long)y, (long)x, 0L ,0L ,(long)width,(long)height];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

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
- (void)fillRectOnCanvas:(NSString *)canvasId x:(NSInteger)x y:(NSInteger)y width:(NSInteger)width height:(NSInteger) height uicolor:(UIColor *)color{
    NSString *jsString = [NSString stringWithFormat:
                          @"var canvas = document.getElementById('%@');"
                          "var context = canvas.getContext('2d');"
                          "context.fillStyle = '%@';"
                          "context.fillRect(%ld,%ld,%ld,%ld);"
                          ,canvasId, [color canvasColorString], (long)x, (long)y, (long)width, (long)height];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

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
- (void)strokeRectOnCanvas:(NSString *)canvasId x:(NSInteger)x y:(NSInteger)y width:(NSInteger)width height:(NSInteger) height uicolor:(UIColor *)color lineWidth:(NSInteger)lineWidth{
    NSString *jsString = [NSString stringWithFormat:
                          @"var canvas = document.getElementById('%@');"
                          "var context = canvas.getContext('2d');"
                          "context.strokeStyle = '%@';"
                          "context.lineWidth = '%ld';"
                          "context.strokeRect(%ld,%ld,%ld,%ld);"
                          ,canvasId, [color canvasColorString], (long)lineWidth, (long)x, (long)y, (long)width, (long)height];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

/**
 *  清除矩形区域  context.clearRect(x,y,width,height)
 *
 *  @param canvasId canvas的id名称
 *  @param x        x
 *  @param y        y
 *  @param width    宽度
 *  @param height   高度
 */
- (void)clearRectOnCanvas:(NSString *)canvasId x:(NSInteger)x y:(NSInteger)y width:(NSInteger)width height:(NSInteger) height{
    NSString *jsString = [NSString stringWithFormat:
                          @"var canvas = document.getElementById('%@');"
                          "var context = canvas.getContext('2d');"
                          "context.clearRect(%ld,%ld,%ld,%ld);"
                          ,canvasId, (long)x, (long)y, (long)width, (long)height];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

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
- (void)arcOnCanvas:(NSString *)canvasId centerX:(NSInteger)x centerY:(NSInteger)y radius:(NSInteger)r startAngle:(float)startAngle endAngle:(float)endAngle anticlockwise:(BOOL)anticlockwise uicolor:(UIColor *)color{
    NSString *jsString = [NSString stringWithFormat:
                          @"var canvas = document.getElementById('%@');"
                          "var context = canvas.getContext('2d');"
                          "context.beginPath();"
                          "context.arc(%ld,%ld,%ld,%f,%f,%@);"
                          "context.closePath();"
                          "context.fillStyle = '%@';"
                          "context.fill();",
                          canvasId, (long)x, (long)y, (long)r, startAngle, endAngle, anticlockwise ? @"true" : @"false", [color canvasColorString]];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

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
- (void)lineOnCanvas:(NSString *)canvasId x1:(NSInteger)x1 y1:(NSInteger)y1 x2:(NSInteger)x2 y2:(NSInteger)y2 uicolor:(UIColor *)color lineWidth:(NSInteger)lineWidth{
    NSString *jsString = [NSString stringWithFormat:
                          @"var canvas = document.getElementById('%@');"
                          "var context = canvas.getContext('2d');"
                          "context.beginPath();"
                          "context.moveTo(%ld,%ld);"
                          "context.lineTo(%ld,%ld);"
                          "context.closePath();"
                          "context.strokeStyle = '%@';"
                          "context.lineWidth = %ld;"
                          "context.stroke();",
                          canvasId, (long)x1, (long)y1, (long)x2, (long)y2, [color canvasColorString], (long)lineWidth];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

/**
 *  绘制一条折线
 *
 *  @param canvasId  canvas的id名称
 *  @param points    锚点
 *  @param color     颜色
 *  @param lineWidth 线宽
 */
- (void)linesOnCanvas:(NSString *)canvasId points:(NSArray *)points unicolor:(UIColor *)color lineWidth:(NSInteger)lineWidth{
    NSString *jsString = [NSString stringWithFormat:
                          @"var canvas = document.getElementById('%@');"
                          "var context = canvas.getContext('2d');"
                          "context.beginPath();",
                          canvasId];
    
    for (int i = 0; i < [points count] / 2; i++) {
        jsString = [jsString stringByAppendingFormat:@"context.lineTo(%@,%@);",
                    points[i * 2], points[i * 2 + 1]];
    }
    
    jsString = [jsString stringByAppendingFormat:@""
                "context.strokeStyle = '%@';"
                "context.lineWidth = %ld;"
                "context.stroke();",
                [color canvasColorString], (long)lineWidth];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

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
                  lineWidth:(NSInteger)lineWidth{
    NSString *jsString = [NSString stringWithFormat:
                          @"var canvas = document.getElementById('%@');"
                          "var context = canvas.getContext('2d');"
                          "context.beginPath();"
                          "context.moveTo(%ld,%ld);"
                          "context.bezierCurveTo(%ld,%ld,%ld,%ld,%ld,%ld);"
                          "context.strokeStyle = '%@';"
                          "context.lineWidth = %ld;"
                          "context.stroke();",
                          canvasId, (long)x1, (long)y1, (long)cp1x, (long)cp1y, (long)cp2x, (long)cp2y, (long)x2, (long)y2, [color canvasColorString], (long)lineWidth];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

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
               dh:(NSInteger)dh{
    NSString *jsString = [NSString stringWithFormat:
                          @"var image = new Image();"
                          "image.src = '%@';"
                          "var canvas = document.getElementById('%@');"
                          "var context = canvas.getContext('2d');"
                          "context.drawImage(image,%ld,%ld,%ld,%ld,%ld,%ld,%ld,%ld)",
                          src, canvasId, (long)sx, (long)sy, (long)sw, (long)sh, (long)dx, (long)dy, (long)dw, (long)dh];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}



#pragma mark - 移除顶部和底部的阴影
-(void) removeShadow{
    //Remove that dang shadow.from the UIWebView
    for(UIScrollView* webScrollView in [self subviews])
    {
        if ([webScrollView isKindOfClass:[UIScrollView class]])
        {
            for(UIView* subview in [webScrollView subviews])
            {
                if ([subview isKindOfClass:[UIImageView class]])
                {
                    ((UIImageView*)subview).image = nil;
                    subview.backgroundColor = [UIColor clearColor];
                }
            }
        }
    }
}

-(void) makeTransparent
{
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
}

-(void) makeTransparentAndRemoveShadow
{
    [self makeTransparent];
    [self removeShadow];
}



#pragma mark - 添加头部和底部视图
-(void)setHeaderView:(UIView *)headerView{
    UIView * _headerView = [self headerView];
    if (_headerView) {
        [_headerView removeFromSuperview];
    }
    
    
    headerView.tag = kHeaderViewTag;
    [headerView setFrame:CGRectMake(0, 0, self.frame.size.width, headerView.frame.size.height)];
    headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self.scrollView insertSubview:headerView atIndex:0];
    
    
    
    UIView * webBrowser = [self webBrowser];
    if (webBrowser) {
        [webBrowser setFrame:(CGRect){0, headerView.frame.size.height,webBrowser.frame.size}];
    }
}

-(UIView *)headerView{
    return [self.scrollView viewWithTag:kHeaderViewTag];
}

-(void)setFooterView:(UIView *)footerView{
    UIView * _footerView = [self footerView];
    if (_footerView) {
        [_footerView removeFromSuperview];
    }
    
    
    footerView.tag = kFooterViewTag;
    
    
    [footerView setFrame:CGRectMake(0, self.scrollView.contentSize.height, self.frame.size.width, footerView.frame.size.height)];
    footerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.scrollView insertSubview:footerView atIndex:0];
    
    
    UIEdgeInsets edgeInsets = self.scrollView.contentInset;
    edgeInsets.bottom = footerView.frame.size.height;
    self.scrollView.contentInset = edgeInsets;
    
    
    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

-(UIView *)footerView{
    return [self.scrollView viewWithTag:kFooterViewTag];
}



-(UIView *)webBrowser{
    UIScrollView * scroller = self.scrollView;
    UIView * result;
    for (UIView * view in scroller.subviews) {
        if ([[NSString stringWithUTF8String:object_getClassName(view)] isEqualToString:@"UIWebBrowserView"]) {
            result = view;
            break;
        }
    }
    
    return result;
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSValue * value = change[@"new"];
    CGSize size;
    [value getValue:&size];
    
    
    UIView * footerView = [self footerView];
    if (footerView) {
        [footerView setFrame:(CGRect){0, size.height, footerView.frame.size}];
    }
}


#pragma mark - Local Storage

- (void)setLocalStorageString:(NSString *)string forKey:(NSString *)key {
    [self ip_setString:string forKey:key storage:kLocalStorageName];
}

- (NSString *)localStorageStringForKey:(NSString *)key {
    return [self ip_stringForKey:key storage:kLocalStorageName];
}

- (void)removeLocalStorageStringForKey:(NSString *)key {
    [self ip_removeStringForKey:key storage:kLocalStorageName];
}

- (void)clearLocalStorage {
    [self ip_clearWithStorage:kLocalStorageName];
}

#pragma mark - Session Storage

- (void)setSessionStorageString:(NSString *)string forKey:(NSString *)key {
    [self ip_setString:string forKey:key storage:kSessionStorageName];
}

- (NSString *)sessionStorageStringForKey:(NSString *)key {
    return [self ip_stringForKey:key storage:kSessionStorageName];
}

- (void)removeSessionStorageStringForKey:(NSString *)key {
    [self ip_removeStringForKey:key storage:kSessionStorageName];
}

- (void)clearSessionStorage {
    [self ip_clearWithStorage:kSessionStorageName];
}

#pragma mark - Helpers

- (void)ip_setString:(NSString *)string forKey:(NSString *)key storage:(NSString *)storage {
    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.setItem('%@', '%@');", storage, key, string]];
}

- (NSString *)ip_stringForKey:(NSString *)key storage:(NSString *)storage {
    return [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.getItem('%@');", storage, key]];
}

- (void)ip_removeStringForKey:(NSString *)key storage:(NSString *)storage {
    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.removeItem('%@');", storage, key]];
}

- (void)ip_clearWithStorage:(NSString *)storage {
    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.clear();", storage]];
}

@end
