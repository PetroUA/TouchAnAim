//
//  GameViewController.swift
//  TouchAnAim
//
//  Created by Petro on 18.10.2021.
//

import UIKit

class GameViewController: UIViewController {
    
    let numberOfRows = 7
    let numberOfColumns = 7
    let winerURL = URL(string: "https://www.google.com.ua/")
    let louserURL = URL(string: "https://www.youtube.com/")
    let aims = Aims()
    let defaults = UserDefaults.standard
    
    var timer: Timer?
    var timeLeft = 7
    var aimsLocationArray: [UIButton] = []
    
    @IBOutlet weak var timerlLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aims.delegate = self
        
        for _ in 0 ..< numberOfRows {
            var rowButtons: [UIButton] = []
            
            for _ in 0 ..< numberOfColumns {
                let button = UIButton()
                button.backgroundColor = .white
                button.setTitle("", for: .normal)
                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                rowButtons.append(button)
                view.addSubview(button)
                aimsLocationArray.append(button)
            }
            
            let rowStackView = UIStackView(arrangedSubviews: rowButtons)
            rowStackView.axis = .horizontal
            rowStackView.alignment = .fill
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = 16
            stackView.addArrangedSubview(rowStackView)
        }
        
        aimsLocationArray = aims.getRamdomAim(aims: aimsLocationArray)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
        if UserDefaults.standard.object(forKey: "FirstPlay") == nil {
            let alert = UIAlertController(title: "The Rule", message: "Kill all spiders faster than 7 seconds", preferredStyle: .alert)
            self.timer?.invalidate()
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] action in
                                            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
                defaults.set(false, forKey: "FirstPlay")
            }))

            self.present(alert, animated: true)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonTaped(_ sender: Any) {
        timer?.invalidate()
        timer = nil
        timerlLabel.text = ""
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func onTimerFires()
    {
        timeLeft -= 1
        if timeLeft <= 0 {
            timer?.invalidate()
            timerlLabel.text = ""
            timer = nil
            showWebSite(winer: false)
            for index in 0 ..< aimsLocationArray.count {
                aimsLocationArray[index].setImage(nil, for: .normal)
            }
        }
        timerlLabel.text = "\(timeLeft) seconds left"

    }
    
    @objc func buttonAction(sender: UIButton!) {
        if sender.currentImage != nil {
            sender.setImage(nil, for: .normal)
        }
        aimsLocationArray = aims.getRamdomAim(aims: aimsLocationArray)
    }
    
    func showWebSite (winer: Bool) {
        var url = louserURL
        if winer {
            url = winerURL
        }
        let customViewController = CustomViewController.init()
        customViewController.URL = url
        self.navigationController?.pushViewController(customViewController, animated: true)
    }
    
}

extension GameViewController: AimsDelegate{
    func aimsDelegate() {
        timer?.invalidate()
        timer = nil
        timerlLabel.text = ""
        showWebSite(winer: true)
    }
}
