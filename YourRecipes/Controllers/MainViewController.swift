//
//  MainViewController.swift
//  YourRecipes
//
//  Created by Alisina on 02.04.24.
//

import UIKit
import Toast_Swift

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    var searchTopConstraint: NSLayoutConstraint!
    
    let viewModel = RecipesViewModel();
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your search phrases here"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let searchButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Search", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .oliveGreen
        btn.layer.cornerRadius = 8
        btn.tintColor = .white
        return btn
    }()
    
    let listTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Recipes"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RecipesCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "mainPage"
        searchTextField.accessibilityIdentifier = "SearchField"
        
        setupViews()
        setupCollectionView()
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(listTitle)
        view.addSubview(collectionView)
        
        searchTextField.setLeftView(image: UIImage.init(named: "ic-search")!)
        
        collectionView.isHidden = true
        listTitle.isHidden = true
        
        searchTopConstraint = searchTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        searchTopConstraint.isActive = true
        
        searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        searchTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        
        searchButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        searchButton.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor, constant: 20).isActive = true
        
        listTitle.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 20).isActive = true
        listTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        listTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: listTitle.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Add target for search button
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    @objc private func searchButtonTapped() {
        
        self.navigationController?.view.makeToastActivity(.center)
        
        guard let keywords = searchTextField.text, !keywords.isEmpty else {
            self.navigationController?.view.hideToastActivity()
            self.navigationController?.view.makeToast("Please enter your phrase!!!", duration: 3.0, position: .bottom)
            return
        }
        
        self.viewModel.fetchData(params: keywords) { result in
            switch result {
            case .success(let data):
                
                if data.count! > 0 {
                    
                    UIView.animate(withDuration: 0.5) {
                        self.searchTopConstraint.isActive = false
                        self.searchTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
                        self.view.layoutIfNeeded()
                        self.collectionView.isHidden = false
                        self.listTitle.isHidden = false
                    }
                    
                }else{
                    self.navigationController?.view.makeToast("Data not found!!!", duration: 3.0, position: .bottom)
                }
                
                self.collectionView.reloadData()
                self.navigationController?.view.hideToastActivity()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                self.navigationController?.view.hideToastActivity()
                self.navigationController?.view.makeToast(error.localizedDescription, duration: 3.0, position: .bottom)
            }
        }
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.searchResult?.hits?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 12)
        let height = width * 0.45
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RecipesCollectionViewCell
        
        cell.recipe = viewModel.searchResult?.hits?[indexPath.item]?.recipe
        
        return cell
    }
}
