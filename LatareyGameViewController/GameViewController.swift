//
//  GameViewController.swift
//  LatareyGameViewController
//
//  Created by Bobomurod Ergashev on 23/07/22.
//

import UIKit
let windowWidth = UIScreen.main.bounds.width
let windowHeight = UIScreen.main.bounds.height
var itemWidth :CGFloat = 0
class GameViewController: UIViewController {

//    let vc = LotteryItemView()
    var listItems = [LotteryItem]()
    
    var firstBlock : LotteryItemView!
    
    var secondBlock : LotteryItemView!
    
    var thirdBlock : LotteryItemView!
    
    var flag : Bool = false

    var id1 : Int!
    var id2 : Int!
    var id3 : Int!

    var label : UILabel!
    var price : Int = 30
    
    var dollarView = UIView()
    
    var dollarImage : UIImageView!
    
    var dollarLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        img.image = UIImage(named: "wood2")
        view.addSubview(img)
        self.initData()
        self.initViews()
       

    }
    
    private func initData(){
        self.listItems.append(LotteryItem(image: "1", id: 1))
        self.listItems.append(LotteryItem(image: "2", id: 2))
        self.listItems.append(LotteryItem(image: "3", id: 3))
        self.listItems.append(LotteryItem(image: "4", id: 4))
        self.listItems.append(LotteryItem(image: "5", id: 5))
        self.listItems.append(LotteryItem(image: "6", id: 6))
        self.listItems.append(LotteryItem(image: "7", id: 7))
        self.listItems.append(LotteryItem(image: "8", id: 8))
        self.listItems.append(LotteryItem(image: "9", id: 9))
        self.listItems.append(LotteryItem(image: "10", id: 10))
  }
    
    private func initViews(){
        label = UILabel(frame: CGRect(x: 30, y: 50, width: 400, height: 50))
        label.text = "Price: \(self.price)"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 30)
        
        self.view.addSubview(label)
        
        let top: CGFloat = windowWidth * 0.3
        let leftSpace: CGFloat = 25
        let spacing: CGFloat = 8
        itemWidth = (windowWidth - (2*(leftSpace + spacing))) / 3
        
        self.firstBlock = LotteryItemView(frame: CGRect(x: leftSpace , y: top, width: itemWidth , height: itemWidth * 1.8), list: self.listItems)
        
        self.view.addSubview(self.firstBlock)
        
        self.secondBlock = LotteryItemView(frame: CGRect(x: leftSpace + itemWidth + spacing, y: top, width: itemWidth, height: itemWidth * 1.8), list: self.listItems)
        self.view.addSubview(self.secondBlock)
        
        self.thirdBlock = LotteryItemView(frame: CGRect(x: leftSpace + 2*(itemWidth + spacing), y: top, width: itemWidth, height: itemWidth * 1.8), list: self.listItems)
        self.view.addSubview(self.thirdBlock)
//        thirdBlock.conflikt
        
        self.dollarView = UIView(frame: CGRect(x: 130, y: thirdBlock.frame.maxY, width: 100, height: 100))
//        view.addSubview(dollarView)
        dollarView.backgroundColor = .clear
        dollarView.layer.cornerRadius = dollarView.frame.width / 2
        
        self.dollarImage = UIImageView(frame: CGRect(x: 4, y: 4, width: dollarView.frame.width - 8, height: dollarView.frame.height - 8))
        dollarImage.image = UIImage(named: "dollar")
        dollarImage.contentMode = .scaleToFill
        dollarImage.clipsToBounds = true
        dollarImage.layer.cornerRadius = 6
        self.dollarView.addSubview(dollarImage)
        
        self.dollarLabel = UILabel(frame: CGRect(x: 34, y: 8, width: dollarImage.frame.width - 8, height: dollarImage.frame.height - 8))
        dollarLabel.textColor = .red
        dollarLabel.text = "$2"
        dollarLabel.font = .boldSystemFont(ofSize: 26)
        dollarView.addSubview(dollarLabel)
        
