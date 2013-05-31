#import <Foundation/Foundation.h>
#import "AnyAuthHandlerProtocol.h"

@interface MailRuAuthHandler : NSObject <AnyAuthHandlerProtocol>

@property (nonatomic, strong, readonly) NSString *accessToken;

- (id)initWithAppId:(NSString *)appId baseDomain:(NSString *)baseDomain;

@end
