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
    @IBOutlet var uiViewLayout: UIView!
    var selectedImage: UIImage?
    var savedImagePath: URL?

    @IBOutlet weak var nameLabelDesc: UILabel!
    @IBOutlet weak var aliasLabelDesc: UILabel!
    @IBOutlet weak var roleLabelDesc: UILabel!
    @IBOutlet weak var actorLabelDesc: UILabel!
    @IBOutlet weak var quoteLabelDesc: UILabel!
    @IBOutlet weak var imageLabelDesc: UILabel!
    
    @IBOutlet weak var urlLabelDesc: UILabel!
    @IBOutlet weak var cancelButtonStyle: UIButton!
    @IBOutlet weak var confirmButtonStyle: UIButton!
    @IBOutlet weak var uploadImageStyle: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
        styleUIViewLayout(uiView: self.uiViewLayout)
        styleDescrLabel(label: self.nameLabelDesc)
        styleDescrLabel(label: self.aliasLabelDesc)
        styleDescrLabel(label: self.roleLabelDesc)
        styleDescrLabel(label: self.actorLabelDesc)
        styleDescrLabel(label: self.quoteLabelDesc)
        styleDescrLabel(label: self.urlLabelDesc)
        styleDescrLabel(label: self.imageLabelDesc)
        styleDescrLabel(label: self.imageName)
        styleBreakingBadButton(button: cancelButtonStyle)
        styleBreakingBadButton(button: confirmButtonStyle)
        applyUploadButtonStyle(button: uploadImageStyle)
        applyBreakingBadStyle(textField: self.nameLabel)
        applyBreakingBadStyle(textField: self.aliasLabel)
        applyBreakingBadStyle(textField: self.roleLabel)
        applyBreakingBadStyle(textField: self.actorLabel)
        applyBreakingBadStyle(textField: self.quoteLabel)
        applyBreakingBadStyle(textField: self.urlLabel)
    }

    private func setupBackgroundImage() {
        guard let backgroundImage = UIImage(named: "bb_background.jpeg") else { return }
        let imageViewbg = UIImageView(image: backgroundImage)
        imageViewbg.frame = self.view.bounds
        imageViewbg.contentMode = .scaleAspectFill
        self.view.addSubview(imageViewbg)
        self.view.sendSubviewToBack(imageViewbg)
    }

    @IBAction func confirmButton(_ sender: UIButton) {
        saveCharacter()
        clearFields()
    }

    @IBAction func cancelButton(_ sender: UIButton) {
        clearFields()
    }

    @IBAction func uploadButton(_ sender: UIButton) {
        let picker = createImagePicker()
        present(picker, animated: true)
    }

    private func createImagePicker() -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        return picker
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        guard let result = results.first else { return }

        result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
            if let selectedImage = image as? UIImage {
                DispatchQueue.main.async {
                    self?.selectedImage = selectedImage
                    self?.saveImageToDocuments(image: selectedImage)
                    self?.imageName.text = self?.savedImagePath?.lastPathComponent ?? "Unknown"
                }
            }
        }
    }

    func saveImageToDocuments(image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 1.0) else { return }
        
        let fileName = "image_\(UUID().uuidString).jpeg"
        
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let imageURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            try data.write(to: imageURL)
            savedImagePath = imageURL
        } catch {
        }
    }

    func saveCharacter() {
        guard let name = nameLabel.text, !name.isEmpty,
              let alias = aliasLabel.text, !alias.isEmpty,
              let role = roleLabel.text, !role.isEmpty,
              let actor = actorLabel.text, !actor.isEmpty,
              let quote = quoteLabel.text, !quote.isEmpty,
              let url = urlLabel.text, !url.isEmpty else {
            return
        }

        let imageFileName = savedImagePath?.lastPathComponent ?? "default_image.jpeg"
        
        let newCharacterXML = """
            <character>
                <name>\(name)</name>
                <alias>\(alias)</alias>
                <role>\(role)</role>
                <actor>\(actor)</actor>
                <quote>\(quote)</quote>
                <image>\(imageFileName)</image>
                <url>\(url)</url>
            </character>
        """

        saveCharacterToXML(newCharacterXML)
    }

    func saveCharacterToXML(_ characterXML: String) {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let xmlFile = documentsDirectory.appendingPathComponent("characters_list.xml")
        
        if !fileManager.fileExists(atPath: xmlFile.path) {
            let initialContent = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<characters>\n\(characterXML)\n</characters>"
            try? initialContent.write(to: xmlFile, atomically: true, encoding: .utf8)
        } else {
            if var content = try? String(contentsOf: xmlFile) {
                if let range = content.range(of: "</characters>") {
                    content.insert(contentsOf: "\(characterXML)\n", at: range.lowerBound)
                    try? content.write(to: xmlFile, atomically: true, encoding: .utf8)
                }
            }
        }
    }


    func clearFields() {
        nameLabel.text = ""
        aliasLabel.text = ""
        roleLabel.text = ""
        actorLabel.text = ""
        quoteLabel.text = ""
        urlLabel.text = ""
        imageName.text = ""
        selectedImage = nil
        savedImagePath = nil
    }

    func styleUIViewLayout(uiView: UIView) {
        uiView.backgroundColor = UIColor(white: 1.0, alpha: 0.6)
        uiView.layer.cornerRadius = 15
        uiView.layer.masksToBounds = true
        uiView.layer.shadowColor = UIColor.black.cgColor
        uiView.layer.shadowOffset = CGSize(width: 0, height: 2)
        uiView.layer.shadowOpacity = 0.7
        uiView.layer.shadowRadius = 4
    }

    func styleDescrLabel(label: UILabel) {
        label.font = UIFont(name: "Avenir-Heavy", size: 16)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.shadowOpacity = 0.7
        label.layer.shadowRadius = 4
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor(white: 0.4, alpha: 0.7)
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 1
        label.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    func styleBreakingBadButton(button: UIButton) {
        button.backgroundColor = UIColor(red: 30/255, green: 50/255, blue: 30/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 20)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.green.cgColor
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 4
        button.bounds.size = CGSize(width: 160, height: 60)
    }
    
    func applyBreakingBadStyle(textField: UITextField) {
        textField.textColor = UIColor.green
        textField.font = UIFont(name: "Roboto-Bold", size: 18)
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.green.cgColor
        textField.layer.cornerRadius = 8
        textField.backgroundColor = UIColor.black

        let padding: CGFloat = 10
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always

        textField.textAlignment = .left
        textField.clearButtonMode = .whileEditing
    }
    
    func applyUploadButtonStyle(button: UIButton) {
        button.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0)
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 18)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.green.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }

}
