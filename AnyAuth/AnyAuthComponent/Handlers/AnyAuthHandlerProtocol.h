#include "AnyAuthControllerProtocol.h"

typedef enum {
    AnyAuthHandlerActionContinue,
    AnyAuthHandlerActionAuthorized,
    AnyAuthHandlerActionCanceled
} AnyAuthHandlerAction;

@protocol AnyAuthHandlerProtocol

@property (nonatomic, assign, readonly) BOOL isAuthorised;
@property (nonatomic, assign, readonly) BOOL isWorking;
@property (nonatomic, strong, readonly) NSDictionary *authData;

- (void)startWorking;

- (AnyAuthHandlerAction)stopAfterVisitingURL:(NSURL *)url;

@property (nonatomic, weak) id <AnyAuthControllerProtocol> authController;

@end