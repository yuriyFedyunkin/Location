//
//  MenuViewModel.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 03.11.2021.
//

import RxSwift
import RxCocoa

protocol MenuViewModel: AnyObject {
    var router: MenuRouter { get }
    var didTapShowMap: Binder<Void> { get }
    var didTapSelfieButton: Binder<Void> { get }
    var selfieOutput: Driver<UIImage?> { get }
}

final class MenuViewModelImpl: NSObject, MenuViewModel {
    
    // MARK: MenuViewModel protocol
    let router: MenuRouter
    private(set) lazy var selfieOutput = _selfieOutput.asDriver()
    private let _selfieOutput = BehaviorRelay<UIImage?>(value: nil)
    var didTapSelfieButton: Binder<Void> {
        Binder(self,
               scheduler: MainScheduler.instance,
               binding: { vm, _ in
            vm.showCamera()
        })
    }
    var didTapShowMap: Binder<Void> {
        Binder(self,
               scheduler: MainScheduler.instance,
               binding: { vm, _ in
            vm.router.showMap()
        })
    }
     
    // MARK: Local properties
    private let disposeBag = DisposeBag()
    
    init(router: MenuRouter) {
        self.router = router
    }
    
    private func showCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.cameraDevice = .front
        vc.allowsEditing = true
        vc.delegate = self
        
        router.present(vc)
    }
}

// MARK: UIImagePickerControllerDelegate
extension MenuViewModelImpl: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        extractImage(from: info)
        picker.dismiss(animated: true)
    }
    
    private func extractImage(from info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            _selfieOutput.accept(image)
            return
        }
        
        if let image = info[.originalImage] as? UIImage {
            _selfieOutput.accept(image)
            return
        }
        
        _selfieOutput.accept(nil)
    }
}
