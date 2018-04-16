//
//  CommonVar.h
//  WXFenShenPlugin
//
//  Created by apple on 2018/4/11.
//

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
@interface CommonVar : NSObject
@property(nonatomic,strong) id HQVideoListViewControllerInstance;
@property(nonatomic,assign) long long clickVideoIndex;
@property(nonatomic,assign) long long clickVideoViewNum;
@property(nonatomic,strong) id OthersHomePageViewControllerInstance;
//@property(nonatomic,strong) UINavigationController *pushNavigationtroller;
+(instancetype)shareInstance;

@end
