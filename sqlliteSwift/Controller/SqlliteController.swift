//
//  SqlliteController.swift
//  sqlliteSwift
//
//  Created by ahmad shiddiq on 03/02/21.
//  Copyright © 2021 ahmad shiddiq. All rights reserved.
//

import Foundation
import UIKit

class SqlliteController: UIViewController {
    @IBOutlet weak var listDataTableView: UITableView!
    var db: DBHelper = DBHelper()
    var person: [Person] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewSetting()
        insertPersonData()
        print("total person: ",person)
    }
    func setupTableViewSetting() {
        listDataTableView.delegate = self
        listDataTableView.dataSource = self
        listDataTableView.register(UINib(nibName: "SqliteCell", bundle: nil),
        forCellReuseIdentifier: "SqliteCell")
    }
    private func insertPersonData() {
        db.insert(idPerson: 1, namePerson: "Anton", agePerson: 20)
        db.insert(idPerson: 1, namePerson: "Anton", agePerson: 20)
        db.insert(idPerson: 1, namePerson: "Anton", agePerson: 20)
        db.insert(idPerson: 1, namePerson: "Anton", agePerson: 20)
        db.insert(idPerson: 1, namePerson: "Anton", agePerson: 20)
        person = db.read()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
extension SqlliteController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return person.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SqliteCell", for: indexPath) as? SqliteCell
            else { return .init() }
        cell.labelName.text = person[indexPath.row].name
        return cell
    }
}
