//
//  MopLog.h
//  Swmop
//
//  Created by Lee, Bo on 14-3-24.
//  Copyright (c) 2014年 Sunniwell. All rights reserved.
//

#define  MopLOG 2

#ifdef MopLOG
#define MopLog(l, s) NSLog(@"MopSDK %@(%d%s) \n%@", l, __LINE__, __func__, (s))

#if MopLOG == 4
#define MopLogV(f, s...) MopLog(@"LOGV:", ([NSString stringWithFormat:f, ##s]))
#define MopLogD(f, s...) MopLog(@"LOGD:", ([NSString stringWithFormat:f, ##s]))
#define MopLogE(f, s...) MopLog(@"LOGE:", ([NSString stringWithFormat:f, ##s]))
#define MopLogW(f, s...) MopLog(@"LOGW:", ([NSString stringWithFormat:f, ##s]))
#endif

#if MopLOG == 3
#define MopLogV(f, s...)
#define MopLogD(f, s...) MopLog(@"LOGD:", ([NSString stringWithFormat:f, ##s]))
#define MopLogE(f, s...) MopLog(@"LOGE:", ([NSString stringWithFormat:f, ##s]))
#define MopLogW(f, s...) MopLog(@"LOGW:", ([NSString stringWithFormat:f, ##s]))
#endif

#if MopLOG == 2
#define MopLogV(f, s...)
#define MopLogD(f, s...)
#define MopLogE(f, s...) MopLog(@"LOGE:", ([NSString stringWithFormat:f, ##s]))
#define MopLogW(f, s...) MopLog(@"LOGW:", ([NSString stringWithFormat:f, ##s]))
#endif

#if MopLOG == 1
#define MopLogV(f, s...)
#define MopLogD(f, s...)
#define MopLogE(f, s...)
#define MopLogW(f, s...) MopLog(@"LOGW:", ([NSString stringWithFormat:f, ##s]))
#endif

#if MopLOG == 0
#define MopLogV(f, s...)
#define MopLogD(f, s...)
#define MopLogE(f, s...)
#define MopLogW(f, s...)
#endif

#endif
