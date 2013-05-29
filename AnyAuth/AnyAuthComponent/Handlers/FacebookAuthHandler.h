#import <Foundation/Foundation.h>
#import "AnyAuthHandlerProtocol.h"

@interface FacebookAuthHandler : NSObject <AnyAuthHandlerProtocol>

@property (nonatomic, strong, readonly) NSString *accessToken;

- (id)initWithAppId:(NSString *)appId scope:(NSString *)scope baseDomain:(NSString *)baseDomain;
- (id)initWithAppId:(NSString *)appId scope:(NSString *)scope appNamespace:(NSString *)appNamespace;

@end
