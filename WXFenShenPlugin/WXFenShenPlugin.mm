//
//  WXFenShenPlugin.mm
//  WXFenShenPlugin
//
//  Created by apple on 2018/3/21.
//  Copyright (c) 2018年 ___ORGANIZATIONNAME___. All rights reserved.
//

// CaptainHook by Ryan Petrich
// see https://github.com/rpetrich/CaptainHook/

#import <Foundation/Foundation.h>
#import "CaptainHook/CaptainHook.h"
#include <notify.h>
#import <UIKit/UIKit.h>
#import "HQVideoInfoModel.h"
#import "WatchVideoController.h"
#import "VideoListModel.h"
#import "CommonVar.h"
//#import "HomeViewController.h"
// not required; for examples only
//#import "PasswordLogic.h"
// Objective-C runtime hooking using CaptainHook:
//   1. declare class using CHDeclareClass()
//   2. load class using CHLoadClass() or CHLoadLateClass() in CHConstructor
//   3. hook method using CHOptimizedMethod()
//   4. register hook using CHHook() in CHConstructor
//   5. (optionally) call old method using CHSuper()


#define sdkversion @"1.1.0.4"

@interface WXFenShenPlugin : NSObject

@end

@implementation WXFenShenPlugin

-(id)init
{
	if ((self = [super init]))
	{
        NSLog(@"plugin init");

	}

    return self;
}

@end




@class OthersHomePageViewController;
CHDeclareClass(OthersHomePageViewController);
CHOptimizedMethod1(self, void, OthersHomePageViewController, check_payWith, id, arg1){
    NSLog(@"OthersHomePageViewController check_payWith = %@",arg1);
    CHSuper1(OthersHomePageViewController,check_payWith, arg1);
    UIButton *btn = arg1;
    id otherHomePageInstance = [CommonVar shareInstance].OthersHomePageViewControllerInstance;
    
    Ivar var_videoArr = class_getInstanceVariable(objc_getClass("OthersHomePageViewController"), "_videoArray");
    NSArray *videoArr = object_getIvar(otherHomePageInstance, var_videoArr);
    NSInteger index = btn.tag;
    
    if (index < videoArr.count) {
        objc_msgSend(otherHomePageInstance, @selector(payViewDismiss));
        id videoListModel = [videoArr objectAtIndex:index];
        Class playerClass = NSClassFromString(@"WatchVideoViewController");
        id watch =[[playerClass alloc]init];
        Ivar var_model = class_getInstanceVariable(objc_getClass("WatchVideoViewController"), "_model");
        object_setIvar(watch, var_model, videoListModel);
        NSLog(@"OthersHomePageViewController set videolist model to watchviewcontrller");
        UIViewController *vc = otherHomePageInstance;
        NSLog(@"otherHomePageInstance.navigationController=%@",vc.navigationController);
        [vc.navigationController pushViewController:watch animated:YES];
    }
    
    
    
}
CHOptimizedMethod1(self, void, OthersHomePageViewController, clickBtnwith, id, arg1){
    NSLog(@"OthersHomePageViewController clickBtnwith arg1 = %@",arg1);
    CHSuper1(OthersHomePageViewController, clickBtnwith, arg1);
}

CHOptimizedMethod1(self, void, OthersHomePageViewController, broweVideoWithBtn, id, arg1){
    NSLog(@"OthersHomePageViewController broweVideoWithBtn arg1 = %@",arg1);
    CHSuper1(OthersHomePageViewController, broweVideoWithBtn, arg1);
}








@class MainTabBar;
CHDeclareClass(MainTabBar);
CHOptimizedMethod0(self, id, MainTabBar, timer){
    NSTimer *timer = nil;
    return timer;
}




@class VideoListModel;
CHDeclareClass(VideoListModel);
//CHOptimizedMethod0(self,BOOL, VideoListModel, publicFlag){
//    NSLog(@"VideoListModel publicFlag 111111111");
//    return YES;
//}
CHOptimizedMethod1(self, void, VideoListModel, setupwith, id, arg1){
    NSLog(@"VideoListModel arg1 = %@",arg1);
    CHSuper1(VideoListModel, setupwith, arg1);
}




//获取对象的所有属性

