//
//  VideoCaptureViewController.swift
//  CicadaLive
//
//  Created by 知了 on 2023/4/15.
//

import UIKit
import AVFoundation

class VideoCaptureViewController: UIViewController {
       
    var connection : AVCaptureConnection?
    var videoInput : AVCaptureDeviceInput?
    var videoOutput : AVCaptureVideoDataOutput?
    
    lazy var videoQueue = DispatchQueue.global()
    lazy var audioQueue = DispatchQueue.global()
    
    lazy var session : AVCaptureSession = AVCaptureSession()
    
    
    lazy var previewLayer : AVCaptureVideoPreviewLayer = {
        let previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
        previewLayer.frame = view.bounds
        return previewLayer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }


}

extension VideoCaptureViewController {

    @IBAction func startCapture(_ sender: Any) {
        
        guard !self.session.isRunning else { return }
        
        setupVideo()
        
        setupAudio()
        
        print("开始采集")
        
        
        //预览图层
        view.layer.insertSublayer(previewLayer, at: 0)
        
        //开始采集
        DispatchQueue.global().async {
            self.session.startRunning()
        }
        
    }
    
    
    @IBAction func stopCapture(_ sender: Any) {
        print("停止采集")
        //停止采集
        DispatchQueue.global().async {
            self.session.stopRunning()
        }
        previewLayer.removeFromSuperlayer()
    }
    
    @IBAction func switchScene(_ sender: Any) {
        let device = videoInput?.device
        let position = (device?.position == .front) ? AVCaptureDevice.Position.back : AVCaptureDevice.Position.front
        
        guard let newDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position) else { return }
        guard let videoInput = try? AVCaptureDeviceInput(device: newDevice) else { return }
        
        session.beginConfiguration()
        session.removeInput(self.videoInput!)
        session.addInput(videoInput)
        session.commitConfiguration()
        
        self.videoInput = videoInput
    }
    
}

extension VideoCaptureViewController {

    func setupVideo() {
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else { return }
        self.videoInput = videoInput
        session.addInput(self.videoInput!)

        //设置输出源
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        session.addOutput(videoOutput)
        
        self.videoOutput = videoOutput
    }
    
    func setupAudio() {
        guard let audioDevice = AVCaptureDevice.default(for: .audio) else { return }
        guard let audioInput = try? AVCaptureDeviceInput(device: audioDevice) else { return }
        session.addInput(audioInput)
        
        let audioOutput = AVCaptureAudioDataOutput()
        audioOutput.setSampleBufferDelegate(self, queue: audioQueue)
        session.addOutput(audioOutput)
    }
    
}


extension VideoCaptureViewController : AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        print("采集中...:\(Date().timeIntervalSince1970)")
        if connection == self.videoOutput?.connection(with: .video) {
            print("视频采集中")
        } else {
            print("音频采集中")
        }
    }
    
}
