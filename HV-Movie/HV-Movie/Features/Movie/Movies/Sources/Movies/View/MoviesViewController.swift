//
//  MoviesViewController.swift
//  
//
//  Created by Huseyin Vural on 25.08.2024.
//

import UIKit
import ToolKit
import UiComponents
import MVVMKit

final class MoviesViewController<VM: MoviesViewModelable>: BaseXibViewController<VM>, UITextFieldDelegate {
    @IBOutlet private weak var list: UITableView!
    @IBOutlet private weak var searchView: SearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindVieWModelObservers() {
        super.bindVieWModelObservers()
        
        viewModel.observer = { [weak self] action in
            guard let self else { return }
            
            switch action {
            case .bindList(let handler):
                list.separatorColor = .clear
                list.rowHeight = UITableView.automaticDimension
                list.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
                list.register(cellType: MovieTableViewCell.self, bundle: .module)
                list.dataSource = handler
                list.delegate = handler
                
                searchView.searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                searchView.searchTextField.delegate = self
            case .reload:
                list.reloadData()
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        viewModel.didChangeSearchText(textField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.didTapSearchDone()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        viewModel.didSearchClear()
        return true
    }
}
