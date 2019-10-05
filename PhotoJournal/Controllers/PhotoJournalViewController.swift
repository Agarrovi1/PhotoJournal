//
//  PhotoJournalViewController.swift
//  PhotoJournal
//
//  Created by Angela Garrovillas on 10/1/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class PhotoJournalViewController: UIViewController {
    //MARK: - Properties
    var photoEntries = [PhotoInfo]() {
        didSet {
            photoCollectionView.reloadData()
        }
    }
    //MARK: - Outlets
    @IBOutlet weak var photoCollectionView: UICollectionView!
    //MARK: - Actions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let addPhotoVC = storyboard.instantiateViewController(identifier: "AddPhotoVC") as? AddPhotoViewController else {return}
        addPhotoVC.mode = .add
        addPhotoVC.modalPresentationStyle = .currentContext
        present(addPhotoVC, animated: true, completion: nil)
    }
    @IBAction func settingsButtonPressed(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let SettingVC = storyboard.instantiateViewController(identifier: "SettingVC") as? SettingsTableViewController else {return}
        SettingVC.modalPresentationStyle = .currentContext
        present(SettingVC, animated: true, completion: nil)
    }
    
    //MARK: - Functions
    private func setDelegates() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        
    }
    private func loadSavedPics() {
        DispatchQueue.main.async {
            do {
                let newEntries = try PhotoInfoPersistance.manager.getPhotos()
                self.photoEntries = newEntries
            } catch {
                print(error)
            }
        }
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
    override func viewWillAppear(_ animated: Bool) {
        loadSavedPics()
        setupDarkModeDefaults()
    }
    
}
//MARK: - Extensions
extension PhotoJournalViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoEntries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoEntryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let photo = photoEntries[indexPath.row]
        if let image = UIImage(data: photo.imageData) {
            cell.picImageView.image = image
        }
        cell.summaryLabel.text = photo.summary
        cell.dateLabel.text = "\(photo.date)"
        cell.pageControl.tag = indexPath.row
        cell.delegate = self
        return cell
    }
}

extension PhotoJournalViewController: PhotoEntryCellDelegate {
    func showActionSheet(tag: Int) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let delete = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            do {
                try PhotoInfoPersistance.manager.delete(tag: tag)
                let index = IndexPath(item: tag, section: 0)
                
                self.photoCollectionView.deleteItems(at: [index])
                self.loadSavedPics()
            } catch {
                print(error)
            }
        }
        let edit = UIAlertAction(title: "Edit", style: .default) { _ in
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            guard let addPhotoVC = storyboard.instantiateViewController(identifier: "AddPhotoVC") as? AddPhotoViewController else {return}
            addPhotoVC.mode = .edit
            addPhotoVC.currentPic = self.photoEntries[tag]
            addPhotoVC.currentPicTag = tag
            addPhotoVC.modalPresentationStyle = .currentContext
            self.present(addPhotoVC, animated: true, completion: nil)
        }
        //               let share = UIAlertAction(title: "Share", style: .default, handler: <#T##((UIAlertAction) -> Void)?##((UIAlertAction) -> Void)?##(UIAlertAction) -> Void#>)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(delete)
        actionSheet.addAction(edit)
        actionSheet.addAction(cancel)
        self.present(actionSheet, animated: true, completion: nil)
    }
}
extension PhotoJournalViewController: DefaultSettings {
    var darkMode: Bool? {
        UserDefaultWrapper.manager.getDarkMode()

    }
    
    var verticalScroll: Bool? {
    UserDefaultWrapper.manager.getVerticalScroll()
    }
    
    func setupDarkModeDefaults() {
        guard let darkMode = darkMode else {return}
        self.photoCollectionView.backgroundColor = darkMode ? .darkGray : .white
    }
    
    func setupScrollDefaults() {
        
    }
}
