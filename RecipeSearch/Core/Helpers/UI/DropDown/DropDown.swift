//
//  DropDown.swift
//  RecipeSearch
//
//  Created by Mohamed Shemy on Wed 12 May 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import UIKit

protocol DropDownDelegate : AnyObject
{
    func didSelect(_ item: String, at indexPath: IndexPath)
}

class DropDown : UIView, UITableViewDataSource, UITableViewDelegate
{
    // MARK:- UI
    
    private lazy var collapseButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "collapse"), for: .normal)
        button.addTarget(self, action: #selector(collapseButtonDidTapped), for: .touchUpInside)
        addSubview(button)
        return button
    }()
    
    private lazy var tableView: UITableView =
    {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(cellClass: UITableViewCell.self)
        tableView.layer.cornerRadius = 8
        tableView.tableFooterView = UIView()
        addSubview(tableView)
        return tableView
    }()
    
    // MARK:- Properties
    
    weak var delegate: DropDownDelegate?
    private var items: [String] = []
    private let cellHeight: CGFloat =  40
    private var heightConstraint: NSLayoutConstraint?
    
    var isPresented: Bool { superview != nil }
    
    // MARK:- init
    
    init()
    {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        setup()
    }
    
    // MARK:- Setup
    
    private func setup()
    {
        setupSelf()
        setCollapseButtonConstraints()
        setupTableView()
    }
    
    private func setupSelf()
    {
        translatesAutoresizingMaskIntoConstraints = false
        setHeightConstraint(0)
        layer.cornerRadius = 8
        clipsToBounds = true
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func setupTableView()
    {
        tableView.dataSource = self
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: collapseButton.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setCollapseButtonConstraints()
    {
        NSLayoutConstraint.activate([
            collapseButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            collapseButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collapseButton.heightAnchor.constraint(equalToConstant: 24),
            collapseButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    // MARK:- Methods
    
    func show(_ items: [String], on view: UIView, selectedIndex: IndexPath? = nil)
    {
        guard let superview = view.superview else { return }
        
        display(items: items, selectedIndex: selectedIndex)
        setConstraints(superview, to: view)
        setListHeight()
        superview.layoutIfNeeded()
    }
    
    func hide()
    {
        removeFromSuperview()
        display(items: [])
    }
    
    func update(items: [String], selectedIndex: IndexPath? = nil)
    {
        display(items: items, selectedIndex: selectedIndex)
        setListHeight()
    }
    
    // MARK:- Helper Methods
    
    private func setConstraints(_ superview: UIView, to view: UIView)
    {
        superview.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.bottomAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setListHeight()
    {
        let screenHeight = UIScreen.main.bounds.height
        let viewYOffset = frame.origin.y
        let itemsHeight = CGFloat(items.count + 1) * cellHeight + 24 // collapseButton height
        let height = min(screenHeight - viewYOffset, itemsHeight) - 20 // bottom padding
        
        setHeightConstraint(height)
    }
    
    private func setHeightConstraint(_ value: CGFloat)
    {
        if heightConstraint == nil
        {
            heightConstraint = heightAnchor.constraint(equalToConstant: value)
            heightConstraint?.isActive = true
        }
        else
        {
            heightConstraint?.constant = value
        }
        
        updateConstraintsIfNeeded()
    }
    
    private func display(items: [String], selectedIndex: IndexPath? = nil)
    {
        self.items = items
        tableView.reloadData()
        
        if let index = selectedIndex, (0..<items.count ~= index.row)
        {
            tableView.selectRow(at: selectedIndex, animated: true, scrollPosition: .top)
        }
    }
    
    // MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { items.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeue()
        let item = items[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }
    
    // MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { cellHeight }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        delegate?.didSelect(items[indexPath.row], at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        hide()
    }
    
    // MARK:- Actions
    
    @objc func collapseButtonDidTapped(_ sender: UIButton)
    {
        hide()
    }
}
