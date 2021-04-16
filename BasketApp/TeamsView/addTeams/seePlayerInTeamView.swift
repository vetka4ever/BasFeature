//
//  seePlayerInTeamView.swift
//  BasketApp
//
//  Created by Daniil on 09.02.2021.
//

import UIKit

class seePlayerInTeamView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        seePlayer.dataSource = self
        seePlayer.delegate = self
        
    }
    @IBOutlet var seePlayer: UITableView!
    let idCell = "seePlayerCell"
    
}
extension seePlayerInTeamView: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: idCell)
        return cell
    }
    
    
}
