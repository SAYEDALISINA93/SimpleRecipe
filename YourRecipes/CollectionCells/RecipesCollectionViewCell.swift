//
//  RecipesCollectionViewCell.swift
//  YourRecipes
//
//  Created by Alisina on 02.04.24.
//

import UIKit

class RecipesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var recipe: Recipe? {
        didSet {
            configure(with: recipe)
        }
    }
    
    let mainContainer: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "lightGreen")?.withAlphaComponent(0.5)
        view.layer.cornerRadius = 10
        return view
    }()
    
    let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let caloriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    let sourceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .oliveGreen
        return label
    }()


    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - Setup Data
    
    private func configure(with recipe: Recipe?) {
        guard let recipe = recipe else { return }
        
        titleLabel.text = recipe.label
        caloriesLabel.text = "\(recipe.calories?.rounded() ?? 0.0) Calories"
        ingredientsLabel.text = "\(recipe.ingredients?.count ?? 0) Ingredients"
        sourceLabel.text = "Source: \(recipe.source ?? "")"
        
        if let imageUrl = URL(string: recipe.image ?? "") {
            recipeImageView.load(url: imageUrl)
        } else {
            recipeImageView.image = UIImage(named: "empty")
        }
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        
        self.addSubview(mainContainer)
        mainContainer.addSubview(recipeImageView)
        mainContainer.addSubview(titleLabel)
        mainContainer.addSubview(caloriesLabel)
        mainContainer.addSubview(ingredientsLabel)
        mainContainer.addSubview(sourceLabel)
        
        mainContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        mainContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        mainContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        mainContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
        recipeImageView.centerYAnchor.constraint(equalTo: self.mainContainer.centerYAnchor).isActive = true
        recipeImageView.leadingAnchor.constraint(equalTo: self.mainContainer.leadingAnchor, constant: 5).isActive = true
        recipeImageView.widthAnchor.constraint(equalToConstant: self.frame.size.width / 3).isActive = true
        recipeImageView.heightAnchor.constraint(equalTo: recipeImageView.widthAnchor, multiplier: 1.0).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: recipeImageView.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.recipeImageView.trailingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.mainContainer.trailingAnchor, constant: -8).isActive = true
        
        caloriesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        caloriesLabel.leadingAnchor.constraint(equalTo: self.recipeImageView.trailingAnchor, constant: 8).isActive = true
        caloriesLabel.trailingAnchor.constraint(equalTo: self.mainContainer.trailingAnchor, constant: -8).isActive = true
        
        ingredientsLabel.topAnchor.constraint(equalTo: caloriesLabel.bottomAnchor, constant: 6).isActive = true
        ingredientsLabel.leadingAnchor.constraint(equalTo: self.recipeImageView.trailingAnchor, constant: 8).isActive = true
        ingredientsLabel.trailingAnchor.constraint(equalTo: self.mainContainer.trailingAnchor, constant: -8).isActive = true
        
        sourceLabel.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 10).isActive = true
        sourceLabel.leadingAnchor.constraint(equalTo: self.recipeImageView.trailingAnchor, constant: 8).isActive = true
        sourceLabel.trailingAnchor.constraint(equalTo: self.mainContainer.trailingAnchor, constant: -8).isActive = true
    }
}
