//
//  EOCAutoDictionary.m
//  Master
//
//  Created by xhc on 10/20/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "EOCAutoDictionary.h"
#import <objc/runtime.h>

@interface EOCAutoDictionary()

@property (nonatomic,strong) NSMutableDictionary *backingStore;

@end

@implementation EOCAutoDictionary

@dynamic string,number,date,opaqueObject;

- (instancetype)init{
    if (self = [super init]) {
        _backingStore = [NSMutableDictionary new];
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSString *selectorString = NSStringFromSelector(sel);
    if ([selectorString hasPrefix:@"set"]) {
        class_addMethod(self,
                        sel,
                        (IMP)autoDictionarySetter,
                        "v@:@");
    }else{
        class_addMethod(self,
                        sel,
                        (IMP)autoDictinaryGetter,
                        "@@:");
    }
    return YES;
    
}

// Getter函数
id autoDictinaryGetter (id self, SEL _cmd){
    EOCAutoDictionary *typedSelf = (EOCAutoDictionary *)self;
    NSMutableDictionary *backingStore = typedSelf.backingStore;
    NSString *key = NSStringFromSelector(_cmd);
    return [backingStore objectForKey:key];
}

//Setter函数
void autoDictionarySetter(id self,SEL _cmd,id value){
    EOCAutoDictionary *typedSelf = (EOCAutoDictionary *)self;
    NSMutableDictionary *backingStore = typedSelf.backingStore;
    NSString *selectorString = NSStringFromSelector(_cmd);
    NSMutableString *key = [selectorString mutableCopy];
    [key deleteCharactersInRange:NSMakeRange(key.length-1, 1)]; //移除 :
    [key deleteCharactersInRange:NSMakeRange(0, 3)];            //移除set;
    NSString *lowercaseFurstChar = [[key substringToIndex:1] lowercaseString]; //首字母大小变小写.
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFurstChar];
    if (value) {
        [backingStore setObject:value forKey:key];
    }else{
        [backingStore removeObjectForKey:key];
    }
}

/*
 当开发者首次在EOCAutoDictinary实例上访问某个属性时,运行期系统还找不到对应的selector,因为所需的selector既没有直接实现,也没有由系统合成.(加入系统要写入opaqueObject属性).那么系统就会以 "setOpaqueObject:"为selector来调用上面此方法.同理-->在读取该属性时,系统也会调用上述方法,传入的selector-->opaqueObject. resolveInstanceMethod方法会判断seletor的前缀是否为set,以此判定其是set还是get.在这两种情况下,都要向类中新增一个处理该selector所用的方法--->class_addMethod方法,它可以向类中动态的添加方法,用以处理给定的selector.第三个参数为函数指针,指向待添加的方法,而最后一个参数则表示待添加方法的 type encoding (类型编码). 编码开头的字符表示方法的返回值类型,后续字符则表示其所接受的各个参数.
 */



//
//+ (BOOL)resolveInstanceMethod:(SEL)sel{
//    NSString *selectorString = NSStringFromSelector(sel);
//    if (YES/*selector if froma a @dynamic property*/) {
//        if ([selectorString hasPrefix:@"set"]) {
//            class_addMethod(self,
//                            sel,
//                            (IMP)audoDictionarySetter,
//                            "v@:@");
//        }else{
//            class_addMethod(self,
//                            sel,
//                            (IMP)autoDictionaryGetter,
//                            "@@:");
//        }
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}

@end
