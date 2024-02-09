//
//  ResultViewController.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 03/02/24.
//

import UIKit

class ResultViewController: ViewController {
    @IBOutlet weak var resultTableViewController: UITableView!
    @IBOutlet weak var headerView: HeaderView!
    
    var viewModel: ResultViewModelProtocol?
    private var result: [SearchWordResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setList()
    }
    
    override func configureViews() {
        configureTableView()
    }
    
    private func configureTableView() {
        resultTableViewController.delegate = self
        resultTableViewController.dataSource = self
        resultTableViewController.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        resultTableViewController.separatorStyle = .none
        
        resultTableViewController.register(UINib(nibName: "BottomView", bundle: nil), forHeaderFooterViewReuseIdentifier: "BottomView")
        
        let bottomView = resultTableViewController.dequeueReusableHeaderFooterView(withIdentifier: "BottomView") as! BottomView
        
        let action: VoidFunc? = { self.viewModel?.dismiss()
        }
        
        bottomView.configure(action: action)
        
        resultTableViewController.tableFooterView = bottomView
    }
    
    private func setList() {
        guard let result = viewModel?.getResult else { return }
        self.result = result
    }
}

extension ResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = resultTableViewController.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell {
            let result = result[indexPath.row]
            cell.configure(with: result, index:indexPath.row)
            headerView.configure(result)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 203
    }
    
    func showFooterView() {
        if let bottomView = resultTableViewController.dequeueReusableHeaderFooterView(withIdentifier: "BottomView") as? BottomView {
            let action: VoidFunc? = { self.viewModel?.dismiss() }
            bottomView.configure(action: action)
            resultTableViewController.tableFooterView = bottomView
        }
    }
}



