//
//  ShareView.m
//  Master
//
//  Created by Phil Xhc on 5/13/16.
//  Copyright © 2016 Xhc. All rights reserved.
//

#import "ShareView.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import "WXApi.h"
#import "WXApiManager.h"
#import "WBApiManger.h"
#import <UMengSocial/WeiboSDK.h>
#import "UITools.h"

@interface ShareView()<WXApiManagerDelegate,WBApiMangerDelegate>
{
    UIImageView *qqIcon;
    UIImageView *qqZoneIcon;
    UIImageView *wxIcon;
    UIImageView *wxFriendsIcon;
    UIImageView *xlIcon;
}

@end

@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self addLoginView];
    }
    return self;
}

- (void)addLoginView{
//    if ([TencentOAuth iphoneQQInstalled] || [WXApi isWXAppInstalled] || [WeiboSDK isWeiboAppInstalled]) {
        CGFloat totalWidth = 0.f;
    
//        if ([TencentOAuth iphoneQQInstalled]) {
            qqIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_live_qq_pre"]];
            [self addSubview:qqIcon];
            UITapGestureRecognizer *tapOnQQ = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnQQShare:)];
            [qqIcon setUserInteractionEnabled:YES];
            [qqIcon addGestureRecognizer:tapOnQQ];
            qqIcon.tag = LaunchLiveShare_QQ;
    
            totalWidth += CGRectGetWidth(qqIcon.frame) + 17.f;
            
            qqZoneIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_live_qqzone"]];
            [self addSubview:qqZoneIcon];
            UITapGestureRecognizer *tapOnQQZone = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnQQZoneShare:)];
            [qqZoneIcon setUserInteractionEnabled:YES];
            [qqZoneIcon addGestureRecognizer:tapOnQQZone];
            totalWidth += CGRectGetWidth(qqZoneIcon.frame) + 17.f;
            qqZoneIcon.tag = LaunchLiveShare_QQZone;
//        }

//        if ([WXApi isWXAppInstalled]) {
            wxIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_live_weichat"]];
            [UITools addMaskLayerToView:wxIcon withRadius:4.f];
            [self addSubview:wxIcon];
            UITapGestureRecognizer *tapOnWX = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnWeichatShare:)];
            [wxIcon setUserInteractionEnabled:YES];
            [wxIcon addGestureRecognizer:tapOnWX];
            totalWidth += (CGRectGetWidth(wxIcon.frame) + 17.f);
            wxIcon.tag = LaunchLiveShare_Weichat;
    
            wxFriendsIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_live_weichatfriends"]];
            [self addSubview:wxFriendsIcon];
            UITapGestureRecognizer *tapOnWXFriends = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnWeichatFriendsShare:)];
            [wxFriendsIcon setUserInteractionEnabled:YES];
            [wxFriendsIcon addGestureRecognizer:tapOnWXFriends];
            wxFriendsIcon.tag = LaunchLiveShare_WeichatFriends;
            totalWidth += (CGRectGetWidth(wxFriendsIcon.frame) + 17.f);
            [WXApiManager sharedManager].delegate = self;
//        }
    
#ifdef SINA_WB
//        if ([WeiboSDK isWeiboAppInstalled]) {
            xlIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_live_sina"]];
            [UITools addMaskLayerToView:xlIcon withRadius:4.f];
            [self addSubview:xlIcon];
            UITapGestureRecognizer *tapOnXl = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnSinaShare:)];
            [xlIcon setUserInteractionEnabled:YES];
            [xlIcon addGestureRecognizer:tapOnXl];
            totalWidth += (CGRectGetWidth(xlIcon.frame) + 17.f);
            [WBApiManger sharedManager].delegate = self;
            xlIcon.tag = LaunchLiveShare_Sina;
//        }
        totalWidth -= 17.f;
