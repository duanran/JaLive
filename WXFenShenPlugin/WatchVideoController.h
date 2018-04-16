//
//  WatchVideoController.h
//  WXFenShenPlugin
//
//  Created by apple on 2018/4/10.
//

#import <UIKit/UIKit.h>
#import "VideoListModel.h"
@interface WatchVideoController : UIViewController
@property(retain, nonatomic) UIView *holdingView; // @synthesize holdingView=_holdingView;
//@property(retain, nonatomic) LiveGiftShowCustom *customGiftShow; // @synthesize customGiftShow=_customGiftShow;
@property(nonatomic) __weak UIButton *chat_button; // @synthesize chat_button=_chat_button;
@property(nonatomic) __weak UIButton *gift_button; // @synthesize gift_button=_gift_button;
@property(retain, nonatomic) UIButton *gift_clearbutton; // @synthesize gift_clearbutton=_gift_clearbutton;
//@property(retain, nonatomic) VideoGiftView *giftView; // @synthesize giftView=_giftView;
@property(nonatomic) int pagenum; // @synthesize pagenum=_pagenum;
@property(retain, nonatomic) UIButton *sendButton; // @synthesize sendButton=_sendButton;
@property(retain, nonatomic) UITextField *chatTextField; // @synthesize chatTextField=_chatTextField;
@property(retain, nonatomic) UIView *sendView; // @synthesize sendView=_sendView;
@property(retain, nonatomic) NSMutableArray *dataArray; // @synthesize dataArray=_dataArray;
@property(retain, nonatomic) NSMutableArray *chatArray; // @synthesize chatArray=_chatArray;
@property(retain, nonatomic) UIButton *chat_cleatButton; // @synthesize chat_cleatButton=_chat_cleatButton;
@property(retain, nonatomic) UITableView *chatTableView; // @synthesize chatTableView=_chatTableView;
@property(retain, nonatomic) UIButton *closeBtn; // @synthesize closeBtn=_closeBtn;
@property(retain, nonatomic) UILabel *longline; // @synthesize longline=_longline;
@property(retain, nonatomic) UIButton *userinfo_clearbutton; // @synthesize userinfo_clearbutton=_userinfo_clearbutton;
//@property(retain, nonatomic) WatchVideoUserInfoView *userinfoView; // @synthesize userinfoView=_userinfoView;
//@property(retain, nonatomic) KSYMoviePlayerController *player; // @synthesize player=_player;
@property(copy, nonatomic) NSString *viewnum; // @synthesize viewnum=_viewnum;
@property(retain, nonatomic) VideoListModel *model; // @synthesize model=_model;
@end
