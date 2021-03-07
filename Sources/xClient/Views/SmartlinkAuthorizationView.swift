//
//  SmartlinkAuthorizationView.swift
//  xClient
//
//  Created by Douglas Adams on 8/18/20.
//  Copyright © 2020 Douglas Adams. All rights reserved.
//

import SwiftUI
import WebKit

/// A View to display the SmartLink authorization view (an Auth0 view)
///
public struct SmartlinkAuthorizationView: View {
    @EnvironmentObject var radioManager : RadioManager
    @Environment(\.presentationMode) var presentationMode
    
    public init() {
    }

    public var body: some View {
        
        VStack {
            let webBrowserView = WebBrowserView(radioManager: radioManager)
            webBrowserView
                .onAppear() { webBrowserView.load(urlString: radioManager.auth0UrlString) }
            
            Button(action: {
                radioManager.smartLinkAuthorizationViewCancelButton()
                presentationMode.wrappedValue.dismiss()
            }) { Text("Cancel")}
        }.frame(width: 740, height: 350, alignment: .leading)
        .padding(.vertical, 10)
    }
}

public struct SmartlinkAuthorizationView_Previews: PreviewProvider {
    public static var previews: some View {
        SmartlinkAuthorizationView()
            .environmentObject(RadioManager(delegate: MockRadioManagerDelegate()))
    }
}

// ----------------------------------------------------------------------------
// MARK: - Encapsulation of WKWebView for SwiftUI

public struct WebBrowserView {
    private let radioManager: RadioManager
    private let wkWebView: WKWebView

    public init(radioManager: RadioManager) {
        self.radioManager = radioManager
        self.wkWebView = radioManager.wkWebView
    }

    func authorizationSuccess(idToken: String, refreshToken: String) {
        radioManager.wanManager!.processAuthorizationTokens(idToken: idToken, refreshToken: refreshToken)
        radioManager.wanManager!.closeSmartlinkAuthorizationView()
    }
    
    func load(urlString: String) {
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            wkWebView.load( urlRequest)
        }
    }
    
    public class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var parent: WebBrowserView

        private let kKeyIdToken       = "id_token"
        private let kKeyRefreshToken  = "refresh_token"

        init(parent: WebBrowserView) {
            self.parent = parent
        }

        public func webView(_: WKWebView, didFail: WKNavigation!, withError: Error) {
            // ...
        }

        public func webView(_: WKWebView, didFailProvisionalNavigation: WKNavigation!, withError: Error) {
            let nsError = (withError as NSError)
            if (nsError.domain == "WebKitErrorDomain" && nsError.code == 102) || (nsError.domain == "WebKitErrorDomain" && nsError.code == 101) {
                // Error code 102 "Frame load interrupted" is raised by the WKWebView
                // when the URL is from an http redirect. This is a common pattern when
                // implementing OAuth with a WebView.
                return
            }
        }

        //    public func webView(_: WKWebView, didFinish: WKNavigation!) {
        //      // ...
        //      print("Coordinator: Auth0: didFinish \(String(describing: didFinish))")
        //    }
        //
        //    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //      // ...
        //      print("Coordinator: Auth0: didStartProvisionalNavigation: \(String(describing: navigation))")
        //    }

        public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            // does the navigation action's request contain a URL?
            if let url = navigationAction.request.url {
                // YES, is there a token inside the url?
                if url.absoluteString.contains(kKeyIdToken) {
                    // extract the tokens
                    var responseParameters = [String: String]()
                    if let query = url.query { responseParameters += query.parametersFromQueryString }
                    if let fragment = url.fragment, !fragment.isEmpty { responseParameters += fragment.parametersFromQueryString }
                    // did we extract both tokens?
                    if let idToken = responseParameters[kKeyIdToken], let refreshToken = responseParameters[kKeyRefreshToken] {
                        // YES, pass them back
                        parent.authorizationSuccess(idToken: idToken, refreshToken: refreshToken)
                    }
                    decisionHandler(.cancel)
                    return
                }
            }
            decisionHandler(.allow)
        }

        public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}

#if os(macOS)
extension WebBrowserView: NSViewRepresentable {
    public typealias NSViewType = WKWebView

    public func makeNSView(context: NSViewRepresentableContext<WebBrowserView>) -> WKWebView {
        wkWebView.navigationDelegate = context.coordinator
        wkWebView.uiDelegate = context.coordinator
        return wkWebView
    }

    public func updateNSView(_ nsView: WKWebView, context: NSViewRepresentableContext<WebBrowserView>) {
    }
}
#elseif os(iOS)
extension WebBrowserView: UIViewRepresentable {
    public typealias UIViewType = WKWebView

    public func makeUIView(context: UIViewRepresentableContext<WebBrowserView>) -> WKWebView {
        wkWebView.translatesAutoresizingMaskIntoConstraints = false
        wkWebView.navigationDelegate = context.coordinator
        wkWebView.uiDelegate = context.coordinator
        return wkWebView
    }

    public func updateUIView(_ nsView: WKWebView, context: UIViewRepresentableContext<WebBrowserView>) {
    }
}
#endif
