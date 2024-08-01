//
//  MealTypesCollectionViewCell.swift
//  TestAssignment_UIKit_IA
//
//  Created by NeoSOFT on 01/08/24.
//

import UIKit

class MealTypesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - setup UI elements
    let thumbnailImageView: CustomListImageView = {
        let imageView = CustomListImageView(frame: .zero)
        imageView.layer.cornerRadius = 5.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(thumbnailImageView)
        
        // MARK: - setup auto layout constraints
        thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
