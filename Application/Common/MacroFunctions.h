//
//  MacroFunctions.h
//  CheckDaily
//
//  Created by loufq on 11-9-11.
//  Copyright 2011年 loufq All rights reserved.
//


#ifdef DEBUG 
#define DebugLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#define DLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog( s, ... ) do { } while(0); 
#define DebugLog(...) do {} while(0);
#endif

//角度与弧度
//#define DEGREES_TO_RADIANS(d) (d * M_PI / 180) SSDrawingUtilities.h
//#define RADIANS_TO_DEGREES(r) (r * 180 / M_PI) SSDrawingUtilities.h

//字符串
#define MF_Trim(x) [x stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]
#define MF_SWF(FORMAT, ...) [NSString stringWithFormat:FORMAT, __VA_ARGS__]
#define MF_Replace(raw,f,r) [raw stringByReplacingOccurrencesOfString:f withString:r]
#define NULL_STR(str, default) (str ?: default)
#define EMPTY_STR(str, default) (str ? (str.length == 0 ? default : str ) : default)
#define NULL_STR_EMPTY(str) NULL_STR(str, @"")

// MARK: - Block Helper
#if NS_BLOCKS_AVAILABLE
#define SAFE_BLOCK_CALL_NO_P(b) (b == nil ?: b())
#define SAFE_BLOCK_CALL(b, p) (b == nil ? : b(p) )
#endif

//颜色
#define MF_ColorFromRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define MF_ColorFromRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//设备
#define deviceIsPad ([[UIDevice currentDevice] screenSize] == UIDeviceScreenSizePad)

//通知处理
#define addN(_selector,_name)\
([[NSNotificationCenter defaultCenter] addObserver:self selector:_selector name:_name object:nil])

#define removeNObserverWithName(_name)\
([[NSNotificationCenter defaultCenter] removeObserver:self name:_name object:nil])

#define removeNObserver() ([[NSNotificationCenter defaultCenter] removeObserver:self])

#define postN(_name)\
([[NSNotificationCenter defaultCenter] postNotificationName:_name object:nil userInfo:nil])

#define postNWithObj(_name,_obj)\
([[NSNotificationCenter defaultCenter] postNotificationName:_name object:_obj userInfo:nil])

#define postNWithInfos(_name,_obj,_infos)\
([[NSNotificationCenter defaultCenter] postNotificationName:_name object:_obj userInfo:_infos])

//navigation oper
#define pushVCChangeNavBar(_vc) ([self.navigationController pushViewControllerWithNavigationControllerTransition:_vc])
#define pushVC(_vc) ([self.navigationController pushViewController:_vc animated:YES])
#define pushVCNoAnimated(_vc) ([self.navigationController pushViewController:_vc animated:NO])
#define popVC() ([self.navigationController popViewControllerAnimated:YES])
//vi
#define presentVC(_vc) ([self presentModalViewController:_vc animated:YES])

//Geometry
#pragma mark - Geometry
#define RECTCENTER(rect) CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
#define RESIZABLE(_VIEW_) [_VIEW_ setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth]

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

//宏定义

#define kMessage_APP_Login @"kMessage_APP_Login"


