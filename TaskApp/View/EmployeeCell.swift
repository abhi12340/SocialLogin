//
//  EmployeeCell.swift
//  TaskApp
//
//  Created by Abhishek Kumar on 09/10/20.
//

import UIKit

enum SelectionOption {
    case name
    case map
}

protocol EmployeeProtocol : class {
    func selectCell(option : SelectionOption)
}

class EmployeeCell: UITableViewCell {
    
    weak var delegate : EmployeeProtocol?
    
    private lazy var employeeName : UILabel = {
        $0.font = UIFont.preferredFont(forTextStyle: .title3)
        $0.textColor = .label
        $0.textAlignment = .center
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
        let tapGeature = UITapGestureRecognizer(target: self, action: #selector(click(_:)))
        $0.addGestureRecognizer(tapGeature)
       return $0
    }(UILabel())
    
    private lazy var showMap : UILabel = {
        $0.font = UIFont.preferredFont(forTextStyle: .title3)
        $0.textColor = .label
        $0.text = "Map"
        $0.textAlignment = .center
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
        let tapGeature = UITapGestureRecognizer(target: self, action: #selector(click(_:)))
        $0.addGestureRecognizer(tapGeature)
       return $0
    }(UILabel())

    func updateCell<T : EmployeeProtocol>(object : Datum? , conform : T) {
        employeeName.text = object?.employeeName
        delegate = conform
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [employeeName , showMap])
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(stackView)
        NSLayoutConstraint.activate([stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
                                     stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
                                     stackView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
                                     stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)])
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("Employee not initialize correctly")
    }
    
    @objc private func click(_ sender : UITapGestureRecognizer) {
        
        if let isGesture = employeeName.gestureRecognizers?.first, isGesture == sender {
            delegate?.selectCell(option: .name)
        } else {
            delegate?.selectCell(option: .map)
        }
        
    }
}
