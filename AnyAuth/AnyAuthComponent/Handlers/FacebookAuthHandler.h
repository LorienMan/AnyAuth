#import <Foundation/Foundation.h>
#import "AnyAuthHandlerProtocol.h"

@interface FacebookAuthHandler : NSObject <AnyAuthHandlerProtocol>

- (id)initWithAppId:(NSString *)appId scope:(NSString *)scope;

@property (nonatomic, strong, readonly) NSString *accessToken;

@end