//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 小吹　創大 on 2024/08/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var StartStopButton: UIButton!
    
    var imageNames = ["photo01.jpg", "photo02.jpg", "photo03.jpg"]
    var currentIndex = 0
    var timer: Timer?
    var isPlaying = false
    
    @IBAction func Next(_ sender: Any) {
        currentIndex = (currentIndex + 1) % imageNames.count
        ImageView.image = UIImage(named:imageNames[currentIndex])
    }
    
    @IBAction func Back(_ sender: Any) {
        currentIndex = (currentIndex - 1 + imageNames.count) % imageNames.count
        ImageView.image = UIImage(named:imageNames[currentIndex])
    }
    
    @IBAction func startstop(_ sender: Any) {
        if isPlaying {
            stopSlideshow()
        } else {
            startSlideshow()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageView.image = UIImage(named: imageNames[currentIndex])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        ImageView.addGestureRecognizer(tapGesture)
        ImageView.isUserInteractionEnabled = true
    }
    
    func startSlideshow() {
        isPlaying = true
        StartStopButton.setTitle("停止", for: .normal)
        NextButton.isEnabled = false
        BackButton.isEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(showNextImage), userInfo: nil, repeats: true)
    }
    
    func stopSlideshow() {
        isPlaying = false
        StartStopButton.setTitle("再生", for: .normal)
        NextButton.isEnabled = true
        BackButton.isEnabled = true
        timer?.invalidate()
        timer = nil
    }
    
    @objc func showNextImage() {
        Next(self)
    }
    
    @objc func imageTapped() {
        performSegue(withIdentifier: "showDetailSegue", sender: self)
        if isPlaying {
            stopSlideshow()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSegue" {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.imageName = imageNames[currentIndex]
        }
    }


}

