//
//  File.swift
//  
//
//  Created by alex slobodeniuk on 30.08.2021.
//

import SwiftUI


struct PrivoRegisterView: View {
    @Binding var isPresented: Bool
    @State var config: WebviewConfig?
    @State var inProgress: Bool = true
    var closeIcon: Image?
    let onFinish: (() -> Void)?
    private let siteIdKey = "siteId"
    public init(isPresented: Binding<Bool>, onFinish: (() -> Void)? = nil, closeIcon: Image? = nil ) {
        self.closeIcon = closeIcon
        self._isPresented = isPresented
        self.onFinish = onFinish
    }
    func showView() {
        let serviceIdentifier = PrivoInternal.settings.serviceIdentifier
        PrivoInternal.rest.getServiceInfo(serviceIdentifier: serviceIdentifier) { serviceInfo in
            inProgress = false
            if let siteId = serviceInfo?.p2siteId {
                let url = PrivoInternal.configuration.lgsRegistrationUrl.withQueryParam(name: siteIdKey, value: String(siteId))!
                config = WebviewConfig(
                    url: url,
                    closeIcon: closeIcon,
                    finishCriteria: "step=complete",
                    onFinish: { _ in onFinish?() }
                )
            }
        }
    }
    public var body: some View {
        LoadingView(isShowing: $inProgress) {
            VStack {
                if config != nil {
                    ModalWebView(isPresented: self.$isPresented, config: config!)
                }
            }
        }.onAppear {
            showView()
        }
    }
}

struct PrivoRegisterStateView : View {
    @State var isPresented: Bool = true
    let onClose: (() -> Void)
    let onFinish: (() -> Void)?
    public var body: some View {
        PrivoRegisterView(isPresented: self.$isPresented.onChange({ presented in
            if (presented == false) {
                onClose()
            }
        }), onFinish: onFinish)
    }
}
