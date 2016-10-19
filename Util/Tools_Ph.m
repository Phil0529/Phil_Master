//
//  Tools_Ph.m
//  Master
//
//  Created by xhc on 10/18/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "Tools_Ph.h"

@implementation Tools_Ph

+ (BOOL)floatNumberIsInteger:(double)number{
    if(number >= 0)
        if( (number-(int)number) < 1e-15 || (number-(int)number) < -0.999999999999999 )
            return YES;
        else
            return NO;
        else
            if( -(number-(int)number) < 1e-15 || -(number-(int)number) < -0.999999999999999 )
                return YES;
            else
                return NO;
}

@end
