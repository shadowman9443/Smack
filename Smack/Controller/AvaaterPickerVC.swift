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
            return cell
        }
        return AvaterCellCollectionViewCell()
    }
    
   
    
    
   
        
    @IBAction func segmentContrlPrsd(_ sender: Any) {
        
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
