//
//  HomeViewController.swift
//  RecipeApp
//
//  Created by Anuar Nordin on 01/03/2021.
//

import UIKit
import SVProgressHUD
import SDWebImage

struct Recipe {
    var recipeName: String
    var recipePictureURL: String
    var recipeIngredients: String
    var recipeSteps: String
}

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    
    var elementName: String = String()
    var recipeName = String()
    var recipePictureURL = String()
    var recipeIngredients = String()
    var recipeSteps = String()

    var fullStack = [String : UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        toolBar()
        readXML()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchTextField.text = ""
        fullStack = Dictionary(zip(Global.recipeNameArray, Global.recipePictureUIImageArray), uniquingKeysWith: { (first, _) in first })
        tableView.reloadData()
    }
    
    @IBAction func addBtnPressed(_ sender: UIButton) {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeDetailsViewController") as! HomeDetailsViewController
        nextVC.checkBool = false
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func callDeleteCell(_ notification: Notification){
        if let passDeleteTag = notification.userInfo?["passInt"] as? Int {
            displayAlertMessage(messageToDisplay: "Confirm to delete recipe?", passDeleteTag: passDeleteTag)
        }
    }
    
    func setupView(){
        NotificationCenter.default.addObserver(self, selector: #selector(callDeleteCell), name: Notification.Name("deleteCell"), object: nil)
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(HomeViewController.textFieldDidChange(_:)), for: .editingChanged)
        addBtn.rounded(radius: 30)
    }
    
    func readXML(){
        if let path = Bundle.main.url(forResource: "recipetypes", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
                
            }else{
                print("parserElse")
            }
        }else{
            print("readXMLElse")
        }
        
        fullStack = Dictionary(zip(Global.recipeNameArray, Global.recipePictureUIImageArray), uniquingKeysWith: { (first, _) in first })
        print("fullStack", fullStack)
    }
    
    func displayAlertMessage(messageToDisplay: String, passDeleteTag: Int) {
        SVProgressHUD.dismiss()
        let alertController = UIAlertController(title: "Info", message: messageToDisplay, preferredStyle: .alert)
        alertController.view.tintColor = UIColor(red: 22/255, green: 16/255, blue: 21/255, alpha: 1.0)
        
        let OKAction = UIAlertAction(title: "OK", style: .destructive) { (action:UIAlertAction!) in
            print("OK")
            Global.recipeNameArray.remove(at: passDeleteTag)
            Global.recipeNameArrayTemp.remove(at: passDeleteTag)
            Global.recipePictureUIImageArray.remove(at: passDeleteTag)
            Global.recipePictureUIImageArrayTemp.remove(at: passDeleteTag)
            Global.recipeIngredientsArray.remove(at: passDeleteTag)
            Global.recipeStepsArray.remove(at: passDeleteTag)
            
            self.fullStack = Dictionary(zip(Global.recipeNameArray, Global.recipePictureUIImageArray), uniquingKeysWith: { (first, _) in first })
            
            self.tableView.reloadData()
        }
        
        let Cancel = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction!) in
            print("Cancel")
        }
        
        alertController.addAction(OKAction)
        alertController.addAction(Cancel)
        self.present(alertController, animated: true, completion:nil)
    }
}

extension HomeViewController: XMLParserDelegate{
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        if elementName == "Menu" {
            recipeName = String()
            recipePictureURL = String()
            recipeIngredients = String()
            recipeSteps = String()
        }

        self.elementName = elementName
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        tableView.reloadData()
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if (!data.isEmpty) {
            if self.elementName == "Name" {
                Global.recipeNameArrayTemp.append(data)
                Global.recipeNameArray.append(data)
            } else if self.elementName == "PictureURL" {
                let imageUrlString = data
                let imageUrl = URL(string: imageUrlString)!
                let imageData = try! Data(contentsOf: imageUrl)
                let image = UIImage(data: imageData)
                Global.recipePictureUIImageArray.append(image ?? UIImage())
                Global.recipePictureUIImageArrayTemp.append(image ?? UIImage())
            }else if self.elementName == "Ingredients" {
                Global.recipeIngredientsArray.append(data)
            }else if self.elementName == "Steps" {
                Global.recipeStepsArray.append(data)
            }
        }
    }
    
    func toolBar(){
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 44.0))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        
        toolbar.setItems([spaceButton,spaceButton,doneButton], animated: false)

        searchTextField.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell

        cell.cellName.text = Global.recipeNameArray[indexPath.row]
        if Global.recipePictureUIImageArray.count == Global.recipeNameArray.count{
            cell.cellImages.image = Global.recipePictureUIImageArray[indexPath.row]
        }

        cell.cellDeleteBtn.tag = indexPath.row
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Global.recipeNameArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeDetailsViewController") as! HomeDetailsViewController
        nextVC.checkBool = true
        nextVC.indexNumber = indexPath.row
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension HomeViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        Global.recipeNameArray.removeAll()
        Global.recipePictureUIImageArray.removeAll()
        
        if textField.text!.count == 0{
            Global.recipeNameArray = Global.recipeNameArrayTemp
            Global.recipePictureUIImageArray = Global.recipePictureUIImageArrayTemp
            tableView.reloadData()
        }else{
            fullStack.forEach { (item) in
                if item.key.localizedCaseInsensitiveContains(textField.text!){
                    Global.recipeNameArray.append(item.key)
                    Global.recipePictureUIImageArray.append(item.value)
                    tableView.reloadData()
                }
            }
        }
    }
}
