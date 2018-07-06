//
//  AvaaterPickerVC.swift
//  Smack
//
//  Created by aunogarafat on 7/6/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import UIKit

class AvaaterPickerVC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource ,
UICollectionViewDelegateFlowLayout {
    
    
    
    
    //out let
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var segementcontrol: UISegmentedControl!
    
    //variables
    var avtarTypes = AvatarType.dark
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collectionview.delegate = self
        collectionview.dataSource = self
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "avavaterCell", for: indexPath) as? AvaterCellCollectionViewCell {
            cell.configureCell(index: indexPath.item, type: avtarTypes)
            return cell
        }
        return AvaterCellCollectionViewCell()
    }
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numofcolumn : CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numofcolumn = 4
        }
        let spaceBetweenCells : CGFloat = 10
        let padding : CGFloat = 40
        let cellDimension = ((collectionView.bounds.width - padding) -
        (numofcolumn - 1) * spaceBetweenCells) / numofcolumn
        
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
   
        
    @IBAction func segmentContrlPrsd(_ sender: Any) {
        if segementcontrol.selectedSegmentIndex == 0 {
            avtarTypes = AvatarType.dark
            collectionview.reloadData()
        }else if segementcontrol.selectedSegmentIndex == 1 {
            avtarTypes = AvatarType.light
            collectionview.reloadData()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avtarTypes == .dark {
           UserService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
            
        }else{
            UserService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
