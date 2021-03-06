//
//  MenuViewController.swift
//  Location
//
//  Created by Yuriy Fedyunkin on 03.11.2021.
//

import RxSwift

final class MenuViewController: UIViewController {
    
    var viewModel: MenuViewModel!

    private let shadowView = ShadowView()
    private let takeSelfieButton = BaseButton()
    private let showMapButton = BaseButton()
    private let avatarView = AvatarView()
    
    private let disposeBag = DisposeBag()
    private let appearance = Appearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
    }
    
    private func setupViews() {
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = appearance.title
                
        view.addSubview(shadowView)
        shadowView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).inset(appearance.topInset)
            make.centerX.equalToSuperview()
            make.size.equalTo(appearance.avatarSize)
        }
        
        avatarView.layer.cornerRadius = appearance.avatarSize.height / 2
        avatarView.clipsToBounds = true
        shadowView.addSubview(avatarView)
        avatarView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        
        takeSelfieButton.setTitle(appearance.selfieButtonTitle, for: .normal)
        takeSelfieButton.layer.cornerRadius = appearance.buttonSize.height / 2
        takeSelfieButton.backgroundColor = .black
        view.addSubview(takeSelfieButton)
        takeSelfieButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(shadowView.snp.bottom).inset(-appearance.inset)
            make.size.equalTo(appearance.buttonSize)
        }
        
        showMapButton.setTitle(appearance.mapButtonTitle, for: .normal)
        showMapButton.layer.cornerRadius = appearance.buttonSize.height / 2
        showMapButton.backgroundColor = .black
        view.addSubview(showMapButton)
        showMapButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(takeSelfieButton.snp.bottom).inset(-appearance.inset)
            make.size.equalTo(appearance.buttonSize)
        }
    }
    
    private func setupBindings() {
        viewModel.selfieOutput
            .drive(onNext: { [weak self] image in
                self?.avatarView.setAvatar(with: image)
            })
            .disposed(by: disposeBag)
        
        takeSelfieButton.rx.tap
            .bind(to: viewModel.didTapSelfieButton)
            .disposed(by: disposeBag)
        
        showMapButton.rx.tap
            .bind(to: viewModel.didTapShowMap)
            .disposed(by: disposeBag)
    }
}

extension MenuViewController {
    struct Appearance {
        let title = "????????"
        let selfieButtonTitle = "?????????????? ??????????"
        let mapButtonTitle = "??????????"
        let topInset: CGFloat = 32
        let inset: CGFloat = 24
        let buttonSize = CGSize(width: 200, height: 40)
        let avatarSize = CGSize(width: 300, height: 300)
    }
}

