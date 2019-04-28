//
//  UIColor+Extension.h
//  AFNetworking
//
//  Created by meb on 2019/4/25.
//**********************************
//     ______    _______          **
//    /\  __ \  /\   ___\         **
//    \ \  __C  \ \  \___         **
//     \ \_____\ \ \_____\        **
//      \/_____/  \ \             **
//                 \F\            **
//**********************************

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#define CFRGB16Color(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define CFRGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//颜色类型
typedef NS_ENUM(NSInteger, CFColorType) {
    CFColorTypeRed      = 1,                //红色
    CFColorTypeGreen    = 2,                //绿色
    CFColorTypeBlue     = 3,                //蓝色
    CFColorTypeAlpha    = 4                 //透明度
};

@interface UIColor (Extension)

#pragma mark - WonderfulColor(各种漂亮颜色)
#pragma mark  红色系
/** 薄雾玫瑰*/
+ (UIColor *)mistyRose;
/** 浅鲑鱼色*/
+ (UIColor *)lightSalmon;
/** 淡珊瑚色*/
+ (UIColor *)lightCoral;
/** 鲑鱼色*/
+ (UIColor *)salmonColor;
/** 珊瑚色*/
+ (UIColor *)coralColor;
/** 番茄*/
+ (UIColor *)tomatoColor;
/** 橙红色*/
+ (UIColor *)orangeRed;
/** 印度红*/
+ (UIColor *)indianRed;
/** 猩红*/
+ (UIColor *)crimsonColor;
/** 耐火砖*/
+ (UIColor *)fireBrick;
#pragma mark 黄色系
/** 玉米色*/
+ (UIColor *)cornColor;
/** 柠檬薄纱*/
+ (UIColor *)LemonChiffon;
/** 苍金麒麟*/
+ (UIColor *)paleGodenrod;
/** 卡其色*/
+ (UIColor *)khakiColor;
/** 金色*/
+ (UIColor *)goldColor;
/** 雌黄*/
+ (UIColor *)orpimentColor;
/** 藤黄*/
+ (UIColor *)gambogeColor;
/** 雄黄*/
+ (UIColor *)realgarColor;
/** 金麒麟色*/
+ (UIColor *)goldenrod;
/** 乌金*/
+ (UIColor *)darkGold;

#pragma mark 绿色系
/** 苍绿*/
+ (UIColor *)paleGreen;
/** 淡绿色*/
+ (UIColor *)lightGreen;
/** 春绿*/
+ (UIColor *)springGreen;
/** 绿黄色*/
+ (UIColor *)greenYellow;
/** 草坪绿*/
+ (UIColor *)lawnGreen;
/** 酸橙绿*/
+ (UIColor *)limeColor;
/** 森林绿*/
+ (UIColor *)forestGreen;
/** 海洋绿*/
+ (UIColor *)seaGreen;
/** 深绿*/
+ (UIColor *)darkGreen;
/** 橄榄(墨绿)*/
+ (UIColor *)olive;

#pragma mark 青色系
/** 淡青色*/
+ (UIColor *)lightCyan;
/** 苍白绿松石*/
+ (UIColor *)paleTurquoise;
/** 绿碧*/
+ (UIColor *)aquamarine;
/** 绿松石*/
+ (UIColor *)turquoise;
/** 适中绿松石*/
+ (UIColor *)mediumTurquoise;
/** 美团色*/
+ (UIColor *)meituanColor;
/** 浅海洋绿*/
+ (UIColor *)lightSeaGreen;
/** 深青色*/
+ (UIColor *)darkCyan;
/** 水鸭色*/
+ (UIColor *)tealColor;
/** 深石板灰*/
+ (UIColor *)darkSlateGray;

