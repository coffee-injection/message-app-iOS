//
//  KakaoLoginWebViewController.swift
//  MIB
//
//  Created by JunghyunYoo on 11/18/25.
//

import UIKit
import WebKit

final class KakaoLoginWebViewController: UIViewController {
    private let initialURL: URL
    private let webView: WKWebView = WKWebView(frame: .zero)
    private var hasCompletedFlow = false
    
    var onCodeExtracted: ((String) -> Void)?
    var onClose: (() -> Void)?
    
    init(url: URL) {
        self.initialURL = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadInitialURL()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "카카오 로그인"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeButtonTapped)
        )
        
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadInitialURL() {
        let request = URLRequest(url: initialURL)
        webView.load(request)
    }
    
    @objc
    private func closeButtonTapped() {
        onClose?()
    }
}

extension KakaoLoginWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            print("[KakaoWebView] 이동 URL: \(url.absoluteString)")
            
            if let code = extractAuthorizationCode(from: url) {
                hasCompletedFlow = true
                onCodeExtracted?(code)
                decisionHandler(.cancel)
                return
            }
        }
        
        if hasCompletedFlow {
            decisionHandler(.cancel)
            return
        }
        
        decisionHandler(.allow)
    }
    
    private func extractAuthorizationCode(from url: URL) -> String? {
        if url.scheme == "mib" {
            return authorizationCode(from: url)
        }
        
        if url.host == "localhost" && url.path == "/auth/kakao/callback" {
            return authorizationCode(from: url)
        }
        
        return nil
    }
    
    private func authorizationCode(from url: URL) -> String? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let code = components.queryItems?.first(where: { $0.name == "code" })?.value else {
            return nil
        }
        return code
    }
}

