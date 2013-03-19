#import "AnyAuthViewController.h"
#import "AnyAuthHandlerProtocol.h"

@interface AnyAuthViewController () <UIWebViewDelegate>
@end

@implementation AnyAuthViewController {
    NSURL *currentUrl;
    UIWebView *webView;
}
@synthesize delegate;
@synthesize handler;

- (id)initWithHandler:(id <AnyAuthHandlerProtocol>)newHandler {
    if (self = [super init]) {
        handler = newHandler;
        handler.authController = self;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!webView) {
        webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        webView.delegate = self;
    }
    [self.view addSubview:webView];

    // TODO: nav bar

    if (currentUrl) {
        NSURLRequest *request = [NSURLRequest requestWithURL:currentUrl];
        [webView loadRequest:request];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (!handler.isWorking && !handler.isAuthorised) {
        [handler startWorking];
    }
}

#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)_webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    currentUrl = request.URL;
    AnyAuthHandlerAction action = [handler stopAfterVisitingURL:request.URL];

    switch (action) {
        case AnyAuthHandlerActionContinue:
            return YES;

        case AnyAuthHandlerActionAuthorized:
            [self.delegate authController:self didFinishAuthorized:YES];
            return NO;

        case AnyAuthHandlerActionCanceled:
            [self.delegate authController:self didFinishAuthorized:NO];
            return NO;
    }

    return NO;
}

#pragma mark AnyAuthControllerProtocol

- (void)startLoadingURL:(NSURL *)url {
    currentUrl = url;
    NSURLRequest *request = [NSURLRequest requestWithURL:currentUrl];
    [webView loadRequest:request];
}

@end