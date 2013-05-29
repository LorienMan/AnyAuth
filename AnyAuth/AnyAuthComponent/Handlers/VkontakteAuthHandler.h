#import <Foundation/Foundation.h>
#import "AnyAuthHandlerProtocol.h"

@interface VkontakteAuthHandler : NSObject <AnyAuthHandlerProtocol>

@property (nonatomic, strong, readonly) NSString *accessToken;

- (id)initWithAppId:(NSString *)appId scope:(NSString *)scope;

@end