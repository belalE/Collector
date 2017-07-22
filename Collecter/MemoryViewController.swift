//
//  MemoryViewController.swift
//  Collecter
//
//  Created by mac pro on 7/9/17.
//  Copyright © 2017 Elsiesy Industries. All rights reserved.
//

import UIKit

class MemoryViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        
    }

    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var TitleTextField: UITextField!
    
    @IBAction func AddButton(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let memory = Memory(context: context)
        memory.title = TitleTextField.text
        memory.image = UIImagePNGRepresentation(ImageView.image!) as! NSData
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
    @IBAction func PhotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        ImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    @IBAction func CameraTapped(_ sender: Any) {
    }

}
