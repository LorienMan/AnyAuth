#import <Foundation/Foundation.h>
#import "AnyAuthHandlerProtocol.h"

@interface FacebookAuthHandler : NSObject <AnyAuthHandlerProtocol>

- (id)initWithAppId:(NSString *)appId scope:(NSString *)scope baseDomain:(NSString *)baseDomain;
- (id)initWithAppId:(NSString *)appId scope:(NSString *)scope appNamespace:(NSString *)appNamespace;

@property (nonatomic, strong, readonly) NSString *accessToken;

@end