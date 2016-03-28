//
//  ALAssetsLibrary+CustomPhotoAlbum.m
//  EZTV
//
//  Created by Phil Xhc on 15/11/9.
//  Copyright © 2015年 Joygo. All rights reserved.
//

#import "ALAssetsLibrary+CustomPhotoAlbum.h"
@import Photos;


@implementation ALAssetsLibrary (CustomPhotoAlbum)

-(void)saveImage:(UIImage*)image toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock
{
    [self writeImageToSavedPhotosAlbum:image.CGImage orientation:(ALAssetOrientation)image.imageOrientation
     
                       completionBlock:^(NSURL* assetURL, NSError* error) {
                           if (error!=nil) {
                               completionBlock(error);
                               return;
                               
                           }
                           [self addAssetURL: assetURL
                                     toAlbum:albumName
                         withCompletionBlock:completionBlock];
                       }];
}

-(void)addAssetURL:(NSURL*)assetURL toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock{
    
    __block BOOL albumWasFound = NO;
    dispatch_queue_t queue = dispatch_queue_create("Phil_Write_To_Album", DISPATCH_QUEUE_SERIAL);
    [self enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        dispatch_async(queue, ^{
            
        });
            if([albumName compare: [group valueForProperty:ALAssetsGroupPropertyName]]==NSOrderedSame) {
                albumWasFound = YES;
                [self assetForURL: assetURL
                      resultBlock:^(ALAsset *asset) {
                          [group addAsset: asset];
                          completionBlock(nil);
                      } failureBlock: completionBlock];
                return ;
            }
        
        if (albumWasFound==NO && group == nil){
            if (IS_OS_8_OR_LATER) {
                __weak ALAssetsLibrary* weakSelf = self;
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                    [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumName];
                } completionHandler:^(BOOL success, NSError *error) {
                    if (success) {
                        [weakSelf enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                            if ([albumName compare: [group valueForProperty:ALAssetsGroupPropertyName]]==NSOrderedSame) {
                                
                                [weakSelf assetForURL: assetURL
                                 
                                          resultBlock:^(ALAsset *asset) {
                                              [group addAsset: asset];
                                              [self performSelectorOnMainThread:@selector(saveCompletionSuccess:) withObject:completionBlock waitUntilDone:YES];
                                          } failureBlock: completionBlock];
                            }
                            
                        } failureBlock:completionBlock];
                    }
                }];
                
            }
            else{
                __weak ALAssetsLibrary* weakSelf = self;
                [self addAssetsGroupAlbumWithName:albumName
                                      resultBlock:^(ALAssetsGroup *group) {
                                          [weakSelf assetForURL: assetURL
                                           
                                                    resultBlock:^(ALAsset *asset) {
                                                        [group addAsset: asset];
                                                        completionBlock(nil);
                                                    } failureBlock: completionBlock];
                                      } failureBlock: completionBlock];
            }
        }
    } failureBlock:completionBlock];
}
- (void)saveCompletionSuccess:(SaveImageCompletion)block{
    //-->>
}
@end
