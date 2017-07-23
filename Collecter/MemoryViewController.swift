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
    var memory : Memory? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        
        if memory != nil {
            print("We have a memory")
            
            ImageView.image = UIImage(data: memory!.image as! Data)
            TitleTextField.text = memory!.title
            
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            DeleteButton.isHidden = true
        }
    }

    @IBOutlet weak var DeleteButton: UIButton!
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var TitleTextField: UITextField!
    
    @IBAction func AddButton(_ sender: Any) {
        if memory != nil {
            
            
            memory!.title = TitleTextField.text
            memory!.image = UIImagePNGRepresentation(ImageView.image!) as! NSData

            
        } else {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let memory = Memory(context: context)
        memory.title = TitleTextField.text
        memory.image = UIImagePNGRepresentation(ImageView.image!) as! NSData
       
        }
        
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
        
        
    }
    @IBAction func DeleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(memory!)
        
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
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
        
    }

}
