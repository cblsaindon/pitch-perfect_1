//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Candace Saindon on 3/10/15.
//  Copyright (c) 2015 Candace Saindon. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundsViewController: UIViewController {
  

    var audioPlayer:AVAudioPlayer!
    var questionAudioPlayer:AVAudioPlayer!
    var fireAudioPlayer:AVAudioPlayer!
    var moonAudioPlayer:AVAudioPlayer!
    var soundAvg:Float!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    var receivedAudio:RecordedAudio!
    var questionFilePathUrl:NSURL!
    var fireFilePathUrl:NSURL!
    var moonFilePathUrl:NSURL!
    
    
    @IBOutlet weak var stopPlaying: UIButton!

    @IBOutlet weak var playFastAudio: UIButton!
    @IBOutlet weak var playSlowAudio: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if var questionFilePath = NSBundle.mainBundle().pathForResource("ComedyTime", ofType: "mp3"){
            questionFilePathUrl = NSURL.fileURLWithPath(questionFilePath)
            
        }else{
            println("the file path is empty")
        }
        
        if var fireFilePath = NSBundle.mainBundle().pathForResource("FireAura", ofType: "mp3"){
            fireFilePathUrl = NSURL.fileURLWithPath(fireFilePath)
            
        }else{
            println("the file path is empty")
        }
        
        if var moonFilePath = NSBundle.mainBundle().pathForResource("Heaven", ofType: "mp3"){
            moonFilePathUrl = NSURL.fileURLWithPath(moonFilePath)
            
        }else{
            println("the file path is empty")
        }        //Create multiple audio players so more than one background music can be played at once... bc why not ;)
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        questionAudioPlayer = AVAudioPlayer(contentsOfURL: questionFilePathUrl, error: nil)
        questionAudioPlayer.enableRate = true
        
        fireAudioPlayer = AVAudioPlayer(contentsOfURL: fireFilePathUrl, error: nil)
        fireAudioPlayer.enableRate = true
        
        moonAudioPlayer = AVAudioPlayer(contentsOfURL: moonFilePathUrl, error: nil)
        moonAudioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }


    override func viewWillAppear(animated: Bool) {
        //hide the stop button
        stopPlaying.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playCrazyAudio(sender: UIButton) {
        //Careful with this one......
        // Play background music while voice is going
        
        if questionAudioPlayer.playing == true {
            questionAudioPlayer.stop()
        }else{
            prepBackgroundMusic()
            questionAudioPlayer.volume = 0.5
            questionAudioPlayer.currentTime = 0.0
            questionAudioPlayer.play()
            
        }
    }
    
    @IBAction func playFireAudio(sender: UIButton) {
        //Play lively background audio
        if fireAudioPlayer.playing == true {
            fireAudioPlayer.stop()
        }else{
            prepBackgroundMusic()
            fireAudioPlayer.volume = 0.5
            fireAudioPlayer.currentTime = 0.0
            fireAudioPlayer.play()
        }
    }
    @IBAction func playQuietAudio(sender: UIButton) {
        //Play soft soothing background audio
        if moonAudioPlayer.playing == true {
            moonAudioPlayer.stop()
        }else{
            prepBackgroundMusic()
            moonAudioPlayer.volume = 0.5
            moonAudioPlayer.currentTime = 0.0
            moonAudioPlayer.play()
        }
    }
    @IBAction func playSlowAudio(sender: UIButton) {
        // play audio slowly...
        audioPlayer.rate = 0.5
        commencePlayback()
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        // play audio fast!!!
        audioPlayer.rate = 2.0
        commencePlayback()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        // Play Chipmunk style audio
        playAudioWithVariablePitch(1000)
        stopPlaying.hidden = false
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        // Play Darthvadar style audio... whhee oooooo, whheee oooo
        playAudioWithVariablePitch(-1000)
        stopPlaying.hidden = false
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
        
    }

    @IBAction func stopPlaying(sender: UIButton) {
        // stop playing audio
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        stopPlaying.hidden = true
    }
    
    func prepBackgroundMusic() {
        questionAudioPlayer.stop()
        moonAudioPlayer.stop()
        fireAudioPlayer.stop()
    }

    func commencePlayback() {
        // Prepare audio playback with common steps
        audioPlayer.stop()
        stopPlaying.hidden = false
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
