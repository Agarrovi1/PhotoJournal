//
//  AddPhotoViewController.swift
//  PhotoJournal
//
//  Created by Angela Garrovillas on 10/1/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController {
    
    //MARK: - Properties
    var currentPic: PhotoInfo?
    var currentPicTag = 0
    var mode: AddOrEdit = .add
    
    //MARK: - Outlets
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var picImageView: UIImageView!
    
    //MARK: - Actions
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        switch mode {
        case .add:
            saveNewEntry()
        case .edit:
            saveExistingEntry()
        }
    }
    
    @IBAction func photoLibraryPressed(_ sender: UIBarButtonItem) {
        openImagePicker()
    }
    
    //MARK: - Functions
    private func saveExistingEntry() {
        guard let image = picImageView.image else {return}
        guard let data = image.pngData() else {return}
        let editedPhotoInfo = PhotoInfo(imageData: data, summary: summaryTextView.text)
        DispatchQueue.global(qos: .utility).async {
            do {
                try PhotoInfoPersistance.manager.saveNewChanges(to: editedPhotoInfo, tag: self.currentPicTag)
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            } catch {
                print(error)
            }
        }
    }
    private func saveNewEntry() {
        guard let image = picImageView.image else {return}
        guard image != UIImage(named: "blankImage") else {return}
        guard let data = image.pngData() else {return}
        let photoInfo = PhotoInfo(imageData: data, summary: summaryTextView.text)
        DispatchQueue.global(qos: .utility).async {
            do {
                try PhotoInfoPersistance.manager.save(newPhoto: photoInfo)
                DispatchQueue.main.async {
                    
                    self.dismiss(animated: true)
                }
                
            } catch {
                print(error)
            }
        }
    }
    private func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    private func setupTextView() {
        summaryTextView.delegate = self
        switch mode {
        case .add:
            summaryTextView.text = "Enter description here..."
            summaryTextView.textColor = UIColor.lightGray
        case .edit:
            guard let currentPic = currentPic else {return}
            summaryTextView.text = currentPic.summary
        }
    }
    private func setupImage() {
        switch mode {
        case .add:
//            picImageView.image = UIImage(named: "blankImage")
           return
        case .edit:
            guard let currentPic = currentPic else {return}
            picImageView.image = UIImage(data: currentPic.imageData)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        setupImage()
        setupDarkModeDefaults()
    }

}
extension AddPhotoViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {return}
        picImageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
}

extension AddPhotoViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if summaryTextView.textColor == UIColor.lightGray {
            summaryTextView.text = ""
            summaryTextView.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if summaryTextView.text.isEmpty {
            summaryTextView.text = "Enter description here..."
            summaryTextView.textColor = .lightGray
        }
    }
}
extension AddPhotoViewController: DefaultSettings {
    var darkMode: Bool? {
        UserDefaultWrapper.manager.getDarkMode()

    }
    
    var verticalScroll: Bool? {
    UserDefaultWrapper.manager.getVerticalScroll()
    }
    
    func setupDarkModeDefaults() {
        guard let darkMode = darkMode else {return}
        self.view.backgroundColor = darkMode ? .darkGray : .white
    }
    
    func setupScrollDefaults() {
        
    }
}
