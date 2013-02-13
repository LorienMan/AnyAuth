#import <Foundation/Foundation.h>
#import "AnyAuthHandlerProtocol.h"

@interface FoursquareAuthHandler : NSObject <AnyAuthHandlerProtocol>

- (id)initWithClientId:(NSString *)clientId redirectURI:(NSString *)redirect languagePrefix:(NSString *)lang;

@property (nonatomic, strong, readonly) NSString *accessToken;

@end