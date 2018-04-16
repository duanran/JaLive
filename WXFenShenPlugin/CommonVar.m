//
//  CommonVar.m
//  WXFenShenPlugin
//
//  Created by apple on 2018/4/11.
//

#import "CommonVar.h"

@implementation CommonVar
+(instancetype)shareInstance{
    static CommonVar * common = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        common = [CommonVar new];
    });
    return common;
}
@end
