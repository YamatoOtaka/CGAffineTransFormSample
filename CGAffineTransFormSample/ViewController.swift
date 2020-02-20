//
//  ViewController.swift
//  CGAffineTransFormSample
//
//  Created by 大高倭 on 2020/02/17.
//  Copyright © 2020 yamatootaka. All rights reserved.
//

import UIKit

enum EventType: CaseIterable {
    case rotation
    case translate
    case scaleUp
    case scaleDown
    case shear
    case rotationUpperLeft
    case translateUpperLeft
    case scaleUpUpperLeft
    case scaleDownUpperLeft
    case shearUpperLeft
    case rotationAndTranslateUpperLeft
    case rotationAndScaleUpUpperLeft
    case rotationAndScaleDownUpperLeft
    case translateAndScaleUpUpperLeft
    case translateAndScaleDownUpperLeft

    var title: String {
        switch self {
        case .rotation:
            return "回転"
        case .translate:
            return "移動"
        case .scaleUp:
            return "拡大"
        case .scaleDown:
            return "縮小"
        case .shear:
            return "せん断"
        case .rotationUpperLeft:
            return "回転(左上)"
        case .translateUpperLeft:
            return "移動(左上)"
        case .scaleUpUpperLeft:
            return "拡大(左上)"
        case .scaleDownUpperLeft:
            return "縮小(左上)"
        case .shearUpperLeft:
            return "せん断(左上)"
        case .rotationAndTranslateUpperLeft:
            return "回転&移動(左上)"
        case .rotationAndScaleUpUpperLeft:
            return "回転&拡大(左上)"
        case .rotationAndScaleDownUpperLeft:
            return "回転&縮小(左上)"
        case .translateAndScaleUpUpperLeft:
            return "移動&拡大(左上)"
        case .translateAndScaleDownUpperLeft:
            return "移動&縮小(左上)"
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet private weak var animationView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let flowlayout = UICollectionViewFlowLayout()
        let space: CGFloat = 16
        let itemWidth: CGFloat = (collectionView.frame.width - space) / 2
        let itemHeight: CGFloat = 40
        flowlayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowlayout.minimumLineSpacing = space
        flowlayout.minimumInteritemSpacing = space
        collectionView.collectionViewLayout = flowlayout
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func rotation() {
        let angle = 180 * CGFloat.pi / 180
        let transform = CGAffineTransform(rotationAngle: angle)
        // anchorPointを変更しつつ、表示位置を変更させないための小技
        let tmpFrame = animationView.frame
        animationView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        animationView.layer.frame = tmpFrame
        UIView.animate(withDuration: 1.0, animations: {
            self.animationView.transform = transform
        }) { _ in
            self.identity()
        }
    }

    private func translate() {
        let transform = CGAffineTransform(translationX: 100, y: 100)
        let tmpFrame = animationView.frame
        animationView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        animationView.layer.frame = tmpFrame
        UIView.animate(withDuration: 1.0, animations: {
            self.animationView.transform = transform
        }) { _ in
            self.identity()
        }
    }

    private func scaleUp() {
        let transform = CGAffineTransform(scaleX: 2, y: 2)
        let tmpFrame = animationView.frame
        animationView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        animationView.layer.frame = tmpFrame
        UIView.animate(withDuration: 1.0, animations: {
            self.animationView.transform = transform
        }) { _ in
            self.identity()
        }
    }

    private func scaleDown() {
        let transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        let tmpFrame = animationView.frame
        animationView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        animationView.layer.frame = tmpFrame
        UIView.animate(withDuration: 1.0, animations: {
            self.animationView.transform = transform
        }) { _ in
            self.identity()
        }
    }

    private func shear() {
        let transform = CGAffineTransform(a: 1, b: 0, c: 1, d: 1, tx: 0, ty: 0)
        UIView.animate(withDuration: 1.0, animations: {
            self.animationView.transform = transform
        }) { _ in
            self.identity()
        }
    }

    private func rotationUpperLeft() {
        let angle = 180 * CGFloat.pi / 180
        let transform = CGAffineTransform(rotationAngle: angle)
        // anchorPointを変更しつつ、表示位置を変更させないための小技
        let tmpFrame = animationView.frame
        animationView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        animationView.layer.frame = tmpFrame
        UIView.animate(withDuration: 1.0, animations: {
            self.animationView.transform = transform
        }) { _ in
            self.identity()
        }
    }

    private func translateUpperLeft() {
        let transform = CGAffineTransform(translationX: 100, y: 100)
        let tmpFrame = animationView.frame
        animationView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        animationView.layer.frame = tmpFrame
        UIView.animate(withDuration: 1.0, animations: {
            self.animationView.transform = transform
        }) { _ in
            self.identity()
        }
    }

    private func scaleUpUpperLeft() {
        let transform = CGAffineTransform(scaleX: 2, y: 2)
        let tmpFrame = animationView.frame
        animationView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        animationView.layer.frame = tmpFrame
        UIView.animate(withDuration: 1.0, animations: {
            self.animationView.transform = transform
        }) { _ in
            self.identity()
        }
    }

    private func scaleDownUpperLeft() {
        let transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        let tmpFrame = animationView.frame
        animationView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        animationView.layer.frame = tmpFrame
        UIView.animate(withDuration: 1.0, animations: {
            self.animationView.transform = transform
        }) { _ in
            self.identity()
        }
    }

    private func shearUpperLeft() {
        let transform = CGAffineTransform(a: 1, b: 0, c: 1, d: 1, tx: 0, ty: 0)
        let tmpFrame = animationView.frame
        animationView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        animationView.layer.frame = tmpFrame
        UIView.animate(withDuration: 1.0, animations: {
            self.animationView.transform = transform
        }) { _ in
            self.identity()
        }
    }

    private func rotationAndTranslateUpperLeft() {
        let tmpFrame = animationView.frame
        let angle = 180 * CGFloat.pi / 180
        let transform = CGAffineTransform(translationX: 100, y: 100)
        let transform2 = CGAffineTransform(rotationAngle: angle)
        animationView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        animationView.layer.frame = tmpFrame
        UIView.animate(withDuration: 1.0, animations: {
            ///https://stackoverflow.com/questions/41700894/concatenating-transform-animations-in-swift-3-what-is-wrong
            // 組み合わせる時はtransformをセットするタイミングで連結しないとうまくいかない
            self.animationView.transform = transform.concatenating(transform2)
        }) { _ in
            self.identity()
        }
    }

    private func rotationAndScaleUpUpperLeft() {
        let tmpFrame = animationView.frame
        let angle = 180 * CGFloat.pi / 180
        let transform = CGAffineTransform(scaleX: 2, y: 2)
        let transform2 = CGAffineTransform(rotationAngle: angle)
        animationView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        animationView.layer.frame = tmpFrame
        UIView.animate(withDuration: 1.0, animations: {
            ///https://stackoverflow.com/questions/41700894/concatenating-transform-animations-in-swift-3-what-is-wrong
            // 組み合わせる時はtransformをセットするタイミングで連結しないとうまくいかない
            self.animationView.transform = transform.concatenating(transform2)
        }) { _ in
            self.identity()
        }
    }

    private func rotationAndScaleDownUpperLeft() {
        let tmpFrame = animationView.frame
        let angle = 180 * CGFloat.pi / 180
        let transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        let transform2 = CGAffineTransform(rotationAngle: angle)
        animationView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        animationView.layer.frame = tmpFrame
        UIView.animate(withDuration: 1.0, animations: {
            ///https://stackoverflow.com/questions/41700894/concatenating-transform-animations-in-swift-3-what-is-wrong
            // 組み合わせる時はtransformをセットするタイミングで連結しないとうまくいかない
            self.animationView.transform = transform.concatenating(transform2)
        }) { _ in
            self.identity()
        }
    }

    private func translateAndScaleUpUpperLeft() {
        let tmpFrame = animationView.frame
        let transform = CGAffineTransform(scaleX: 2, y: 2)
        let transform2 = CGAffineTransform(translationX: 100, y: 100)
        animationView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        animationView.layer.frame = tmpFrame
        UIView.animate(withDuration: 1.0, animations: {
            ///https://stackoverflow.com/questions/41700894/concatenating-transform-animations-in-swift-3-what-is-wrong
            // 組み合わせる時はtransformをセットするタイミングで連結しないとうまくいかない
            self.animationView.transform = transform.concatenating(transform2)
        }) { _ in
            self.identity()
        }
    }

    private func translateAndScaleDownUpperLeft() {
        let tmpFrame = animationView.frame
        let transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        let transform2 = CGAffineTransform(translationX: 100, y: 100)
        animationView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        animationView.layer.frame = tmpFrame
        UIView.animate(withDuration: 1.0, animations: {
            ///https://stackoverflow.com/questions/41700894/concatenating-transform-animations-in-swift-3-what-is-wrong
            // 組み合わせる時はtransformをセットするタイミングで連結しないとうまくいかない
            self.animationView.transform = transform.concatenating(transform2)
        }) { _ in
            self.identity()
        }
    }

    private func identity() {
        UIView.animate(withDuration: 1.0) {
            self.animationView.transform = .identity
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EventType.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let event = EventType.allCases[indexPath.row]
        cell.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.15)
        cell.set(text: event.title)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event = EventType.allCases[indexPath.row]
        switch event {
        case .rotation:
            rotation()
        case .translate:
            translate()
        case .scaleUp:
            scaleUp()
        case .scaleDown:
            scaleDown()
        case .shear:
            shear()
        case .rotationUpperLeft:
            rotationUpperLeft()
        case .translateUpperLeft:
            translateUpperLeft()
        case .scaleUpUpperLeft:
            scaleUpUpperLeft()
        case .scaleDownUpperLeft:
            scaleDownUpperLeft()
        case .shearUpperLeft:
            shearUpperLeft()
        case .rotationAndTranslateUpperLeft:
            rotationAndTranslateUpperLeft()
        case .rotationAndScaleUpUpperLeft:
            rotationAndScaleUpUpperLeft()
        case .rotationAndScaleDownUpperLeft:
            rotationAndScaleDownUpperLeft()
        case .translateAndScaleUpUpperLeft:
            translateAndScaleUpUpperLeft()
        case .translateAndScaleDownUpperLeft:
            translateAndScaleDownUpperLeft()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        cell.highlight(true)
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        cell.highlight(false)
    }
}

class CollectionViewCell: UICollectionViewCell {
    private lazy var label = UILabel()

    func set(text: String) {
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        label.textColor = .black
        label.text = text
        label.textAlignment = .center
    }
}

extension UICollectionViewCell {
    func highlight(_ flag: Bool) {
        UIView.animate(withDuration: 0.15) {
            self.alpha = flag ? 0.6 : 1.0
            let scale: CGFloat = flag ? 0.925 : 1.0
            self.transform = CGAffineTransform.init(scaleX: scale, y: scale)
        }
    }
}
