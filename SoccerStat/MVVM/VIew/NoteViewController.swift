//
//  NoteViewController.swift
//  SoccerStat
//
//  Created by Aleksandr Gordeev on 25.11.2022.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

protocol NoteViewControllerDelegate {
    func saveNoteDidPress()
    func cancelDidPress()
}

final class NoteViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private lazy var titleTextEdit = UITextField(frame: .zero) .. {
        view.addSubview($0)
        
        $0.backgroundColor = .appBlack
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.appOrange.cgColor
        $0.textColor = .appWhite
        $0.font = $0.font?.withSize(16)
        $0.tintColor = .appWhite
        $0.attributedPlaceholder = NSAttributedString(
            string: "Title",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.appGray]
        )
        $0.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.equalTo(40)
        }
    }
 
    private lazy var contentTextView = UITextView(frame: .zero) .. {
        view.addSubview($0)
        
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.appOrange.cgColor
        $0.textColor = .appWhite
        $0.backgroundColor = .appBlack
        $0.font = $0.font?.withSize(16)
        
        $0.snp.makeConstraints { make in
            make.top.equalTo(titleTextEdit.snp.bottom).offset(5)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.bottom.equalTo(saveButton.snp.top).offset(-30)
        }
    }
    
    private lazy var saveButton = UIButton() .. {
        view.addSubview($0)
        
        $0.setTitle("Save", for: .normal)
        $0.rx.tap.bind { [weak self] in
            self?.saveNote()
        }
        .disposed(by: disposeBag)
        
        $0.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-10)
            make.bottom.equalTo(view).offset(-10)
            make.height.equalTo(30)
            make.width.equalTo(view).multipliedBy(0.4)
        }
    }
    
    private lazy var cancelButton = UIButton() .. {
        view.addSubview($0)
        
        $0.setTitle("Cancel", for: .normal)
        $0.rx.tap.bind { [weak self] in
            self?.delegate?.cancelDidPress()
        }
        .disposed(by: disposeBag)
        
        $0.snp.makeConstraints { make in
            make.left.equalTo(view).offset(10)
            make.bottom.equalTo(view).offset(-10)
            make.height.equalTo(30)
            make.width.equalTo(view).multipliedBy(0.4)
        }
    }
    
    public var viewModel: NoteViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    public var delegate: NoteViewControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.fetchData()
    }
}

private extension NoteViewController {
    func bindViewModel() {
        viewModel?.noteSubject.bind(onNext: { [weak self] note in
            self?.titleTextEdit.text = note.title
            self?.contentTextView.text = note.content
        })
        .disposed(by: disposeBag)
    }
    
    func saveNote() {
        viewModel?.saveNote(title: titleTextEdit.text ?? "", content: contentTextView.text)
        delegate?.saveNoteDidPress()
    }
}
