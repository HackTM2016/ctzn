//
//  VoiceNotifications.swift
//  CTZN
//
//  Created by Dragos Victor Damian on 22/05/16.
//  Copyright © 2016 NestHackers. All rights reserved.
//

import UIKit
import AVFoundation

class VoiceNotifications: UIViewController {
    let speechSynthesizer = AVSpeechSynthesizer()
    
    // This is the action called when the user presses the button.
    @IBAction func speak(sender: AnyObject) {
        let string = "Salutare, prietene!"
        let utterance = AVSpeechUtterance(string: string)
        
        
        weak var speak: UIButton!
        utterance.voice = AVSpeechSynthesisVoice(language: "ro-RO")
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speakUtterance(utterance)
    }
    
    // Called before speaking an utterance
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didStartSpeechUtterance utterance: AVSpeechUtterance) {
        print("About to say '\(utterance.speechString)'");
    }
    
    // Called when the synthesizer is finished speaking the utterance
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didFinishSpeechUtterance utterance: AVSpeechUtterance) {
        print("Finished saying '\(utterance.speechString)");
    }
    
    // This method is called before speaking each word in the utterance.
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        let startIndex = utterance.speechString.startIndex.advancedBy(characterRange.location)
        let endIndex = startIndex.advancedBy(characterRange.length)
        print("Will speak the word '\(utterance.speechString.substringWithRange(startIndex..<endIndex))'");
    }
}