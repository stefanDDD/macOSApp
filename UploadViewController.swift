import UIKit
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
    var savedImagePath: String?

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
            return
        }

        provider.loadObject(ofClass: UIImage.self) { (image, error) in
            DispatchQueue.main.async {
                guard let selectedImage = image as? UIImage else { return }
                
                if let savedPath = self.saveImageToAssets(image: selectedImage) {
                    self.imageName.text = savedPath.lastPathComponent
                    self.selectedImage = selectedImage
                    self.savedImagePath = savedPath.path
                }
            }
        }
    }

    func saveImageToAssets(image: UIImage) -> URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let assetsFolder = documentsDirectory.appendingPathComponent("Assets")
        try? fileManager.createDirectory(at: assetsFolder, withIntermediateDirectories: true)
        
        let imageName = "image_\(UUID().uuidString).jpg"
        let imagePath = assetsFolder.appendingPathComponent(imageName)
        
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            try? imageData.write(to: imagePath)
            return imagePath
        }
        return nil
    }

    @IBAction func confirmButton(_ sender: UIButton) {
        appendToXML()
    }

    @IBAction func cancelButton(_ sender: UIButton) {
        imageName.text = ""
        selectedImage = nil
        savedImagePath = nil
    }

    func appendToXML() {
        guard let name = nameLabel.text, !name.isEmpty,
              let alias = aliasLabel.text, !alias.isEmpty,
              let role = roleLabel.text, !role.isEmpty,
              let actor = actorLabel.text, !actor.isEmpty,
              let quote = quoteLabel.text, !quote.isEmpty,
              let url = urlLabel.text, !url.isEmpty else {
            return
        }

        guard let filePath = Bundle.main.path(forResource: "characters_file", ofType: "xml") else {
            return
        }

        var xmlString = ""

        do {
            xmlString = try String(contentsOfFile: filePath, encoding: .utf8)
        } catch {
            return
        }

        let finalImagePath = savedImagePath ?? "DEFAULT_NAME"
        
        let newCharacter = """
        <character>
            <name>\(name)</name>
            <alias>\(alias)</alias>
            <role>\(role)</role>
            <actor>\(actor)</actor>
            <quote>\(quote)</quote>
            <image>\(finalImagePath)</image>
            <url>\(url)</url>
        </character>\n
        """
        
        xmlString.append(newCharacter)

        if !xmlString.hasSuffix("</characters>") {
            xmlString.append("</characters>")
        }

        do {
            try xmlString.write(toFile: filePath, atomically: true, encoding: .utf8)
            print("XML actualizat cu succes.")
        } catch {
            return
        }
    }
}
