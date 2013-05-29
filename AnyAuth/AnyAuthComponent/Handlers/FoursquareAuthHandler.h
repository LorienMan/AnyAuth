#import <Foundation/Foundation.h>
#import "AnyAuthHandlerProtocol.h"

@interface FoursquareAuthHandler : NSObject <AnyAuthHandlerProtocol>

@property (nonatomic, strong, readonly) NSString *accessToken;

- (id)initWithClientId:(NSString *)clientId redirectURI:(NSString *)redirect languagePrefix:(NSString *)lang;

@end
