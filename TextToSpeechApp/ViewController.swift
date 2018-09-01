//
//  ViewController.swift
//  TextToSpeechApp
//
//  Created by Sunil Targe on 8/28/18.
//  Copyright © 2018 Sunil Targe. All rights reserved.
//

import UIKit
import AVFoundation

let highlightedColor = UIColor.init(red: 0.46, green: 0.83, blue: 1.0, alpha: 1)

class ViewController: UIViewController, AVSpeechSynthesizerDelegate {

    @IBOutlet weak var lblText: UILabel!
    var synthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        synthesizer.delegate = self
        lblText.text = "Hey hello!\nHow to convert text to speech using AVSpeechSynthesizer.\n\niOS has text-to-speech synthesis built right into the system, but even better is that it allows you to track when individual words are being spoken so that you can highlight the words on the screen.\n\nWatch this video:)\n\nThank you!"
        lblText.sizeToFit()
        lblText.layer.cornerRadius = 15.0
        lblText.layer.borderWidth = 1.0
        lblText.layer.borderColor = UIColor.white.cgColor
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Callback methods
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        let mutableAttributedString = NSMutableAttributedString(string: utterance.speechString)
        mutableAttributedString.addAttribute(.foregroundColor, value: highlightedColor, range: characterRange)
        lblText.attributedText = mutableAttributedString
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        lblText.attributedText = NSAttributedString(string: utterance.speechString)
    }
    
    // Action
    @IBAction func speech(_ sender: AnyObject) {
        let string = lblText.text
        let utterance = AVSpeechUtterance(string: string!)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
    }
}