#pragma mark 蓝色系
/** 天蓝色*/
+ (UIColor *)skyBlue;
/** 淡蓝*/
+ (UIColor *)lightBLue;
/** 深天蓝*/
+ (UIColor *)deepSkyBlue;
/** 道奇蓝*/
+ (UIColor *)doderBlue;
/** 矢车菊*/
+ (UIColor *)cornflowerBlue;
/** 皇家蓝*/
+ (UIColor *)royalBlue;
/** 适中的蓝色*/
+ (UIColor *)mediumBlue;
/** 深蓝*/
+ (UIColor *)darkBlue;
/** 海军蓝*/
+ (UIColor *)navyColor;
/** 午夜蓝*/
+ (UIColor *)midnightBlue;

#pragma mark 紫色系
/** 薰衣草*/
+ (UIColor *)lavender;
/** 蓟*/
+ (UIColor *)thistleColor;
/** 李子*/
+ (UIColor *)plumColor;
/** 紫罗兰*/
+ (UIColor *)violetColor;
/** 适中的兰花紫*/
+ (UIColor *)mediumOrchid;
/** 深兰花紫*/
+ (UIColor *)darkOrchid;
/** 深紫罗兰色*/
+ (UIColor *)darkVoilet;
/** 泛蓝紫罗兰*/
+ (UIColor *)blueViolet;
/** 深洋红色*/
+ (UIColor *)darkMagenta;
/** 靛青*/
+ (UIColor *)indigoColor;

#pragma mark 灰色系
/** 白烟*/
+ (UIColor *)whiteSmoke;
/** 鸭蛋*/
+ (UIColor *)duckEgg;
/** 亮灰*/
+ (UIColor *)gainsboroColor;
/** 蟹壳青*/
+ (UIColor *)carapaceColor;
/** 银白色*/
+ (UIColor *)silverColor;
/** 暗淡的灰色*/
+ (UIColor *)dimGray;

#pragma mark 白色系
/** 海贝壳*/
+ (UIColor *)seaShell;
/** 雪*/
+ (UIColor *)snowColor;
/** 亚麻色*/
+ (UIColor *)linenColor;
/** 花之白*/
+ (UIColor *)floralWhite;
/** 老饰带*/
+ (UIColor *)oldLace;
/** 象牙白*/
+ (UIColor *)ivoryColor;
/** 蜂蜜露*/
+ (UIColor *)honeydew;
/** 薄荷奶油*/
+ (UIColor *)mintCream;
/** 蔚蓝色*/
+ (UIColor *)azureColor;
/** 爱丽丝蓝*/
+ (UIColor *)aliceBlue;
/** 幽灵白*/
+ (UIColor *)ghostWhite;
/** 淡紫红*/
+ (UIColor *)lavenderBlush;
/** 米色*/
+ (UIColor *)beigeColor;

#pragma mark 棕色系
/** 黄褐色*/
+ (UIColor *)tanColor;
/** 玫瑰棕色*/
+ (UIColor *)rosyBrown;
/** 秘鲁*/
+ (UIColor *)peruColor;
/** 巧克力*/
+ (UIColor *)chocolateColor;
/** 古铜色*/
+ (UIColor *)bronzeColor;
/** 黄土赭色*/
+ (UIColor *)siennaColor;
/** 马鞍棕色*/
+ (UIColor *)saddleBrown;
/** 土棕*/
+ (UIColor *)soilColor;
/** 栗色*/
+ (UIColor *)maroonColor;
/** 乌贼墨棕*/
+ (UIColor *)inkfishBrown;

#pragma mark 粉色系
/** 水粉*/
+ (UIColor *)waterPink;
/** 藕色*/
+ (UIColor *)lotusRoot;
/** 浅粉红*/
+ (UIColor *)lightPink;
/** 适中的粉红*/
+ (UIColor *)mediumPink;
/** 桃红*/
+ (UIColor *)peachRed;
/** 苍白的紫罗兰红色*/
+ (UIColor *)paleVioletRed;
/** 深粉色*/
+ (UIColor *)deepPink;

#pragma mark - AdjustColor(调色功能)
/**
 *  当前颜色向上添加指定的数
 *
 *  @param type 需要调整颜色的方向
 *  @param num  给定需要上调的数
 *
 *  @return 返回调整后的颜色
 */
