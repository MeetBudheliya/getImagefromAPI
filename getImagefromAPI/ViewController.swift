//
//  ViewController.swift
//  getImagefromAPI
//
//  Created by MAC on 19/12/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var x = 0
    var listOfData = [Datum]()
    //  var imgData = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.layer.cornerRadius = 15
        collectionView.delegate = self
        collectionView.dataSource = self
        parsing()
        startTimer()
    }
    func parsing() {
        let url = URL(string: "https://reqres.in/api/users")!
        print(url)
        let datatast = URLSession.shared.dataTask(with: url) { (data, _, _) in
            print(data!)
            guard let JsonData = data else
            {
                return
                
            }
            do{
                let decoder = JSONDecoder()
                let dataResponse = try decoder.decode(Welcome.self, from: JsonData)
                let details = dataResponse.data
                self.listOfData = details!
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                //                let config = URLSessionConfiguration.default
                //                let session = URLSession(configuration: config)
                //                if let imgurl = NSURL(string: self.listOfData[0].avatar!){
                //
                //                    let task = session.dataTask(with: imgurl as URL, completionHandler: {data, response, error in
                //
                //                        if let err = error {
                //                            print("Error: \(err)")
                //                            return
                //                        }
                //
                //                        if let http = response as? HTTPURLResponse {
                //                            if http.statusCode == 200 {
                //                                let downloadedImage = UIImage(data: data!)
                //                                DispatchQueue.main.async {
                //                                    self.imgData = downloadedImage!
                //
                //                                }
                //                            }
                //                        }
                //                   })
                //                   task.resume()
                //                }
            }catch
            {
                print("catch Error")
            }
            
        }
        datatast.resume()
    }
    
    @objc func scrollToNextCell(){
        self.x = self.x + 1
        if self.x < listOfData.count{
            let indexPath = IndexPath(item: x, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
        }else{
            self.x = 0
            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    func scrollToPreviousCell()
    {
        self.x = self.x - 1
        if self.x > -1 {
            let indexPath = IndexPath(item: x, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
        }else{
            print("Story Images Finish At Previous")
        }
    }
    func startTimer() {
        Timer.scheduledTimer(timeInterval: 5, target: self, selector:#selector(self.scrollToNextCell), userInfo: nil, repeats: true)
    }
    
}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cells = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! collectionCell
        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! collectionCell
        
        let image = listOfData[indexPath.row]
        if let imageURL = URL(string: image.avatar!) {
            print(imageURL)
            if let data = try? Data(contentsOf: imageURL) {
                cells.img.image = UIImage(data: data)
            }
        }
        //cells.img.image = UIImage(contentsOfFile: listOfData[indexPath.row].avatar!)
        cells.id.text = String(listOfData[indexPath.row].id!)
        cells.name.text = listOfData[indexPath.row].firstName! + " " + listOfData[indexPath.row].lastName!
        cells.mail.text = listOfData[indexPath.row].email
        cells.desc.text = "hi kudaghsbfkjh mjjhsegfrjk asbdb kyugrft gdhfkuybfhvk,ud hyfku sdzhbhfkhv "
        cells.imgWidth.constant = collectionView.frame.width
        cells.imgHeight.constant = collectionView.frame.height
        return cells
    }
}
class collectionCell: UICollectionViewCell{
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mail: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
    @IBOutlet weak var imgHeight: NSLayoutConstraint!
    
}