#endif
        if (qqIcon) {
            [qqIcon setCenter:CGPointMake(Width(self)/2 - totalWidth/2 + CGRectGetWidth(qqIcon.frame)/2, Height(self)/2)];
            [qqZoneIcon setCenter:CGPointMake(MaxX(qqIcon) + 17.f + CGRectGetWidth(qqZoneIcon.frame)/2, Height(self)/2)];
            if (wxIcon) {
                [wxIcon setCenter:CGPointMake(MaxX(qqZoneIcon) + 17.f + CGRectGetWidth(wxIcon.frame)/2, Height(self)/2)];
                [wxFriendsIcon setCenter:CGPointMake(MaxX(wxIcon) + 17.f + CGRectGetWidth(wxFriendsIcon.frame)/2, Height(self)/2)];
                if (xlIcon) {
                    [xlIcon setCenter:CGPointMake(MaxX(wxFriendsIcon) + 17.f + CGRectGetWidth(xlIcon.frame)/2, Height(self)/2)];
                }
            }
            else{
                [qqZoneIcon setCenter:CGPointMake(Width(self)/2 - totalWidth/2 + CGRectGetWidth(qqIcon.frame)/2, Height(self)/2)];
                if (xlIcon) {
                    [xlIcon setCenter:CGPointMake(MaxX(qqZoneIcon) + 17.f + CGRectGetWidth(xlIcon.frame)/2, Height(self))];
                }
            }
        }
        else{
            [qqZoneIcon setCenter:CGPointMake(Width(self)/2 - totalWidth/2 + CGRectGetWidth(qqIcon.frame)/2, Height(self)/2)];
            if (wxIcon) {
                [wxIcon setCenter:CGPointMake(MaxX(qqZoneIcon) + 17.f + CGRectGetWidth(wxIcon.frame)/2, Height(self)/2)];
                [wxFriendsIcon setCenter:CGPointMake(MaxX(wxIcon) + 17.f + CGRectGetWidth(wxFriendsIcon.frame)/2, Height(self)/2)];
                if (xlIcon) {
                    [xlIcon setCenter:CGPointMake(MaxX(wxFriendsIcon) + 17.f + CGRectGetWidth(xlIcon.frame)/2, Height(self)/2)];
                }
            }
            else{
                [xlIcon setCenter:CGPointMake(MaxX(qqZoneIcon) + 17.f + CGRectGetWidth(xlIcon.frame)/2, Height(self)/2)];
            }
        }
//    }
}

- (void)tapOnQQShare:(UITapGestureRecognizer *)tap{
    [self share:tap.view.tag];
}

- (void)tapOnQQZoneShare:(UITapGestureRecognizer *)tap{
    [self share:tap.view.tag];
}

- (void)tapOnWeichatShare:(UITapGestureRecognizer *)tap{
    [self share:tap.view.tag];
}


- (void)tapOnWeichatFriendsShare:(UITapGestureRecognizer *)tap{
    [self share:tap.view.tag];
}


- (void)tapOnSinaShare:(UITapGestureRecognizer *)tap{
    [self share:tap.view.tag];
}

- (void)share:(LaunchLiveShare )shareTag{
    switch (shareTag) {
        case LaunchLiveShare_QQ:{
            [qqIcon setImage:IMAGE(@"ic_live_qq_pre")];
            [qqZoneIcon setImage:IMAGE(@"ic_live_qqzone")];
            [wxIcon setImage:IMAGE(@"ic_live_weichat")];
            [wxFriendsIcon setImage:IMAGE(@"ic_live_weichatfriends")];
            [xlIcon setImage:IMAGE(@"ic_live_sina")];
        }
            break;
        case LaunchLiveShare_QQZone:{
            [qqIcon setImage:IMAGE(@"ic_live_qq")];
            [qqZoneIcon setImage:IMAGE(@"ic_live_qqzone_pre")];
            [wxIcon setImage:IMAGE(@"ic_live_weichat")];
            [wxFriendsIcon setImage:IMAGE(@"ic_live_weichatfriends")];
            [xlIcon setImage:IMAGE(@"ic_live_sina")];
        }
            break;
        case LaunchLiveShare_Weichat:{
            [qqIcon setImage:IMAGE(@"ic_live_qq")];
            [qqZoneIcon setImage:IMAGE(@"ic_live_qqzone")];
            [wxIcon setImage:IMAGE(@"ic_live_weichat_pre")];
            [wxFriendsIcon setImage:IMAGE(@"ic_live_weichatfriends")];
            [xlIcon setImage:IMAGE(@"ic_live_sina")];
        }
            break;
        case LaunchLiveShare_WeichatFriends:{
            [qqIcon setImage:IMAGE(@"ic_live_qq")];
            [qqZoneIcon setImage:IMAGE(@"ic_live_qqzone")];
            [wxIcon setImage:IMAGE(@"ic_live_weichat")];
            [wxFriendsIcon setImage:IMAGE(@"ic_live_weichatfriends_pre")];
            [xlIcon setImage:IMAGE(@"ic_live_sina")];
        }
            break;
        case LaunchLiveShare_Sina:{
            [qqIcon setImage:IMAGE(@"ic_live_qq")];
            [qqZoneIcon setImage:IMAGE(@"ic_live_qqzone")];
            [wxIcon setImage:IMAGE(@"ic_live_weichat")];
            [wxFriendsIcon setImage:IMAGE(@"ic_live_weichatfriends")];
            [xlIcon setImage:IMAGE(@"ic_live_sina_pre")];
        }
            break;
        default:{
            [qqIcon setImage:IMAGE(@"ic_live_qq_pre")];
            [qqZoneIcon setImage:IMAGE(@"ic_live_qqzone")];
            [wxIcon setImage:IMAGE(@"ic_live_weichat")];
            [wxFriendsIcon setImage:IMAGE(@"ic_live_weichatfriends")];
            [xlIcon setImage:IMAGE(@"ic_live_sina")];
        }
            break;
    }
}

@end
