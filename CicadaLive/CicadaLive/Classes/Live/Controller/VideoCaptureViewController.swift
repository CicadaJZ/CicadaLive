//
//  VideoCaptureViewController.swift
//  CicadaLive
//
//  Created by 知了 on 2023/4/15.
//

import UIKit
import AVFoundation

class VideoCaptureViewController: UIViewController {
    
    lazy var queue = DispatchQueue.global()
    
    lazy var session : AVCaptureSession = {
        //创建捕捉会话
        let session : AVCaptureSession = AVCaptureSession()
        //设置输入源
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return session}
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else { return session }
        session.addInput(videoInput)

        //设置输出源
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: queue)
        session.addOutput(videoOutput)
        
//        session.sessionPreset = .cif352x288
        return session
    }()
    
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
        
//        guard !self.session.isRunning else { return }
        
        print("开始采集")
        
        
        //预览图层
        view.layer.insertSublayer(previewLayer, at: 0)
        
        //开始采集
        queue.async {
            self.session.startRunning()
        }
        
    }
    
    
    @IBAction func stopCapture(_ sender: Any) {
        print("停止采集")
        //停止采集
        queue.async {
            self.session.stopRunning()
        }
        previewLayer.removeFromSuperlayer()
    }
    
}

extension VideoCaptureViewController : AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        print("采集中...:\(Date().timeIntervalSince1970)")
    }
    
}
