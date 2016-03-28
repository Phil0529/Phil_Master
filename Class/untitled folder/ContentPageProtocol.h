//
//  ContentPage.h
//  EZTV
//
//  Created by Lee, Bo on 15/10/21.
//  Copyright © 2015年 Joygo. All rights reserved.
//

@protocol ContentPageDelegate <NSObject>

@optional
- (void)pageGoBackChanged:(BOOL)canGoBack;

- (void)pageNeedPopViewController:(BOOL)animated;

- (void)pageNeedPushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)pageNeedPresentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void(^)(void))completion;

- (void)pageNeedPresentSnsView:(NSString *)title content:(NSString *)content link:(NSString *)link image:(UIImage *)image imageUrl:(NSString *)imageUrl;

@end

@protocol ContentPageProtocol <NSObject>

@property (nonatomic, assign) id<ContentPageDelegate> delegate;

- (void)refreshContentPage;

@end


