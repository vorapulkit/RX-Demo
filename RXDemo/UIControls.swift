//
//  UIControls.swift
//  RXDemo
//
//  Created by Pulkit's Mac on 04/08/17.
//  Copyright © 2017 Pulkit's Mac. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class UIControls: UIViewController {

    @IBOutlet weak var txtFields: UITextField!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var btn: UIButton!
    let disposeBag = DisposeBag() // Bag of disposables to release them when view is being deallocated

    override func viewDidLoad() {
        super.viewDidLoad()

        implementTextFields()
        implementTextViews()
        implementButtons()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:
    //MARK: Text Fields
    func implementTextFields(){
        
        txtFields.rx.text.orEmpty.subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
            
            print(self.txtFields.text ?? "")
            
        })
        .addDisposableTo(disposeBag)
        
    }
    //MARK:
    //MARK: Text Views
    func implementTextViews(){
        
        txtView.rx.text.orEmpty.subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
            
            print(self.txtView.text ?? "")
            
        })
            .addDisposableTo(disposeBag)
        
    }
    
    
    //MARK:
    //MARK: UIButton
    func implementButtons(){
        btn.rx.tap.subscribe { [unowned self] in
                print("Button Tapped")
            }
            .addDisposableTo(disposeBag)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
