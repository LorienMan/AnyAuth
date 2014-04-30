#import "VkontakteAuthHandler.h"
#import "NSDictionary+Query.h"

static NSString *const kCancelString = @"http://api.vk.com/blank.html#error=access_denied";
static NSString *const kSuccessAuth = @"http://api.vk.com/blank.html#access_token=";


@implementation VkontakteAuthHandler {
    NSURL *startUrl;
    NSDictionary *authData;
    NSString *redirectUrlString;
}

@synthesize delegate;
@synthesize isWorking;

- (id)initWithAppId:(NSString *)appId scope:(NSString *)scope {
    if (self = [super init]) {
        redirectUrlString = @"http://api.vk.com/blank.html";
        NSString *urlString = [NSString stringWithFormat:@"http://oauth.vk.com/oauth/authorize?client_id=%@&scope=%@&redirect_uri=%@&display=touch&response_type=token",
                                                         [appId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                                         [scope stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
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
    [self.delegate authHandler:nil loadURL:startUrl];
}

- (AnyAuthHandlerStatus)statusBeforeVisitingURL:(NSURL *)url {
    if ([url.absoluteString hasPrefix:kCancelString]) {
        isWorking = NO;
        return AnyAuthHandlerStatusCanceled;
    }

    else if ([url.absoluteString hasPrefix:kSuccessAuth]) {
        NSString *query = [[url.absoluteString componentsSeparatedByString:@"#"] lastObject];
        authData = [NSDictionary dictionaryWithQuery:query];
        isWorking = NO;
        return AnyAuthHandlerStatusAuthorized;
    }

    return AnyAuthHandlerStatusContinue;
}

@end
