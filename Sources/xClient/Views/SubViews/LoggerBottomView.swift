//
//  LoggerBottomView.swift
//  xClient
//
//  Created by Douglas Adams on 12/19/20.
//

import SwiftUI
#if os(iOS)
import MessageUI
#endif

struct LoggerBottomView: View {
    @EnvironmentObject var logger: LogManager

    #if os(macOS)
    var body: some View {
        HStack {
            Stepper("Font Size", value: $logger.fontSize, in: 8...24)

            Spacer()
            Button("Email") { logger.emailLog() }

            Spacer()
            HStack (spacing: 20) {
                Button("Refresh") { logger.refreshLog() }
                Button("Load") { logger.loadLog() }
                Button("Save") { logger.saveLog() }
            }

            Spacer()
            Button("Clear") { logger.clearLog() }
        }
    }

    #elseif os(iOS)
    @State private var result: Result<MFMailComposeResult, Error>? = nil
    @State private var isShowingMailView = false

    @State private var mailFailed = false

    var body: some View {
        HStack (spacing: 40) {
            Stepper("Font Size", value: $logger.fontSize, in: 8...24).frame(width: 175)

            Spacer()
            Button("Email", action: {
                if MFMailComposeViewController.canSendMail() {
                    self.isShowingMailView.toggle()
                } else {
                    mailFailed = true
                }
            })
//            .disabled(logger.openFileUrl == nil)
            .alert(isPresented: $mailFailed) {
                Alert(title: Text("Unable to send Mail"),
                      message:  Text(result == nil ? "" : String(describing: result)),
                      dismissButton: .cancel(Text("Cancel")))
            }
            .sheet(isPresented: $isShowingMailView) {
                MailView(result: $result) { composer in
                    composer.setSubject("\(logger.appName) Log")
                    composer.setToRecipients([logger.supportEmail])
                    composer.addAttachmentData(logger.getLogData()!, mimeType: "txt/plain", fileName: "\(logger.appName)Log.txt")
                }
            }
            HStack (spacing: 40) {
                Button("Refresh", action: {logger.refreshLog() })
                Button("Load", action: {logger.loadLog() })
                    .alert(isPresented: $logger.loadFailed) {
                        Alert(title: Text("Unable to load Log file"),
                              message:  Text(""),
                              dismissButton: .cancel(Text("Cancel")))
                    }
            }
            Button("Clear", action: {logger.clearLog() })

            Spacer()
            Button("Back to Main", action: {logger.backToMain() })
        }
    }
    #endif
}

struct LoggerBottomView_Previews: PreviewProvider {
    static var previews: some View {
        LoggerBottomView()
            .environmentObject(LogManager.sharedInstance)
    }
}

#if os(iOS)
// https://stackoverflow.com/questions/56784722/swiftui-send-email
public struct MailView: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?
    public var configure: ((MFMailComposeViewController) -> Void)?

    public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(presentation: Binding<PresentationMode>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentation = presentation
            _result = result
        }

        public func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                $presentation.wrappedValue.dismiss()
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation,
                           result: $result)
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        configure?(vc)
        return vc
    }

    public func updateUIViewController(
        _ uiViewController: MFMailComposeViewController,
        context: UIViewControllerRepresentableContext<MailView>) {

    }
}
#endif
