import UIKit
import SwiftUI

public struct ViewControllerAdapter: View {

    @Environment(\.presentationMode) var presentationMode
    @State var viewController: UIViewController
    @State private var title: String = ""

    public init(_ vc: UIViewController) {
        _viewController = State(initialValue: vc)
    }

    public var body: some View {
        ViewControllerNavigationRepresentable(viewController: viewController, title: $title)
            .navigationTitle(title)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    backButton
                }
            }
    }

    var backButton: some View {
        Button(action: _backButtonAction) {
            Image(systemName: "chevron.backward").aspectRatio(contentMode: .fit).foregroundColor(.primary)
        }
    }

    private func _backButtonAction() {
        guard let navigationController = viewController.navigationController else {
            presentationMode.wrappedValue.dismiss()
            return
        }

        if navigationController.viewControllers.last == viewController {
            presentationMode.wrappedValue.dismiss()
        } else {
            navigationController.popViewController(animated: true)
        }
    }
}


fileprivate struct ViewControllerNavigationRepresentable: UIViewControllerRepresentable {

    let viewController: UIViewController
    @Binding var title: String

    func makeUIViewController(context: Context) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.delegate = context.coordinator
        viewController.navigationController?.isNavigationBarHidden = true

        return navigationController
    }

    func makeCoordinator() -> NavigationRepresentableCoordinator {
        let coordinator = NavigationRepresentableCoordinator()
        coordinator.willShowCallback = {
            title = $0.title ?? ""
        }
        return coordinator
    }

    func updateUIViewController(_ uiView: UIViewController, context: Context) {

    }
}

fileprivate class NavigationRepresentableCoordinator: NSObject, UINavigationControllerDelegate {

    var willShowCallback: ((UIViewController) -> Void)?

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        willShowCallback?(viewController)
    }
}
