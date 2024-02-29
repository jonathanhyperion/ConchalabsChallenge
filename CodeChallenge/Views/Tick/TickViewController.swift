//
//  TickViewController.swift
//  CodeChallenge
//
//  Created by Dev on 8/3/22.
//

import UIKit

struct SliderResult {
    var name: String
    var index: String
    var value: String
}

class TickViewController: UIViewController {
    
    private var viewModel: TickViewModelProtocol
    private var sliderArray: [SliderResult]
    private var ticksData: [Double]
    private var sessionId: Int
    private var lastIndex: Int
    private var sliderCounter: Int = 1
    
    var activityIndicator: UIActivityIndicatorView!
    var originalButtonText: String = ""
    
    // MARK: - UI Components
    
    lazy var sliderView: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.isContinuous = true
        slider.isUserInteractionEnabled = false
        slider.addTarget(self, action: #selector(sliderChangedValue(_:)), for: .valueChanged)
        return slider
    }()
    
    lazy var currentValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Please take this test"
        return label
    }()
    
    lazy var upButton: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 8
        return view
    }()
    
    lazy var upImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "arrow.up")
        image.tintColor = .black
        return image
    }()
    
    lazy var downImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "arrow.down")
        image.tintColor = .black
        return image
    }()
    
    lazy var downButton: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 8
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20.0
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(didTapOnNextButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers

    init(viewModel: TickViewModelProtocol) {
        self.viewModel = viewModel
        self.sliderArray = [SliderResult]()
        self.ticksData = [Double]()
        self.sessionId = 0
        self.lastIndex = 0
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        upButton.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(didTapUpButtonAction(_:)))
        )
        
        downButton.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(didTapDownButtonAction(_:)))
        )
        
        setupLayout()
        setupBindables()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        upButton.layer.cornerRadius = upButton.bounds.height / 2
        downButton.layer.cornerRadius = downButton.bounds.height / 2
    }
    
    // MARK: - Bindables
    
    private func setupBindables() {
        showLoading()
        viewModel.startTick(with: "start")
        
        viewModel.didTickOnSuccess = { [weak self] ticks, firstTime in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                strongSelf.didTickOnSuccess(with: ticks, firstTime: firstTime)
            }
        }
        
        viewModel.didTickOnError = { [weak self] message in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                strongSelf.didTickOnError(with: message)
            }
        }
        
        viewModel.didTickOnComplete = { [weak self] in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                strongSelf.didTickOnComplete()
            }
        }
    }
    
    // MARK: - Properties
    
    private func didTickOnSuccess(with ticks: MLTicks, firstTime: Bool) {
        hideLoading()
        self.view.isUserInteractionEnabled = true
        self.ticksData = ticks.ticks
        
        if self.sessionId == 0 {
            self.sessionId = ticks.sessionId
        }
        
        if self.ticksData.count > 0 {
            updateCurrentLabel(with: self.ticksData[0])
        }
        
        DispatchQueue.main.async {
            self.lastIndex = 0
            self.nextButton.isEnabled = true
            self.sliderView.value = 0
            self.sliderView.isUserInteractionEnabled = true
            self.sliderView.maximumValue = Float(ticks.ticks.count - 1)
            self.sliderView.minimumValue = 0
        }
    }
    
    private func didTickOnError(with message: String) {
        hideLoading()
        self.view.isUserInteractionEnabled = true
        
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Start Over",
                                      style: UIAlertAction.Style.default,
                                      handler: { _ in
            self.restartSliderViews()
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    private func didTickOnComplete() {
        hideLoading()
        self.view.isUserInteractionEnabled = true
        
        let vc = TickDetailViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.sliderArray = self.sliderArray
        
        vc.callbackStartOver = {
            self.restartSliderViews()
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @objc func sliderChangedValue(_ sender: UISlider) {
        let index = (Int)(sender.value + 0.5);
        sender.setValue(Float(index), animated: false)
        
        let value = self.ticksData[index]
        self.lastIndex = index
        
        updateCurrentLabel(with: value)
    }
    
    @objc func didTapOnNextButtonAction(_ sender: UIButton) {
        showLoading()
        self.view.isUserInteractionEnabled = false
        
        self.sliderArray.append(SliderResult(name: "Slider \(sliderCounter)",
                                             index: "\(self.lastIndex)",
                                             value: "\(self.ticksData[self.lastIndex])"))
        sliderCounter += 1
        
        viewModel.nextTick(with: self.sessionId,
                           choice: "\(self.lastIndex)")
    }
    
    @objc func didTapUpButtonAction(_ sender: UITapGestureRecognizer) {
        let currentValue = self.sliderView.value
        
        if currentValue < self.sliderView.maximumValue {
            self.sliderView.value = currentValue + 1
            sliderChangedValue(self.sliderView)
        }
    }
    
    @objc func didTapDownButtonAction(_ sender: UITapGestureRecognizer) {
        let currentValue = self.sliderView.value
        
        if currentValue > self.sliderView.minimumValue {
            self.sliderView.value = currentValue - 1
            sliderChangedValue(self.sliderView)
        }
    }
    
    // MARK: - Helpers
    
    private func restartSliderViews() {
        self.sliderCounter = 1
        self.sliderArray = [SliderResult]()
        self.ticksData = [Double]()
        self.sessionId = 0
        self.lastIndex = 0
        
        DispatchQueue.main.async {
            self.showLoading()
        }
        
        self.viewModel.startTick(with: "start")
    }
    
    private func updateCurrentLabel(with value: Double) {
        DispatchQueue.main.async {
            self.currentValueLabel.text = "Current value: \(value)"
        }
    }
    
    func showLoading() {
        originalButtonText = nextButton.titleLabel?.text ?? ""
        nextButton.setTitle("", for: .normal)
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        showSpinning()
    }

    func hideLoading() {
        nextButton.setTitle(originalButtonText, for: .normal)
        activityIndicator.stopAnimating()
    }

    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .lightGray
        return activityIndicator
    }

    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: nextButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
}

// MARK: - UI Layout

extension TickViewController {
    
    private func setupLayout() {
        
        view.backgroundColor = .white
        
        view.addSubview(sliderView)
        view.addSubview(currentValueLabel)
        view.addSubview(titleLabel)
        view.addSubview(upButton)
        view.addSubview(downButton)
        view.addSubview(nextButton)
        
        upButton.addSubview(upImage)
        downButton.addSubview(downImage)
        
        sliderView.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        
        NSLayoutConstraint.activate([
            
            sliderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            sliderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sliderView.widthAnchor.constraint(equalToConstant: 200),
            
            currentValueLabel.bottomAnchor.constraint(equalTo: sliderView.topAnchor, constant: -116),
            currentValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            currentValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            titleLabel.bottomAnchor.constraint(equalTo: currentValueLabel.topAnchor, constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: currentValueLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: currentValueLabel.trailingAnchor),
            
            upButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -44),
            upButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            upButton.heightAnchor.constraint(equalToConstant: 44),
            upButton.widthAnchor.constraint(equalToConstant: 44),
            
            upImage.centerXAnchor.constraint(equalTo: upButton.centerXAnchor),
            upImage.centerYAnchor.constraint(equalTo: upButton.centerYAnchor),
            upImage.heightAnchor.constraint(equalToConstant: 24),
            upImage.widthAnchor.constraint(equalToConstant: 24),
            
            downButton.topAnchor.constraint(equalTo: upButton.bottomAnchor, constant: 22),
            downButton.trailingAnchor.constraint(equalTo: upButton.trailingAnchor),
            downButton.heightAnchor.constraint(equalToConstant: 44),
            downButton.widthAnchor.constraint(equalToConstant: 44),
            
            downImage.centerXAnchor.constraint(equalTo: downButton.centerXAnchor),
            downImage.centerYAnchor.constraint(equalTo: downButton.centerYAnchor),
            downImage.heightAnchor.constraint(equalToConstant: 24),
            downImage.widthAnchor.constraint(equalToConstant: 24),
            
            nextButton.topAnchor.constraint(equalTo: sliderView.bottomAnchor, constant: 116),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            nextButton.heightAnchor.constraint(equalToConstant: 56)
            
        ])
        
    }
    
}