//        self.view.addSubview(dollarView)
        
        
        let btn = UIButton(frame: CGRect(x: 130, y: thirdBlock.frame.maxY + 120, width: 100, height: 100))
        btn.setTitle("Roller", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = btn.frame.width/2
        btn.addTarget(self, action: #selector(onPressRoller(_:)), for: .touchUpInside)
        view.addSubview(btn)
    
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.firstBlock.roll()
        self.secondBlock.roll()
        self.thirdBlock.roll()
       
    }
    @objc func onPressRoller(_ sender: UIButton){
        self.flag = true
        if self.price > 0{
            self.firstBlock.roll()
            self.secondBlock.roll()
            self.thirdBlock.roll()
        }else{
            self.label.text = "Price: "
            alerfunc(bir: 1)
        }
       
        thirdBlock.conflikt = {item in
            self.id3 = item.id
            print(self.id3)
        }
        firstBlock.conflikt = {item in
            self.id1 = item.id
            print(self.id1)
        }
        secondBlock.conflikt = {item in
            self.id2 = item.id
            print(self.id2)
        }
        if let bir = id1 , let ikki = id2 , let uch = id3{
           
            if id1 == id2 && id1 == id3 && flag == true {
                self.price += 25
                self.dollarLabel.text = "$\(25)"
                for i in 1 ... 3{
                    self.addCoin()

                }
            }else if id1 == id2 || id2 == id3{
                
                self.price += 5
               
                self.dollarLabel.text = "$\(5)"
                for i in 1 ... 3{
                    self.addCoin()

                }
                
            }else{
                if self.price < 2{
                    
                    self.label.text = " Mablag yetarli emas "
                    
                    alerfunc(bir: 1)
                }else{
                    self.price -= 2
                    self.label.text = "Price: \(self.price)"
                }
              
            }
            
//
//            UIView.animate(withDuration: 2.5, delay: 0.0, options: [.curveEaseOut]) {
//                sender.transform = CGAffineTransform(translationX: 20 - sender.frame.width , y: 20 - sender.frame.maxY)
                    
                    
                    
//                    scaleX: 20 - sender.frame.width , y: 20 - sender.frame.maxY)
//            }
     
//    }
//        firstBlock
         
        }

}
    func addCoin(){
        view.addSubview(dollarView)
        for i in 1 ... 5{
            UIView.animate(withDuration: 1.0, delay: 0.1, options: [.curveEaseIn]) {
                let current:CGFloat = self.dollarView.frame.minY
                let mov:CGFloat = self.label.frame.minY
                
                self.dollarView.transform = CGAffineTransform(translationX: -CGFloat(i)*10, y: mov-current)
            } completion: { done in
                self.label.text = "Price: \(self.price)"
                self.dollarView.removeFromSuperview()
                self.dollarView.transform = CGAffineTransform(translationX: 0, y: 0)
            }
        }
       
       

    }
    func alerfunc(bir:Int){
        let alert = UIAlertController(title: " UPS ! ", message: "Pulingiz tugadi iltimos hisobingizni tuldiring!", preferredStyle: .alert)
        alert.modalPresentationStyle = .fullScreen
        present(alert, animated: true)
        
        let okBtn = UIAlertAction(title: "OK", style: .default){action in
                self.price +=  30
                self.label.text = "Price: \(self.price)"
        }
        alert.addAction(okBtn)
    }
}
//MARK: Ichida rasmlar tablesini o'rab turgan View
class LotteryItemView: UIView,UITableViewDelegate,UITableViewDataSource{
    private var list: [LotteryItem]
//    let vc = GameViewController()
    private var tableView : UITableView!
    var conflikt : ((LotteryItem) -> Void)?

    init(frame: CGRect, list: [LotteryItem]){
        self.list = list
        super.init(frame: frame)
        self.initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews(){
        self.layer.cornerRadius = 6
        self.backgroundColor = .clear
        
        self.tableView = UITableView(frame: CGRect(x: 5, y: 5, width: self.frame.width - 10, height: self.frame.height - 10))
        self.tableView.backgroundColor = .red
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.separatorStyle = .none
        self.addSubview(tableView)
    }
    func roll(){
        self.list.shuffle()
//        var nima = Int.random(in: self.list.count/2...self.list.count-1)
        conflikt?(list[list.count - 2])
//        print(list[list.count - 2])
        self.tableView.reloadData()
//        tableView
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseIn) {
            self.tableView.scrollToRow(at: IndexPath(row: self.list.count - 2, section: 0), at: .middle, animated: true)
        } completion: { done in
            
        }

    }
//    Int.random(in: self.list.count/2...self.list.count-1)
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LotterTableViewCell(item: self.list[indexPath.row], size: CGSize(width: self.frame.width - 10, height: itemWidth - 10))
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemWidth-10
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 1.5, delay: 0.2, options: [.curveEaseOut]) {
            cell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }

    }
    
}
// MARK: Ichida har bitta imageni saqlab turgan customcontentviewcell
class LotterTableViewCell: UITableViewCell{
    private var item : LotteryItem!
    init(item: LotteryItem,size : CGSize){
        self.item = item
        super.init(style: .default, reuseIdentifier: "LotterTableViewCell")
        self.initViews(size: size)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews(size:CGSize){
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .cyan
        
        let content : UIView = UIView(frame: CGRect(x: 2, y: 2, width: size.width - 4, height: size.height - 4))
        content.backgroundColor = .purple
        content.layer.cornerRadius = 5
        
        let image = UIImageView(frame: CGRect(x: 5, y: 5, width: content.frame.width-10, height: content.frame.height-10))
        image.image = UIImage(named: self.item.image)
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 5
        image.contentMode = .scaleToFill
        content.addSubview(image)
        self.contentView.addSubview(content)
        
    }
}


//MARK: Har bitta itemni xususiyatlarini saqlab turuvchi struct
struct LotteryItem{
        var image: String
        var id: Int
}
