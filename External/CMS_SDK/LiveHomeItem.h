//
//  LiveHomeItem.h
//  EZTV
//
//  Created by Lee, Bo on 15/8/11.
//  Copyright (c) 2015年 Joygo. All rights reserved.
//

#import "MTLModel.h"
#import "LiveItem.h"

@interface ConditionItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString* tagtype;
@property (nonatomic, copy) NSString* tagname;
@property (nonatomic, copy) NSString* livetype;

@end

typedef NS_ENUM(NSInteger, LiveHomeType)
{
    LiveHomeType_Top = 0,       //置顶
    LiveHomeType_Preview = 1,   //预告
    LiveHomeType_Live = 2,      //正在直播
    LiveHomeType_System = 3,    //系统栏目
    LiveHomeType_Custom = 4,    //自定义栏目
};

@interface LiveHomeItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* icon;
@property (nonatomic, assign) LiveHomeType type;
@property (nonatomic, assign) NSInteger rowcount;
@property (nonatomic, assign) NSInteger columncount;
@property (nonatomic, copy) ConditionItem *condition;
@property (nonatomic, copy) NSArray *list;

@end
