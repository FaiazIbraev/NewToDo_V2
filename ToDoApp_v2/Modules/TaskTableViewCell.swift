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
    
    private lazy var checkImage : UIImageView = {
        let image = UIImageView()
//        image.backgroundColor = .yellow
        
        return image
    }()
    
    private lazy var checkMarkImage = UIImage(systemName: "checkmark.seal.fill")
        
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(label)
        addSubview(checkImage)
        
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(checkImage.snp.leading).offset(-10)
        }
//        label.backgroundColor = .green
        
        checkImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(text: String, isDone: Bool){
        label.text = text
        
        checkImage.image = isDone ? checkMarkImage : .none
    }
    
}
