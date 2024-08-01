//
//  MealListTableViewCell.swift
//  TestAssignment_UIKit_IA
//
//  Created by NeoSOFT on 01/08/24.
//

import UIKit

class MealListTableViewCell: UITableViewCell {
    
    // MARK: - setup varibles
    private var subTitleLabelHeightConstraint: NSLayoutConstraint?
    
    // MARK: - setup UI elements
    let mainView: CustomListMainView = {
        let view = CustomListMainView()
        view.clipsToBounds = false
        view.addShadow()
        return view
    }()
    
    let thumbnailImageView: CustomListImageView = {
        let imageView = CustomListImageView(frame: .zero)
        imageView.layer.cornerRadius = 5.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: CustomListTitleLabel = {
        let label = CustomListTitleLabel()
        return label
    }()
    
    let subTitleLabel: CustomListSubTitleLabel = {
        let label = CustomListSubTitleLabel()
        return label
    }()
    
    // MARK: - setterObj
    var setterObj: ListData? {
        didSet {
            thumbnailImageView.image = UIImage(named: setterObj?.image ?? "")
            titleLabel.text = setterObj?.title
            subTitleLabel.text = setterObj?.subtitle
        }
    }
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(mainView)
        mainView.addSubview(thumbnailImageView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(subTitleLabel)
        
        // MARK: - setup auto layout constraints
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        mainView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        thumbnailImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 12).isActive = true
        thumbnailImageView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalToConstant: 76).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: 76).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 12).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -12).isActive = true
        titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor, constant: 2).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        subTitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        subTitleLabelHeightConstraint = subTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 48)
        subTitleLabelHeightConstraint?.isActive = true
        subTitleLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
