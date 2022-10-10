//
//  ViewController.swift
//  scroll
//
//  Created by Livia Carvalho Keller on 10/10/22.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var widthConstaint: NSLayoutConstraint!
    
    let numOfPages = 4
    var width: CGFloat!
    
    var pinkView: UIView!
    var purpleView: UIView!
    var blueView: UIView!
    var blackView: UIView!
    
    var animating = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        width = scrollView.bounds.width
        widthConstaint.constant = width * CGFloat(numOfPages)
        
        // pagina atual
        pageControl.currentPage = 0
        pageControl.numberOfPages = numOfPages
        
        colorsPages()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colors()
        scrollView.delegate = self
        pageControl.addTarget(self, action: #selector(paged), for: UIControl.Event.valueChanged)
    }
    
    @objc func paged (sender: UIPageControl) -> Void {
        
        animating = true
        let nextPage = sender.currentPage
        let newFrame = CGRect(origin: CGPoint(x: CGFloat(nextPage) * width, y: 0.0), size: CGSize(width: width, height: width))
        
        scrollView.scrollRectToVisible(newFrame, animated: true)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        animating = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (!animating) {
            let xOrig = scrollView.contentOffset.x
            let nextPage: Int = Int(round(xOrig / width))
            pageControl.currentPage = nextPage
        }
    }
}

//MARK: - Colors

extension ViewController {
    
    func colorsPages() {
        
        pinkView.frame = CGRect(origin: CGPoint(x: width * 1, y: 0.0), size: CGSize(width: width, height: width))
        purpleView.frame = CGRect(origin: CGPoint(x: width * 2, y: 0.0), size: CGSize(width: width, height: width))
        blueView.frame = CGRect(origin: CGPoint(x: width * 0, y: 0.0), size: CGSize(width: width, height: width))
        blackView.frame = CGRect(origin: CGPoint(x: width * 3, y: 0.0), size: CGSize(width: width, height: width))
    }
    
    func colors() {
        
        pinkView = UIView(frame: CGRect.zero)
        pinkView.backgroundColor = UIColor.systemPink
        viewContent.addSubview(pinkView)
        
        blackView = UIView(frame: CGRect.zero)
        blackView.backgroundColor = UIColor.black
        viewContent.addSubview(blackView)
        
        purpleView = UIView(frame: CGRect.zero)
        purpleView.backgroundColor = UIColor.purple
        viewContent.addSubview(purpleView)
        
        blueView = UIView(frame: CGRect.zero)
        blueView.backgroundColor = UIColor.cyan
        viewContent.addSubview(blueView)
    }
}
