

import UIKit
import MDCSwipeToChoose
import AlamofireImage

class ViewController: UIViewController, MDCSwipeToChooseDelegate {
    
    var items: [Item]!
    var currentItem: Item!
    var frontCardView: MDCSwipeToChooseView!
    var backCardView: MDCSwipeToChooseView!
    var index = 0
    
    var photoURL = [
        "http://up.gc-img.net/post_img_web/2013/03/a3a43755438b42d881929eefc7161191_0.jpeg",
        "http://pic.prepics-cdn.com/pib1298076039/5731792_218x291.gif",
        "http://omosoku.com/wp-content/uploads/misawa-225x300.gif"
    ]
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.view.backgroundColor = Const.MAIN_BACKGROUND_COLOR
        self.view.addSubview(UIView.makeHeader())
        
        self.setMyFrontCardView(frontCardView: createSwipeView(item: self.items[0]))
        self.view.addSubview(self.frontCardView)
        
        self.backCardView = createSwipeView(item: self.items[1])
        self.view.insertSubview(self.backCardView, belowSubview: self.frontCardView)
        
        self.currentItem = items[self.index]
        self.index = 1
        
        constructNopeButton()
        constructLikedButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if Const.app.flag == true{
            self.nopeFrontCardView()
            Const.app.flag = false
        }
    }
    
    func suportedInterfaceOrientations() -> UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
    
    func view(_ view: UIView, wasChosenWith wasChosenWithDirection: MDCSwipeDirection) -> Void{
        
        if(wasChosenWithDirection == MDCSwipeDirection.left){
        }
        else{
            self.likeFrontCardView()
        }
        if(self.backCardView != nil){
            self.setMyFrontCardView(frontCardView: self.backCardView)
            self.currentItem = items[self.index]
        }
        self.backCardView = createSwipeView(item: self.items[self.index + 1])
        self.index += 1
        
        if(backCardView != nil){
            self.backCardView.alpha = 0.0
            self.view.insertSubview(self.backCardView, belowSubview: self.frontCardView)
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                self.backCardView.alpha = 1.0
                },completion:nil)
        }
    }
    
    func setMyFrontCardView(frontCardView: MDCSwipeToChooseView) -> Void{
        self.frontCardView = frontCardView
    }
    
    func createSwipeView(item: Item) -> MDCSwipeToChooseView {
        let options = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.likedText = "BUY"
        options.likedColor = UIColor.green
        options.nopeText = "NEXT"
        options.nopeColor = UIColor.lightGray
        
        let swipeView = MDCSwipeToChooseView(
            frame: CGRect(
                x: Const.SCREEN_WIDTH * 0.05,
                y: 90,
                width: Const.SCREEN_WIDTH * 0.9,
                height: Const.SCREEN_HEIGHT - 200
            ),
            options: options
        )
        
        swipeView?.backgroundColor = UIColor.rgba(r: 248, g: 248, b: 248, a: 1.0)
        
        swipeView?.imageView.af_setImage(withURL: URL(string: item.image_url)!)
        swipeView?.imageView.frame = CGRect(x: 0, y: 0, width: (swipeView?.frame.width)!, height: (swipeView?.frame.width)!)
        
        let p: Int = item.price
        let pp: Int = item.pre_price
        let name:String = item.name
        
        let title = UILabel()
        title.frame = CGRect(x: 30, y: (swipeView?.imageView.frame.maxY)! + 5, width: 250, height: 40)
        title.text = name
        title.textColor = UIColor.black
        title.font = UIFont.systemFont(ofSize: 18)
        swipeView?.addSubview(title)
        
        
        let price = UILabel()
        price.frame = CGRect(x: 30, y: title.frame.maxY + 5, width: 150, height: 30)
        price.text = "$\(p)"
        price.textColor = UIColor.red
        price.font = UIFont.systemFont(ofSize: 18)
        price.textAlignment = NSTextAlignment.left
        price.sizeToFit()
        swipeView?.addSubview(price)
        
        let pre = UILabel()
        pre.frame = CGRect(x: price.frame.maxX + 10, y: price.frame.origin.y, width: 150, height: 30)
        pre.text = "$\(pp)"
        pre.textColor = UIColor.gray
        pre.font = UIFont.systemFont(ofSize: 14)
        pre.textAlignment = NSTextAlignment.left
        pre.sizeToFit()
        pre.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        pre.layer.position = CGPoint(x: price.frame.maxX + 10, y: price.center.y)
        swipeView?.addSubview(pre)
        
        
        let detail = UIButton()
        detail.frame = CGRect(x: Const.SCREEN_WIDTH * 0.45 - 50, y: (swipeView?.frame.height)! - 40, width: 100, height: 30)
        detail.backgroundColor = UIColor.cyan
        detail.setTitle("Detail", for: .normal)
        detail.setTitleColor(UIColor.white, for: .normal)
        detail.addTarget(self, action: #selector(self.goDetail), for: .touchUpInside)
        swipeView?.addSubview(detail)
        
        return swipeView!
    }
    
    func constructNopeButton() -> Void{
        let frame = CGRect(x: 20, y: self.frontCardView.frame.maxY + 40, width: 100, height: 30)
        let button = UIButton.nextButton(frame: frame)
        button.addTarget(self, action: #selector(self.nopeFrontCardView), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
    }
    
    func constructLikedButton() -> Void{
        let frame = CGRect(x: Const.SCREEN_WIDTH - 20 - 100, y: self.frontCardView.frame.maxY + 40, width: 100, height: 30)
        let button = UIButton.buyButton(frame: frame)
        button.addTarget(self, action: #selector(self.likeFrontCardView), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        
    }
    
    func goDetail(){
        let detail = DetailViewController()
        detail.currentItem = self.currentItem
        self.present(detail, animated: true, completion: nil)
    }
    
    func nopeFrontCardView() -> Void{
        self.frontCardView.mdc_swipe(MDCSwipeDirection.left)
    }
    
    func likeFrontCardView() -> Void{
//        self.frontCardView.mdc_swipe(MDCSwipeDirection.right)
        let buy = PurchaceViewController()
        self.present(buy, animated: true, completion: nil)
    }
}
