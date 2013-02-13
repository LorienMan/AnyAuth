#import <Foundation/Foundation.h>
#import "AnyAuthHandlerProtocol.h"

@interface VkontakteAuthHandler : NSObject <AnyAuthHandlerProtocol>

- (id)initWithAppId:(NSString *)appId scope:(NSString *)scope;

@property (nonatomic, strong, readonly) NSString *accessToken;

@end