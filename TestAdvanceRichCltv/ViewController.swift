//
//  ViewController.swift
//  TestAdvanceRichCltv
//
//  Created by Dev on 6/6/2566 BE.
//

import UIKit
import Gemini

class ViewController: UIViewController {

    @IBOutlet weak var cltvRichAdvance: GeminiCollectionView!
    private let reuseCellCltv = "CltvAdvanceViewCell"
    private var imgArrShow:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cltvRichAdvance.register(UINib(nibName: "CltvAdvanceCell", bundle: nil), forCellWithReuseIdentifier: reuseCellCltv)
        cltvRichAdvance.dataSource = self
        cltvRichAdvance.delegate = self
        cltvRichAdvance.contentInsetAdjustmentBehavior = .never
        self.configureAnimation()
        for num in stride(from: 1, to: 6, by: 1){
            imgArrShow.append("img\(num)")
        }
        DispatchQueue.main.async {
            self.cltvRichAdvance.reloadData()
            print("imgArrShow -> \(self.imgArrShow)")
        }
    }
    
    func collectioViewSetup( sender: UICollectionView) {
        switch sender{
        case cltvRichAdvance:
            let layout = UICollectionViewPagingFlowLayout()
            layout.itemSize = CGSize(width: self.cltvRichAdvance.bounds.width - 100, height: self.cltvRichAdvance.bounds.height - 200)
            layout.sectionInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
            layout.minimumLineSpacing = 10
            layout.scrollDirection = .horizontal

            self.cltvRichAdvance.collectionViewLayout = layout
            self.cltvRichAdvance.reloadData()
        default:
            break
        }
    }

    
    func configureAnimation() {
        cltvRichAdvance.gemini
            .customAnimation()
            .translation(x:0, y: 50, z:0)
            .rotationAngle(x:0, y: 13, z:0)
            .ease(.easeOutExpo)
            .shadowEffect(.fadeIn)
            .maxShadowAlpha(0.3)
        collectioViewSetup(sender: cltvRichAdvance)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        cltvRichAdvance.animateVisibleCells()
    }
}

extension ViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArrShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCellCltv, for: indexPath) as! CltvAdvanceCell
        let md = imgArrShow[indexPath.row]
        cell.imgShow.image = UIImage(named: md)
        self.cltvRichAdvance.animateCell(cell)
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.cltvRichAdvance.animateCell(cell)
        }
    }
}
