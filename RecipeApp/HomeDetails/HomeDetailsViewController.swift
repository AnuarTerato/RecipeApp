//
//  HomeDetailsViewController.swift
//  RecipeApp
//
//  Created by Anuar Nordin on 02/03/2021.
//

import UIKit
import SDWebImage

class HomeDetailsViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var stepsTextField: UITextField!
    @IBOutlet weak var backgroundBtnView: UIView!
    
    var indexNumber = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundBtnView.backgroundColor = .black
        backgroundBtnView.rounded(radius: 30)

        titleLbl.text = Global.recipeNameArray[indexNumber]
        nameTextField.text = Global.recipeNameArray[indexNumber]
        menuImageView.sd_setImage(with: URL(string: Global.recipePictureURLArray[indexNumber]), placeholderImage: nil)
        ingredientsTextField.text = Global.recipeIngredientsArray[indexNumber]
        stepsTextField.text = Global.recipeStepsArray[indexNumber]
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        Global.recipeNameArray[indexNumber] = nameTextField.text!
        Global.recipeNameArrayTemp[indexNumber] = nameTextField.text!
        Global.recipeIngredientsArray[indexNumber] = ingredientsTextField.text!
        Global.recipeStepsArray[indexNumber] = stepsTextField.text!
        
        navigationController?.popViewController(animated: true)
    }
}