- (UIColor *)up:(CFColorType)type num:(NSInteger)num;

/**
 *  当前颜色向下减少指定的数
 *
 *  @param type 需要调整颜色的方向
 *  @param num  给定需要下调的数
 *
 *  @return 返回调整后的颜色
 */
- (UIColor *)down:(CFColorType)type num:(NSInteger)num;


/**
 *  调整颜色亮度
 *
 *  @param amount 亮度值
 *
 *  @return 返回调整后的颜色
 */
- (UIColor *)adjustBrightness:(CGFloat)amount;


#pragma mark - SeparateColor(分离颜色功能)

/**
 *  判断当前颜色的控件模式
 *
 *  @return 返回当前颜色的空间模式
 */
- (CGColorSpaceModel)colorSpaceModel;

/**
 *  根据颜色空间模式返回对应的颜色模式的字符串
 *
 *  @return 返回当前颜色的颜色模式的字符串
 */
- (NSString *)colorSpaceString;


/**
 *  返回当前颜色的颜色空间中的红色相关的数字
 *
 *  @return 返回当前颜色控件中红色的值
 */
- (CGFloat)red;

/**
 *  返回当前颜色的颜色空间中的绿色相关的数字
 *
 *  @return 返回当前颜色控件中绿色的值
 */
- (CGFloat)green;

/**
 *  返回当前颜色的颜色空间中的蓝色相关的数字
 *
 *  @return 返回当前颜色控件中蓝色的值
 */
- (CGFloat)blue;

/**
 *  返回当前颜色的颜色空间中的透明度相关的数字
 *
 *  @return 返回当前颜色控件中透明度的值
 */
- (CGFloat)alpha;

/**
 *  翻转当前颜色，也就是反色
 *
 *  @return 返回当前颜色的反色
 */
- (UIColor *)reverseColor;

/**
 *  打印当前颜色的信息值
 */
- (void)printDetail;


#pragma mark - Other(其它功能)


/**
 *  随机颜色
 *
 *  @return 返回随机颜色
 */
+ (UIColor *)randomColor;


/**
 *  返回十六进制的颜色
 *
 *  @param hex 十六进制
 *
 *  @return 返回十六进制颜色对象
 */
+ (UIColor *)colorWithHex:(UInt32)hex;

/**
 *  返回十六进制的颜色
 *
 *  @param hex   十六进制
 *  @param alpha 透明度
 *
 *  @return 返回是十六进制的颜色对象
 */
+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;

/**
 *  十六进制的颜色字符串转换为UIColor
 *
 *  @param color   十六进制的颜色字符串
 *
 *  @return   转换之后的颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

/**
 *  十六进制的颜色字符串装换为UIColor
 *
 *  @param color 十六进制的颜色字符串
 *  @param alpha 颜色alpha
 *
 *  @return 转换之后的颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


/**
 *  通过一张图片来创建一个颜色
 *
 *  @param image 图片
 *
 *  @return 返回创建的颜色
 */
+ (UIColor *)colorWithImage:(UIImage *)image;


#pragma mark - webViewColor
/**
 *  获取canvas用的颜色字符串
 *
 *  @return 返回颜色字符串
 */
- (NSString *)canvasColorString;

/**
 *  获取网页颜色字串
 *
 *  @return 返回颜色字符串
 */
- (NSString *) webColorString;

/**
 *  获取RGB值
 *
 *  @return 返回颜色值
 */
- (CGFloat *) getRGB;

/**
 *  让颜色更亮
 *
 *  @return 返回颜色对象
 */
- (UIColor *) lighten;

/**
 *  让颜色更暗
 *
 *  @return 返回颜色对象
 */
- (UIColor *) darken;

/**
 *  取两个颜色的中间
 *
 *  @param color 另外一个颜色
 *
 *  @return 返回中间颜色对象
 */
- (UIColor *) mix: (UIColor *) color;


@end

