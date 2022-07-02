//
//  AddNotesVC.swift
//  WriteX
//
//  Created by Ahmed Fathy on 06/03/2022.
//

import UIKit
import Combine
import CombineCocoa

enum StateOfAddNote{
    case add
    case edit
}

protocol ConfirmEditNote: AnyObject {
    // Note That Done
    func configureNote (_ note: Note, isHidden: Bool)
    
}



class AddNotesVC: UIViewController {
    
    var viewModel: AddNotesViewModel!
    var cancelable = Set<AnyCancellable>()
    weak var delegate: ConfirmAddNote!
    
    //MARK: - Outlet
    
    @IBOutlet weak var titleTextField: UITextField! { didSet { titleTextField.layer.cornerRadius = 5}}
    @IBOutlet weak var discriptionTextView: UITextView!{ didSet { discriptionTextView.layer.cornerRadius = 10}}
    @IBOutlet weak var heightOfTextView: NSLayoutConstraint!
    
    private let saveButtonItem   = UIBarButtonItem(title: "Save", style: .done, target: nil, action: nil)
    private let cancelButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: nil, action: nil)
    
    //MARK: - Lyfe Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextView()
        bindToSetupTitle()
        bindFieldsToViewModel()
        bindToSetFields()
        bindToChangeButtonAction()
        configureNavigationBar()
        configureBarButton()
    }
    
    
    //MARK: - Confirm UI
    func configureNavigationBar(){
        navigationItem.rightBarButtonItem = saveButtonItem
        navigationItem.leftBarButtonItem  = cancelButtonItem
    }
    
    
    
    //MARK: - Binding
    
    
    func bindFieldsToViewModel(){
        titleTextField.creatTextFieldBinding(with: viewModel.titleNote, storeIn: &cancelable)
        discriptionTextView.creatTextViewBinding(with: viewModel.discriptionNote, storeIn: &cancelable)
    }
    
    func bindToSetupTitle(){
        viewModel.$stateOfView.sink { state in
            switch state {
            case .add:
                self.title = "Add Note"
            case .edit:
                self.title = "Edit Note"
            }
        }.store(in: &cancelable)
    }
    
    func bindToSetFields(){
        if title == "Edit Note" {
            viewModel.$note.sink { note in
                self.titleTextField.text = note?.title.withNewSpaceIfFound()
                self.discriptionTextView.text = note?.discription.withNewSpaceIfFound()
            }.store(in: &cancelable)
        }
    }
    
    func bindToChangeButtonAction(){
        viewModel.changeStateOfButton().sink { state in
            print(state)
        }.store(in: &cancelable)
    }
    
    
    //MARK: - Actions
    
    func configureBarButton(){
        Task{
            await configureSaveButtonAction()
            await configureCancelButtonAction()
        }
    }
    
    func configureSaveButtonAction()async {
        DispatchQueue.main.async {
            self.saveButtonItem.tapPublisher.receive(on: DispatchQueue.main).sink { _ in
                // return note
                let note = Note(title: self.viewModel.titleNote.value,
                                discription: self.viewModel.discriptionNote.value,
                                date: getCurrentData(), isHidden: self.viewModel.isHiddenNote)
                self.delegate.confirmAddNote(note: note)
                self.dismiss(animated: true, completion: nil)
            }.store(in: &self.cancelable)
        }
    }
    
    func configureCancelButtonAction()async {
        DispatchQueue.main.async {
            self.cancelButtonItem.tapPublisher.sink { _ in
                self.dismiss(animated: true, completion: nil)
            }.store(in: &self.cancelable)
        }
    }
    
    
    
    
}

