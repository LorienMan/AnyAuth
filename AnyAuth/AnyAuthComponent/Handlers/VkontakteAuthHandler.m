#import "VkontakteAuthHandler.h"
#import "NSDictionary+Query.h"

@implementation VkontakteAuthHandler {
    NSURL *startUrl;
    NSDictionary *authData;
    NSString *redirectUrlString;
    NSString *cancelString;
}
@synthesize authController;
@synthesize isWorking;

- (id)initWithAppId:(NSString *)appId scope:(NSString *)scope {
    if (self = [super init]) {
        redirectUrlString = @"http://api.vk.com/blank.html";
        cancelString = @"cancel=1";
        NSString *urlString = [NSString stringWithFormat:@"http://oauth.vk.com/oauth/authorize?client_id=%@&scope=%@&redirect_uri=%@&display=touch&response_type=token",
                              [appId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [scope stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                              redirectUrlString];

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

- (AnyAuthHandlerAction)actionAfterVisitingURL:(NSURL *)url {
    if ([url.absoluteString hasPrefix:redirectUrlString]) {
        NSString *query = [[url.absoluteString componentsSeparatedByString:@"#"] lastObject];
        authData = [NSDictionary dictionaryWithQuery:query];
        isWorking = NO;
        return AnyAuthHandlerActionAuthorized;
    } else if ([url.absoluteString hasSuffix:cancelString]) {
        isWorking = NO;
        return AnyAuthHandlerActionCanceled;
    }

    return AnyAuthHandlerActionContinue;
}

@end