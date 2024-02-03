//
//  ResultViewController.swift
//  DictionMaster
//
//  Created by Vitor Henrique Barreiro Marinho on 03/02/24.
//

import UIKit

class ResultViewController: ViewController {
    @IBOutlet weak var resultTableViewController: UITableView!
    
    private var result: [SearchWordResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureViews() {
        configureTableView()
    }
    
    override func configureBindings() {
    }
    
    private func configureTableView() {
        resultTableViewController.delegate = self
        resultTableViewController.dataSource = self
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
        return UITableViewCell()
    }
}
