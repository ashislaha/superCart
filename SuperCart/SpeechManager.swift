//
//  SpeechManager.swift
//  SuperCart
//
//  Created by Ashis Laha on 3/23/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import Foundation
import Speech

protocol SpeechManagerDelegate {
    func didReceiveText(text:String)
    func didStartedListening(status:Bool)
}

class SpeechManager {
    lazy var speechSynthesizer = AVSpeechSynthesizer()
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    var request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    let audioSession = AVAudioSession.sharedInstance()
    var delegate:SpeechManagerDelegate?
    
    static let shared:SpeechManager = {
        let instance = SpeechManager()
        return instance
    }()
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
//        do {
//            try audioSession.setCategory(AVAudioSessionCategoryRecord)
//            try audioSession.setMode(AVAudioSessionModeMeasurement)
//            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
//        } catch {
//            print("audioSession properties weren't set because of an error.")
//        }
        
        request = SFSpeechAudioBufferRecognitionRequest()
        let inputNode = audioEngine.inputNode
        let recognitionRequest = request
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            var isFinal = false
            if let result = result {
                let text = result.bestTranscription.formattedString
                self.delegate?.didReceiveText(text: text)
                isFinal = result.isFinal
            }
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.request.append(buffer)
        }
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        delegate?.didStartedListening(status: true)
    }
    
    func stopRecording() {
        if audioEngine.isRunning {
            audioEngine.stop()
            request.endAudio()
            audioEngine.inputNode.removeTap(onBus: 0)
        }
    }
    
    func speak(text: String) {
//        do {
//            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
//            try audioSession.setMode(AVAudioSessionModeMeasurement)
//            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
//        } catch {
//            print("audioSession properties weren't set because of an error.")
//        }
//        let speechUtterance = AVSpeechUtterance(string: text)
//        speechSynthesizer.speak(speechUtterance)
    }
}

