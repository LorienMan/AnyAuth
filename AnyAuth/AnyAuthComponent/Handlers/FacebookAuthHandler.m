#import "FacebookAuthHandler.h"
#import "NSDictionary+Query.h"

@implementation FacebookAuthHandler {
    NSURL *startUrl;
    NSDictionary *authData;
    NSString *redirectUrlString;
}
@synthesize authController;
@synthesize isWorking;

- (id)initWithAppId:(NSString *)appId scope:(NSString *)scope baseDomain:(NSString *)baseDomain {
    return [self initWithAppId:appId scope:scope redirectUrl:baseDomain];
}

- (id)initWithAppId:(NSString *)appId scope:(NSString *)scope appNamespace:(NSString *)appNamespace {
    return [self initWithAppId:appId scope:scope redirectUrl:[NSString stringWithFormat:@"https://facebook.com/%@", appNamespace]];
}

- (id)initWithAppId:(NSString *)appId scope:(NSString *)scope redirectUrl:(NSString *)redirectUrl {
    if (self = [super init]) {
        redirectUrlString = redirectUrl;
        NSString *urlString = [NSString stringWithFormat:@"https://www.facebook.com/dialog/oauth?client_id=%@&redirect_uri=%@&scope=%@&response_type=token&display=touch",
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
    if ([url.absoluteString hasPrefix:redirectUrlString]) {
        NSString *query = [[url.absoluteString componentsSeparatedByString:@"#"] lastObject];
        authData = [NSDictionary dictionaryWithQuery:query];
        isWorking = NO;
        return AnyAuthHandlerActionAuthorized;
    }

    return AnyAuthHandlerActionContinue;
}

@end