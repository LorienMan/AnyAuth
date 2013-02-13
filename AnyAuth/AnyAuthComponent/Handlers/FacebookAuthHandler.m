#import "FacebookAuthHandler.h"
#import "WebParams.h"

@implementation FacebookAuthHandler {
    NSURL *startUrl;
    NSDictionary *authData;
    NSString *redirectUrlString;
}
@synthesize authController;
@synthesize isWorking;

- (id)initWithAppId:(NSString *)appId scope:(NSString *)scope {
    if (self = [super init]) {
        redirectUrlString = @"http://anyauth.facebook.com/";
        NSString *urlString = [NSString stringWithFormat:@"https://www.facebook.com/dialog/oauth?client_id=%@&redirect_uri=%@&scope=%@&response_type=token",
                                                         [appId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], redirectUrlString,
                                                         [scope stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        startUrl = [NSURL URLWithString:urlString relativeToURL:nil];
    }

    return self;
}

- (BOOL)isAuthorised {
    return authData != nil;
}

- (NSString *)accessToken {
    return authData[@"access_token"];
}

- (NSDictionary *)authData {
    return authData;
}

- (void)startWorking {
    isWorking = YES;
    [self.authController startLoadingURL:startUrl];
}

- (AnyAuthHandlerAction)stopAfterVisitingURL:(NSURL *)url {
    NSLog(@"url = %@", url);
    if ([url.absoluteString hasPrefix:redirectUrlString]) {
        NSString *query = [[url.absoluteString componentsSeparatedByString:@"#"] lastObject];
        WebParams *webParams = [[WebParams alloc] initWithQuery:query];
        authData = webParams.params;
        isWorking = NO;
        return AnyAuthHandlerActionAuthorized;
    }

    return AnyAuthHandlerActionContinue;
}

@end