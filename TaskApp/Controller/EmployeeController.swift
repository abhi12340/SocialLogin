//
//  EmployeeController.swift
//  TaskApp
//
//  Created by Abhishek Kumar on 09/10/20.
//

import UIKit

class EmployeeController: UIViewController {
    
    private var viewModel = EmployeeViewModel()

    private let cellId = "EmployeeCell"
    
    private lazy var tableView : UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 0.2
        $0.layer.borderColor = UIColor.gray.cgColor
        return $0
    }(UITableView())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableview()
        registerCell()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        viewModel.getEmployeeDetails()
        
    }
    
    private func registerCell() {
        tableView.register(EmployeeCell.self, forCellReuseIdentifier: cellId)
    }
    
    private func setupTableview() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
                                     tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18)])
    }
    
}

extension EmployeeController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fetchDetails()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? EmployeeCell
        cell?.updateCell(object: viewModel.fetchDetails()?[indexPath.row], conform: self)
        return cell ?? UITableViewCell()
    }
}

extension EmployeeController : EmployeeProtocol {
    
    func selectCell(option: SelectionOption) {
        switch option {
        case .map:
            print("map")
        case .name:
            print("name")
        }
    }
    
}
