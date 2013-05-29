#import "FoursquareAuthHandler.h"
#import "NSDictionary+Query.h"

@implementation FoursquareAuthHandler {
    NSURL *startUrl;
    NSDictionary *authData;
    NSString *redirectUrlString;
    NSString *cancelString;
}

@synthesize delegate;
@synthesize isWorking;

- (id)initWithClientId:(NSString *)clientId redirectURI:(NSString *)redirect languagePrefix:(NSString *)lang {
    if (self = [super init]) {
        redirectUrlString = redirect;

        if (lang) {
            lang = [lang stringByAppendingString:@"."];
        } else {
            lang = @"";
        }

        NSString *urlString = [NSString stringWithFormat:@"https://%@foursquare.com/oauth2/authenticate?client_id=%@&response_type=token&redirect_uri=%@",
                                                        lang,
                                                        [clientId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
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
    if ([url.absoluteString hasPrefix:redirectUrlString]) {
        NSString *query = [[url.absoluteString componentsSeparatedByString:@"#"] lastObject];
        authData = [NSDictionary dictionaryWithQuery:query];
        isWorking = NO;
        return AnyAuthHandlerStatusAuthorized;
    }

    return AnyAuthHandlerStatusContinue;
}

@end
