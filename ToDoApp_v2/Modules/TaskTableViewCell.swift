//
//  TaskTableViewCell.swift
//  ToDoApp_v2
//
//  Created by Faiaz Ibraev on 20/8/22.
//

import UIKit

class TaskTableViewCell : UITableViewCell{
    
    private lazy var label : UILabel = {
        let label = UILabel()
        label.text = "asd"
        
        return label
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(text: String){
        label.text = text
    }
    
}
