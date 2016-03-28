//
//  LaunchAdView.m
//  Created by http://github.com/iosdeveloper
//

#import "LaunchAdView.h"

@interface LaunchAdView ()

@property (nonatomic, strong) UIImageView *adImg;

@end

NSString* const klaunchAdImage = @"__launchAdImageUrl";

@implementation LaunchAdView
{
    NSTimeInterval _delay;
}

- (id)initWithPresentDelay:(NSTimeInterval)seconds
{
	self = [super init];
	if (self) {
        _delay = seconds;
	}
	return self;
}

- (void)showOnWindow:(UIWindow *)window
{
    [self setFrame:window.bounds];
    [self setUserInteractionEnabled:YES];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    CGFloat space = 92.f;
    UIImage *image = [UIImage imageNamed:@"LaunchImage-700"];
    
    if (IS_SCREEN_4_INCH) {
        space = 91.f;
        image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    } else if (IS_SCREEN_47_INCH) {
        space = 108.f;
        image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (IS_SCREEN_55_INCH){
        space = 119.f;
        image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h"];
    }
    
    [self setImage:image];
    
    NSString *launchAdUrl = [[NSUserDefaults standardUserDefaults] objectForKey:klaunchAdImage];
    if (!ISEMPTYSTR(launchAdUrl)) {
        _adImg = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - space)];
        [_adImg setContentMode:UIViewContentModeScaleAspectFill];
        [_adImg setAlpha:0.f];
        [self addSubview:_adImg];

        UIButton *btnSkip = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 70.f, 20.f, 60.f, 28.f)];
        [btnSkip setBackgroundColor:COLORFORRGBa(0x00000033)];
        [btnSkip.layer setBorderColor:COLORFORRGBa(0xFFFFFF33).CGColor];
        [btnSkip.layer setBorderWidth:1.f];
        [btnSkip.layer setCornerRadius:14.f];
        [btnSkip setClipsToBounds:YES];
        [btnSkip setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnSkip setTitle:@"跳过" forState:UIControlStateNormal];
        [btnSkip addTarget:self action:@selector(dismissLaunchAd:) forControlEvents:UIControlEventTouchUpInside];
        [btnSkip.titleLabel setFont:[UIFont systemFontOfSize:14.5f]];
        [_adImg setUserInteractionEnabled:YES];
        
        __weak __typeof(self) weakSelf = self;
        [_adImg sd_setImageWithURL:[NSURL URLWithString:launchAdUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (weakSelf) {
                if (image) {
                    [UIView animateWithDuration:0.2 animations:^{
                        [weakSelf.adImg setAlpha:1.f];
                    } completion:^(BOOL finished) {
                        [weakSelf.adImg addSubview:btnSkip];
                    }];
                } else {
                    [weakSelf performSelector:@selector(dismissLaunchAd:) withObject:nil afterDelay:3.0];
                }
            }
        }];
    } else {
        _delay = 3.0;
    }
    [window addSubview:self];
    [window bringSubviewToFront:self];
    
    [self performSelector:@selector(dismissLaunchAd:) withObject:nil afterDelay:_delay];
}

- (void)dismissLaunchAd:(id)sender
{
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissLaunchAd:) object:nil];
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf setAlpha:0.f];
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

- (void)dealloc
{
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissLaunchAd:) object:nil];
}

@end