NSDictionary * properties_aps(id objc)
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([objc class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        
        id propertyValue = [objc valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}



@class UINavigationController;
CHDeclareClass(UINavigationController);
//CHOptimizedMethod0(self, id, UINavigationController, init){
//    UINavigationController *navi = CHSuper0(UINavigationController, init);
//    NSLog(@"UINavigationController init success = %@ ",navi);
//    [CommonVar shareInstance].pushNavigationtroller = navi;
//    return navi;
//}



CHOptimizedMethod2(self, void, UINavigationController, pushViewController, id, arg1, animated, bool, arg2){
    NSLog(@"UINavigationController pushViewController arg1=%@",arg1);
    
    NSString *className = NSStringFromClass([arg1 class]);
    
    if ([className isEqualToString:@"WatchVideoViewController"]) {
        NSLog(@"push watchVideoContrller");
        WatchVideoController *watch = arg1;
        NSLog(@"holdingView=%@",watch.holdingView);
        NSLog(@"dataArray=%@",watch.dataArray);
        NSLog(@"watch.chatArray=%@",watch.chatArray);
        NSLog(@"chatTableView=%@",watch.chatTableView);
        NSLog(@"watch.longline=%@",watch.longline);
        NSLog(@"pagenum=%d",watch.pagenum);
        NSLog(@"viewnum=%@",watch.viewnum);
        NSLog(@"watch.model=%@",watch.model);
//        NSDictionary *propertdic = properties_aps(watch.model);
//        for (NSString *key in propertdic) {
//            NSString *value = propertdic[key];
//            NSLog(@"watch.model key=%@ ,vaule=%@",key,value);
//        }
        
        
    }
    
    CHSuper2(UINavigationController, pushViewController, arg1, animated, arg2);
}



@class HTTPRequest;
CHDeclareClass(HTTPRequest);

//- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
//parameters:(nullable id)parameters
//success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
//failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure DEPRECATED_ATTRIBUTE;

CHOptimizedMethod4(self, void, HTTPRequest, post, id, arg1, paramters, id, arg2, success, id, suc, failure, id, fail)
{
    NSLog(@"HTTPRequest method post");
    NSLog(@"suc=%@",suc);
    NSLog(@"failure=%@",fail);

    CHSuper4(HTTPRequest, post, arg1, paramters, arg2, success, suc, failure, fail);
}


@class ResponseModel;
CHDeclareClass(ResponseModel);
CHOptimizedMethod0(self, NSString *, ResponseModel, errcode){
    NSLog(@"ResponseModel errorcode method");
    return @"0";
}

CHOptimizedMethod0(self, NSString *, ResponseModel, status){
    NSLog(@"ResponseModel status method");
    return @"1";
}

CHOptimizedMethod1(self, void, ResponseModel, setErrcode, id, arg1){
    NSLog(@"ResponseModel setErrcode");
}

@class ViewerViewController;

CHDeclareClass(ViewerViewController);
CHOptimizedMethod0(self, void, ViewerViewController, viewDidLoad){
    NSLog(@"ViewerViewController come");
    CHSuper0(ViewerViewController, viewDidLoad);
}

CHOptimizedMethod0(self, void, ViewerViewController, notifyToEndViewing){
    NSLog(@"think end no door");
    return ;
}

CHOptimizedMethod0(self, void, ViewerViewController, outLiveRoom){
    NSLog(@"no go la la");
    return;
}


CHOptimizedMethod0(self, id, ViewerViewController, waitView){
    UIView *v = [[UIView alloc]init];
    v.hidden = YES;
    NSLog(@"ViewerViewController waitView");
    return v;
    
}
CHOptimizedMethod0(self, UIImageView *, ViewerViewController, waitImageV){
    UIImageView *v = [[UIImageView alloc]init];
    v.hidden = YES;
    NSLog(@"ViewerViewController imageview");
    return v;
}




@class WatchVideoViewController;
CHDeclareClass(WatchVideoViewController);
CHOptimizedMethod(0, self,id,WatchVideoViewController,holdingView){
    UIView *v = [[UIView alloc]init];
    v.hidden = YES;
    NSLog(@"WatchVideoViewController nil");

    return v;
}

CHOptimizedMethod0(self, void, WatchVideoViewController, viewDidLoad){
    NSLog(@"WatchVideoViewController viewdidload");
    CHSuper0(WatchVideoViewController, viewDidLoad);
}

CHOptimizedMethod0(self, id, WatchVideoViewController, VideoListModel){
    NSLog(@"WatchVideoViewController VideoListModel");
   return CHSuper0(WatchVideoViewController, VideoListModel);
}
//CHOptimizedMethod0(self,void, WatchVideoViewController, <#name#>){
//
//}




@class LiveViewController;
CHDeclareClass(LiveViewController);
CHOptimizedMethod0(self, void, LiveViewController, quitChatRoom){
    NSLog(@"LiveViewController quitChatRoom");
    CHSuper0(LiveViewController, quitChatRoom);
}


CHOptimizedMethod(0, self,void,LiveViewController,endLive){
    NSLog(@"LiveViewController endLive");
    CHSuper(0,LiveViewController,endLive);

}

CHOptimizedMethod(0, self,void,LiveViewController,showAlert){
    NSLog(@"LiveViewController showAlert");

    CHSuper(0,LiveViewController,showAlert);

}

@class payRule;
CHDeclareClass(payRule);


CHOptimizedMethod0(self, id, payRule, init){
    NSLog(@"payRule init method");
    return nil;
}

CHOptimizedMethod(0, self,NSString *,payRule,pinkDiamond){
    NSLog(@"payRule pinkDiamond");
    return @"0";
}
CHOptimizedMethod(0,self,NSString *,payRule,yellowDiamond){
    NSLog(@"payRule yellowDiamond");
    return @"0";
}













@class LiveVideoModel;
CHDeclareClass(LiveVideoModel);
CHOptimizedMethod(0, self,NSString *,LiveVideoModel,pinkDiamond){
    return @"999";
}
CHOptimizedMethod(0, self,NSString *,LiveVideoModel,yellowDiamond){
    NSLog(@"get livevideomodel yellowDiamod");
    return @"11100";
}
CHOptimizedMethod(0, self,NSString *,LiveVideoModel,status){
    NSLog(@"get status");
    return @"1";
}



@class UserModel;

CHDeclareClass(UserModel);
CHOptimizedMethod(0, self,NSString *,UserModel,yellowDiamond){
    NSLog(@"get user yellowDiamod");
    return @"11100";
}

CHOptimizedMethod(0,self,NSString *,UserModel,pinkDiamond){
    return @"999";
}

//@class VideoListViewController;
//
//CHDeclareClass(VideoListViewController);
//
//CHOptimizedMethod1(self, void, VideoListViewController, click_playVideoWith, id, arg1){
//    NSLog(@"click VideoListViewController =%@",arg1);
//    CHSuper1(VideoListViewController, click_playVideoWith, arg1);
//}


@class HQVideoListViewController;

CHDeclareClass(HQVideoListViewController);

CHOptimizedMethod2(self, void, HQVideoListViewController, click_playVideoWithVideoInfoModel, id,arg1, andIndex,long long, arg2){
    NSLog(@"click HQVideoListViewController = %@ = %lld ",arg1,arg2);
    HQVideoInfoModel *vModel = arg1;
    [CommonVar shareInstance].clickVideoIndex = arg2;
    [CommonVar shareInstance].clickVideoViewNum = vModel.viewNum;
    CHSuper2(HQVideoListViewController, click_playVideoWithVideoInfoModel, arg1, andIndex, arg2);
    return;
//    SEL selector = NSSelectorFromString(@"packCommonData");
    
//    NSLog(@"pinkDiamond=%lld",vModel.pinkDiamond);
//    NSLog(@"videoId=%@",vModel.videoId);
//    NSLog(@"viewNum=%lld",vModel.viewNum);
//    NSLog(@"userName=%@",vModel.userName);
//    vModel.pinkDiamond = 0;
//    NSLog(@"pinkDiamond_after=%lld",vModel.pinkDiamond);

}


CHOptimizedMethod1(self, void, HQVideoListViewController, checkPwdWith, id, arg1){
    NSLog(@"checkpwd = %@",arg1);
    CHSuper1(HQVideoListViewController, checkPwdWith, arg1);
}

CHOptimizedMethod0(self, id, HQVideoListViewController, init){
    id instance = CHSuper0(HQVideoListViewController, init);
    Class HomeViewController = NSClassFromString(@"HomeViewController");
    NSLog(@"HQVideoListViewController init success = %@",instance);
    
    Class OthersHomePageViewController = NSClassFromString(@"OthersHomePageViewController");
    if ([instance isKindOfClass:OthersHomePageViewController]) {
        NSLog(@"this is OthersHomePageViewController = %@",instance);
        [CommonVar shareInstance].OthersHomePageViewControllerInstance = instance;
        
    }
    
    

    if ([instance isKindOfClass:HomeViewController]) {
        NSLog(@"this is HomeViewController = %@",instance);
        
        NSDictionary *propertdic = properties_aps(instance);;
        for (NSString *key in propertdic) {
            id value = propertdic[key];
            NSLog(@"HomeViewController key=%@ ,vaule=%@",key,value);
            if ([key isEqualToString:@"videoListVC"]) {
                [CommonVar shareInstance].HQVideoListViewControllerInstance = value;
            }
        }
    }
    
    
    
    
    return instance;
}

CHOptimizedMethod0(self, void, HQVideoListViewController, viewDidLoad){
    NSLog(@"HQVideoListViewController viewDidLoad");
    CHSuper0(HQVideoListViewController, viewDidLoad);
}

CHOptimizedMethod1(self, void, HQVideoListViewController, check_payWith, id, arg1){
    NSLog(@"check_payWith =%@",arg1);
    CHSuper1(HQVideoListViewController,check_payWith, arg1);

    Class playerClass = NSClassFromString(@"WatchVideoViewController");
    
    id watch =[[playerClass alloc]init];
    
    Ivar var_model = class_getInstanceVariable(objc_getClass("WatchVideoViewController"), "_model");
    Ivar var_viewnum = class_getInstanceVariable(objc_getClass("WatchVideoViewController"), "_viewnum");
    
    
    
    id hqViewContrroler = [CommonVar shareInstance].HQVideoListViewControllerInstance ;
//    Ivar var_navigationcontroller = class_getInstanceVariable(objc_getClass("HQVideoListViewController"), "_navigationController");

    Ivar var_videoArr = class_getInstanceVariable(objc_getClass("HQVideoListViewController"), "_videoArray");
    NSArray *videoArr = object_getIvar(hqViewContrroler, var_videoArr);

    int index = [CommonVar shareInstance].clickVideoIndex;
    NSLog(@"videoArr=%@",videoArr);
    if (index < videoArr.count - 1) {
        objc_msgSend(hqViewContrroler, @selector(payViewDismiss));

        id videoListModel = [videoArr objectAtIndex:index];
        NSLog(@"get will show video list model = %@",videoListModel);
        object_setIvar(watch, var_model, videoListModel);
        NSLog(@"set videolist model to watchviewcontrller");
        NSString *viewnum = [NSString stringWithFormat:@"%lld",[CommonVar shareInstance].clickVideoViewNum];
        NSLog(@"set viewnum to watchviewcontrller = %@",viewnum);
        object_setIvar(watch, var_viewnum, viewnum);
        NSLog(@"push watchviewcontroller");        
        UIViewController *vc = hqViewContrroler;
        NSLog(@"vc.navigationController=%@",vc.navigationController);
        [vc.navigationController pushViewController:watch animated:YES];
        
    }
    
    
}










//@class verify;
//
//CHDeclareClass(verify);
//CHOptimizedMethod(0,self,void,verify,init){
//    NSLog(@"verify init success");
//    CHSuper(0,verify,init);
//}
//
//CHOptimizedMethod2(self, void, verify, alertView, id,view, clickedButtonAtIndex,long long,index){
//    NSLog(@"click index =%lld",index);
//    CHSuper2(verify,alertView, view,clickedButtonAtIndex, index);
//}
//
//
//
//
//
//
//@class WCUIAlertView;
//
//CHDeclareClass(WCUIAlertView);
//
//
//CHOptimizedMethod2(self, void, WCUIAlertView, initWithTitle, id, title, message, id, mess){
//    NSLog(@"alert init successfull");
//    CHSuper2(WCUIAlertView, initWithTitle, title, message, mess);
//}
//
//CHOptimizedMethod2(self, void, WCUIAlertView,alertView, id, View, clickedButtonAtIndex, long long, index){
//    NSLog(@"click alert index=%lld",index);
//    CHSuper2(WCUIAlertView, alertView, View,clickedButtonAtIndex, index);
//}




//@class PasswordLogic;
//
//CHDeclareClass(PasswordLogic);
//
//CHOptimizedMethod(0, self,void,PasswordLogic,showPasswordAlert)
//{
//    NSLog(@"showPasswordAlert execute");
//    CHSuper(0, PasswordLogic,showPasswordAlert);
//}
//
//CHOptimizedMethod(0,self,void,PasswordLogic,showVerifyAlert){
//    NSLog(@"showVerifyAlert execute");
//}
//
//CHOptimizedMethod(2, self, void, PasswordLogic,arg1,id,value1,arg2,long long ,vaule2){
//    NSLog(@"click alert");
//    CHSuper(2, PasswordLogic,arg1,value1,arg2,vaule2);
//
//
//}




//@class ClassToHook;
//
//CHDeclareClass(ClassToHook); // declare class
//
//CHOptimizedMethod(0, self, void, ClassToHook, messageName) // hook method (with no arguments and no return value)
//{
//    // write code here ...
//
//    CHSuper(0, ClassToHook, messageName); // call old (original) method
//}
//
//CHOptimizedMethod(2, self, BOOL, ClassToHook, arg1, NSString*, value1, arg2, BOOL, value2) // hook method (with 2 arguments and a return value)
//{
//    // write code here ...
//
//    return CHSuper(2, ClassToHook, arg1, value1, arg2, value2); // call old (original) method and return its return value
//}

static void WillEnterForeground(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	// not required; for example only
}

static void ExternallyPostedNotification(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	// not required; for example only
}

CHConstructor // code block that runs immediately upon load
{

	@autoreleasepool
	{
        static WXFenShenPlugin *Plugin;
        Plugin = [[WXFenShenPlugin alloc] init];
        NSLog(@"dylib insert successfull = %@",sdkversion);
		// listen for local notification (not required; for example only)
		CFNotificationCenterRef center = CFNotificationCenterGetLocalCenter();
		CFNotificationCenterAddObserver(center, NULL, WillEnterForeground, CFSTR("UIApplicationWillEnterForegroundNotification"), NULL, CFNotificationSuspensionBehaviorCoalesce);
		
		// listen for system-side notification (not required; for example only)
		// this would be posted using: notify_post("apple.WXFenShenPlugin.eventname");
		CFNotificationCenterRef darwin = CFNotificationCenterGetDarwinNotifyCenter();
		CFNotificationCenterAddObserver(darwin, NULL, ExternallyPostedNotification, CFSTR("apple.WXFenShenPlugin.eventname"), NULL, CFNotificationSuspensionBehaviorCoalesce);
		
		// CHLoadClass(ClassToHook); // load class (that is "available now")
		// CHLoadLateClass(ClassToHook);  // load class (that will be "available later")
		
//        CHHook(0, ClassToHook, messageName); // register hook
//        CHHook(2, ClassToHook, arg1, arg2); // register hook
        
//        CHLoadClass(PasswordLogic);
//        CHLoadLateClass(PasswordLogic);
////        CHLoadClass(PasswordLogic);
//        CHHook(0, PasswordLogic,showPasswordAlert);
//        CHHook(0, PasswordLogic,showVerifyAlert);
//        CHHook(2, PasswordLogic,arg1,arg2);
        
        CHLoadLateClass(UserModel);
        CHHook0(UserModel, yellowDiamond);
        CHHook0(UserModel, pinkDiamond);
        
        
        CHLoadLateClass(LiveVideoModel);
        CHHook0(LiveVideoModel,yellowDiamond);
        CHHook0(LiveVideoModel, pinkDiamond);
        CHHook0(LiveVideoModel, status);
        
    

        
        
        CHLoadLateClass(HQVideoListViewController);
        CHHook2(HQVideoListViewController, click_playVideoWithVideoInfoModel, andIndex);
        CHHook1(HQVideoListViewController, checkPwdWith);
        CHHook1(HQVideoListViewController, check_payWith);
        CHHook0(HQVideoListViewController, init);
        CHHook0(HQVideoListViewController, viewDidLoad);
        
        CHLoadLateClass(payRule);
        CHHook0(payRule, pinkDiamond);
        CHHook0(payRule, yellowDiamond);
        CHHook0(payRule, init);
        
        
        
        CHLoadLateClass(LiveViewController);
        CHHook0(LiveViewController, quitChatRoom);
        CHHook0(LiveViewController, endLive);
        CHHook0(LiveViewController, showAlert);
        
        
        
        CHLoadLateClass(WatchVideoViewController);
        CHHook0(WatchVideoViewController, holdingView);
        CHHook0(WatchVideoViewController, viewDidLoad);
        
        
        
        CHLoadLateClass(ViewerViewController);
        CHHook0(ViewerViewController, viewDidLoad);
        CHHook0(ViewerViewController, notifyToEndViewing);
        CHHook0(ViewerViewController, outLiveRoom);
        CHHook0(ViewerViewController, waitView);
        CHHook0(ViewerViewController, waitImageV);

        
        
        CHLoadLateClass(ResponseModel);
        
        CHHook0(ResponseModel, errcode);
        CHHook0(ResponseModel, status);
        CHHook1(ResponseModel, setErrcode);
        
        
        
        CHLoadLateClass(VideoListModel);
        CHHook1(VideoListModel, setupwith);

        CHLoadLateClass(MainTabBar);
        CHHook0(MainTabBar, timer);
        
        CHLoadLateClass(OthersHomePageViewController);
        CHHook1(OthersHomePageViewController, check_payWith);
        CHHook1(OthersHomePageViewController, clickBtnwith);
        CHHook1(OthersHomePageViewController, broweVideoWithBtn);

	}
}


