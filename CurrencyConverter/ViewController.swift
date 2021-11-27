//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Nurşah on 27.11.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trylbl: UILabel!
    @IBOutlet weak var usdlbl: UILabel!
    @IBOutlet weak var jpylbl: UILabel!
    @IBOutlet weak var gbplbl: UILabel!
    @IBOutlet weak var chflbl: UILabel!
    @IBOutlet weak var cadlbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getRates(_ sender: Any) {
        //1- request & session
        //2- Response & Data
        //3- Parsing & JSON serialization
        
        // 1.
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=f2ee8357b12e025ddc842175fea42f8c")
        let session = URLSession.shared
        //Closure
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            else {
                //2.
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        //async
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String: Any] {
                                if let cad = rates["CAD"] as? Double {
                                    
                                    self.cadlbl.text = "CAD: " + String(format: "%.2f", cad)
                                }
                                                                
                                if let chf = rates["CHF"] as? Double {
                                   // print(chf)
                                    self.chflbl.text = "CHF: " + String(format: "%.2f", chf)
                                }
                                
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbplbl.text = "GBP: " + String(format: "%.2f", gbp)
                                }
                                
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpylbl.text = "JPY: " + String(format: "%.2f", jpy)
                                }
                                
                                if let usd = rates["USD"] as? Double {
                                    self.usdlbl.text = "USD: " + String(format: "%.2f", usd)
                                }
                                
                                if let turkish = rates["TRY"] as? Double {
                                    self.trylbl.text = "TRY: " + String(format: "%.2f", turkish)
                                }
                            }
                        }
                    } catch  {
                        print("Error")
                    }
                }
            }
        }
        task.resume()
    }
}

