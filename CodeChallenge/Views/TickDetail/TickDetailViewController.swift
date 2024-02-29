//
//  TickDetailViewController.swift
//  CodeChallenge
//
//  Created by Dev on 8/3/22.
//

import UIKit

class TickDetailViewController: UIViewController {
    
    var callbackStartOver: (() -> Void)?
    
    var sliderArray: [SliderResult]?
    
    // MARK: - UI Components
    
    lazy var resultTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Slider Results"
        return label
    }()
    
    lazy var stackviewSliderResult: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        return stackview
    }()
    
    lazy var startOverButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20.0
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Start over".uppercased(), for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(didTapOnStartOverAction(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    // MARK: - Actions
    
    @objc func didTapOnStartOverAction(_ sender: UIButton) {
        guard let callback = callbackStartOver else { return }
        
        dismiss(animated: true) {
            callback()
        }
    }
    
}

// MARK: - UI Layout

extension TickDetailViewController {
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(resultTitleLabel)
        view.addSubview(stackviewSliderResult)
        view.addSubview(startOverButton)
        
        guard let result = self.sliderArray else { return }
        
        for slider in result {
            let stackview = UIStackView()
            stackview.translatesAutoresizingMaskIntoConstraints = false
            stackview.axis = .horizontal
            stackview.distribution = .fillEqually
            
            let nameLabel = UILabel()
            nameLabel.text = slider.name
            nameLabel.textColor = .black
            nameLabel.textAlignment = .left
            
            let indexLabel = UILabel()
            indexLabel.text = slider.index
            indexLabel.textColor = .black
            indexLabel.textAlignment = .center
            
            let valueLabel = UILabel()
            valueLabel.text = slider.value
            valueLabel.textColor = .black
            valueLabel.textAlignment = .right
            
            stackview.addArrangedSubview(nameLabel)
            stackview.addArrangedSubview(indexLabel)
            stackview.addArrangedSubview(valueLabel)
            
            stackviewSliderResult.addArrangedSubview(stackview)
        }
        
        NSLayoutConstraint.activate([
            
            resultTitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            resultTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            stackviewSliderResult.topAnchor.constraint(equalTo: resultTitleLabel.bottomAnchor, constant: 16),
            stackviewSliderResult.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackviewSliderResult.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            startOverButton.topAnchor.constraint(equalTo: stackviewSliderResult.bottomAnchor, constant: 24),
            startOverButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            startOverButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            startOverButton.heightAnchor.constraint(equalToConstant: 56)
            
        ])
    }
    
}
