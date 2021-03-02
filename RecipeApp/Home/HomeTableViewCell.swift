//
//  HomeTableViewCell.swift
//  RecipeApp
//
//  Created by Anuar Nordin on 02/03/2021.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImages: UIImageView!
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellDeleteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        cellName.textColor = .white
        cellName.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        cellDeleteBtn.rounded(radius: 22)
    }
    
    @IBAction func xBtnPressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("deleteCell"), object: nil, userInfo: ["passInt": sender.tag])
    }
}
