//
//  BasicInformationViewController.swift
//  BreakingBad
//
//  Created by stefan on 30.03.2025.
//

import UIKit
import Photos
import PhotosUI

class UploadViewController: UIViewController, PHPickerViewControllerDelegate {

    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var aliasLabel: UITextField!
    @IBOutlet weak var roleLabel: UITextField!
    @IBOutlet weak var actorLabel: UITextField!
    @IBOutlet weak var quoteLabel: UITextField!
    @IBOutlet weak var urlLabel: UITextField!
    @IBOutlet weak var imageName: UILabel!

    var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImage(named: "bb_background.jpeg")
        let imageViewbg = UIImageView(image: backgroundImage)
        imageViewbg.frame = self.view.bounds
        imageViewbg.contentMode = .scaleAspectFill
        self.view.addSubview(imageViewbg)
        self.view.sendSubviewToBack(imageViewbg)
    }
    
    @IBAction func uploadButton(_ sender: UIButton) {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else {
            print("❌ Imposibil de încărcat imaginea")
            return
        }

        provider.loadObject(ofClass: UIImage.self) { (image, error) in
            DispatchQueue.main.async {
                guard let selectedImage = image as? UIImage else {
                    print("❌ Eroare la conversia imaginii")
                    return
                }
                
                if let savedPath = self.saveImageToDocuments(image: selectedImage) {
                    self.imageName.text = savedPath.lastPathComponent
                    self.selectedImage = selectedImage
                } else {
                    print("❌ Eroare la salvarea imaginii")
                }
            }
        }
    }


    func saveImageToDocuments(image: UIImage) -> URL? {
        let fileManager = FileManager.default
        let docDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imagePath = docDir.appendingPathComponent("selected_image.jpg")

        if let imageData = image.jpegData(compressionQuality: 0.8) {
            do {
                try imageData.write(to: imagePath)
                print("✔️ Imagine salvată la: \(imagePath)")
                return imagePath
            } catch {
                print("❌ Eroare la salvarea imaginii: \(error)")
            }
        }
        return nil
    }



    @IBAction func confirmButton(_ sender: UIButton) {
        guard let image = selectedImage else { return }
        
        PHPhotoLibrary.shared().performChanges {
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }
        
        appendToXML()
    }

    @IBAction func cancelButton(_ sender: UIButton) {
        imageName.text = ""
        selectedImage = nil
    }
    
    func appendToXML() {
        guard let name = nameLabel.text, !name.isEmpty,
              let alias = aliasLabel.text, !alias.isEmpty,
              let role = roleLabel.text, !role.isEmpty,
              let actor = actorLabel.text, !actor.isEmpty,
              let quote = quoteLabel.text, !quote.isEmpty,
              let url = urlLabel.text, !url.isEmpty,
              let image = imageName.text, !image.isEmpty else { return }

        let xmlFileName = "characters_list.xml"
        let fileManager = FileManager.default
        let docDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let xmlFilePath = docDir.appendingPathComponent(xmlFileName)

        var xmlString = ""

        if fileManager.fileExists(atPath: xmlFilePath.path) {
            if let existingXML = try? String(contentsOf: xmlFilePath) {
                xmlString = existingXML.replacingOccurrences(of: "</characters>", with: "")
            }
        } else {
            xmlString = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<characters>\n"
        }

        let newCharacter = """
        <character>
            <name>\(name)</name>
            <alias>\(alias)</alias>
            <role>\(role)</role>
            <actor>\(actor)</actor>
            <quote>\(quote)</quote>
            <image>\(image)</image>
            <url>\(url)</url>
        </character>\n</characters>
        """

        xmlString += newCharacter

        try? xmlString.write(to: xmlFilePath, atomically: true, encoding: .utf8)
    }
}
