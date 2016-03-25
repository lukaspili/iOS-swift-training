//
//  GalleryController.swift
//  Training
//
//  Created by Lukasz on 24/03/16.
//  Copyright © 2016 Konsent. All rights reserved.
//

import UIKit

class GalleryController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var images : [UIImage] = []
    
    @IBAction func didTouchPickPicture(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        
        presentViewController(pickerController, animated: true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! GalleryCell
        
        let image = images[indexPath.row]
        cell.imageView.image = image
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let size = UIScreen.mainScreen().bounds.width / 3
        return CGSize(width: size, height: size)
    }
    
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        images.append(image)
        collectionView.reloadData()
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
