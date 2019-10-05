//
//  AddPhotoViewController.swift
//  PhotoJournal
//
//  Created by Angela Garrovillas on 10/1/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController {
    
    var delegate: CollectionReload?
    
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var picImageView: UIImageView!
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        guard let image = picImageView.image else {return}
        guard let data = image.pngData() else {return}
        let photoInfo = PhotoInfo(imageData: data, summary: summaryTextView.text)
        DispatchQueue.global(qos: .utility).async {
            do {
                try PhotoInfoPersistance.manager.save(newPhoto: photoInfo)
                DispatchQueue.main.async {
                    
                    self.dismiss(animated: true) {
                        self.delegate?.reloadCollectionView()
                    }
                }
                
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func photoLibraryPressed(_ sender: UIBarButtonItem) {
        openImagePicker()
    }
    
    private func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    private func setupTextView() {
        summaryTextView.delegate = self
        summaryTextView.text = "Enter description here..."
        summaryTextView.textColor = UIColor.lightGray
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
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
