//
//  DetailViewController.swift
//  visBrain
//
//  Created by Apple on 29/04/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var data :detailData?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         setNavigation(title: "Detail", viewControlla: self)
        print(data?.msg ?? "Not Found")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
