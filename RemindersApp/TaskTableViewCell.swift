//
//  TaskTableViewCell.swift
//  RemindersApp
//
//  Created by Pratheeksha Ravindra Naik on 2018-10-26.
//  Copyright © 2018 Hemanth Kasoju. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    //Properties
    
    @IBOutlet weak var ToDoLabel: UILabel!
    
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var dueLabel: UILabel!
    
    @IBOutlet weak var priorityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
