#import <Foundation/Foundation.h>
#import "AnyAuthHandlerProtocol.h"

@interface MailRuAuthHandler : NSObject <AnyAuthHandlerProtocol>

@property (nonatomic, strong, readonly) NSString *accessToken;
@property (nonatomic, strong, readonly) NSString *userId;

- (id)initWithAppId:(NSString *)appId baseDomain:(NSString *)baseDomain;

@end
