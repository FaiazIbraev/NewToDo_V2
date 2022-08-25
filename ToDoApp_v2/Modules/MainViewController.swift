//
//  MainViewController.swift
//  ToDoApp_v2
//
//  Created by Faiaz Ibraev on 20/8/22.
//

import UIKit
import SnapKit

class MainViewController: UIViewController{
    
    private lazy var newTaskButton : UIButton = {
       let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Add new task", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(newTaskButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var searchTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 8
        tf.layer.masksToBounds = true
        tf.placeholder = "Search"
        tf.setLeftPaddingPoints(20)
        
        return tf
    }()
    
    private lazy var taskTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.register(TaskTableViewCell.self, forCellReuseIdentifier: "TaskTableViewCell")
        
        tv.rowHeight = 100
        tv.layer.cornerRadius = 8
        tv.layer.masksToBounds = true
        tv.dataSource = self
        tv.delegate = self
        
        return tv
    }()
    
    var tasks : [Task] = []

    let tasksKey = "Tasks"
    
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Tasks.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        print(filePath)
        setupViews()
        setupContreints()
        getTaskData()
    }
    
    private func setupViews(){
        view.addSubview(searchTextField)
        view.addSubview(taskTableView)
        view.addSubview(newTaskButton)
    }
    
    private func setupContreints(){
        searchTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        taskTableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(100)
        }
        
        newTaskButton.snp.makeConstraints { make in
            make.top.equalTo(taskTableView.snp.bottom).offset(6)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-6)
        }
    }
    
    private func getTaskData(){
        let decoder = PropertyListDecoder()
        
        do{
            if let data = try? Data(contentsOf: filePath!){
                tasks = try decoder.decode([Task].self, from: data)
                self.reloadData()
            }
        }catch{
            print("Failed to decode Data: \(error)")
        }
        
    }
    
    private func saveTasksData(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(self.tasks)
            try data.write(to: filePath!)
        }catch{
            print("Failed to encode Data: \(error)")
        }
        
    }
    
    private func reloadData(){
        DispatchQueue.main.async {
            self.taskTableView.reloadData()
        }
    }
    
    @objc func newTaskButtonTapped (){
        print("Tap")
        
        var tf = UITextField()
        let alertView = UIAlertController(title: "Add new task", message: "Please add new task", preferredStyle: .alert)
        present(alertView, animated: true)
        
        alertView.addTextField { (textField) in
            tf = textField
        }
        
        let action = UIAlertAction(title: "Add task", style: .default) { (action) in
            print("action tapped")
            guard let text = tf.text else {return}
            
            if !text.isEmpty{
                
                let task = Task(title: text, isDone: false)
                
                self.tasks.append(task)
    
                self.reloadData()
                self.saveTasksData()
                
            }
            print("Array: \(self.tasks)")
            
        }
        alertView.addAction(action)
    }
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        
        let task = tasks[indexPath.row]
        
        cell.config(text: task.title, isDone: task.isDone)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        tasks[indexPath.row] = tasks[indexPath.row].changeIsDoneProperty()
        saveTasksData()
        reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            
            tasks.remove(at: indexPath.row)
            saveTasksData()
            reloadData()
        }
    }
    
}
