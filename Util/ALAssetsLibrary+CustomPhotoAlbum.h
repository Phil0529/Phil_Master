//
//  ALAssetsLibrary+CustomPhotoAlbum.h
//  EZTV
//
//  Created by Phil Xhc on 15/11/9.
//  Copyright © 2015年 Joygo. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

typedef void(^SaveImageCompletion)(NSError* error);

@interface ALAssetsLibrary (CustomPhotoAlbum)

-(void)saveImage:(UIImage*)image toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock;

-(void)addAssetURL:(NSURL*)assetURL toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock;

@end
