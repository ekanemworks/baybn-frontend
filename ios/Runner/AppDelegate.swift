import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

// @objc func addNewPerson(){
//     let picker = UIImagePickerController()

//     let ac = UIAlertController(title: "Choose image", message: nil, preferredStyle: .actionSheet)

//     let camera = UIAlertAction(title: "Camera", style: .default){
//         [weak self] _ in
//         if UIImagePickerController.isSourceTypeAvailable(.camera) {
//             picker.allowsEditing = false
//             picker.delegate = self
//             picker.sourceType = .camera
//             self?.present(picker,animated: true)
//         }else{
//             let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
//             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//             self?.present(alert, animated: true, completion: nil)
//         }
//     }
//     ac.addAction(camera)

//     let galerie = UIAlertAction(title: "Photo library", style: .default){
//         [weak self] _ in
//             picker.allowsEditing = true
//             picker.delegate = self
//         self?.present(picker,animated: true)
//     }
//     ac.addAction(galerie)

//     ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

//     present(ac,animated: true)   
// }
