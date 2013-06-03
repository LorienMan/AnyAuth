#import "MailRuAuthHandler.h"
#import "NSDictionary+Query.h"

@implementation MailRuAuthHandler {
    NSURL *startUrl;
    NSDictionary *authData;
    NSString *redirectUrlString;
}

@synthesize delegate;
@synthesize isWorking;

- (id)initWithAppId:(NSString *)appId baseDomain:(NSString *)baseDomain {
    if (self = [super init]) {
        redirectUrlString = baseDomain;
        NSString *urlString = [NSString stringWithFormat:@"https://connect.mail.ru/oauth/authorize?client_id=%@&redirect_uri=%@&response_type=token",
                               [appId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
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

- (NSString *)userId
{
    return authData[@"x_mailru_vid"];
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
