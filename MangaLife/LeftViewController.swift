//
//  LeftViewController.swift
//  SwiftSideslipLikeQQ
//
//  Created by JohnLui on 15/4/11.
//  Copyright (c) 2015年 com.lvwenhan. All rights reserved.
//

import UIKit

//protocol SideMenuDelegate:NSObjectProtocol{
//    func menuItemSelected(imageview:UIImageView)
//}

// 侧滑菜单 View Controller
class LeftViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let data = ["兔斯基1", "兔斯基2", "兔斯基3","兔斯基4", "兔斯基5", "兔斯基6", "床","灯泡","电脑","礼物","瓶子","手机","心","信","星星1","conan1","conan2","conan3","conan4","conan5","conan6","conan7","conan8","conan9","conan10","conan13","conan14","conan15","conan16","conan17","conan18","conan19","conan20","conan21","conan22","conan23","conan24","conan25","conan26","conan27","conan28","conan29","conan30","conan31","conan32","conan33","conan34","conan35","conan36","conan37","conan38","conan39","对话框1","对话框2","对话框3","tony1","tony2","tony3","tony4","sam1","sam2","sam3","sam4","sam5","sam6","sam7","mary"]

    @IBOutlet weak var settingTableView: UITableView!
    @IBOutlet weak var searchBar:UISearchBar!
    
//    weak var delegate:SideMenuDelegate?
    
    var searchActive:Bool=false
    var filtered:[String]=[]
    var imageName:String!
    
    var newImageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.tableFooterView = UIView()
        
        searchBar.delegate = self
        searchBar.placeholder="input name"
        
        self.view.backgroundColor = UIColor.clearColor()
        
        settingTableView.separatorStyle = UITableViewCellSeparatorStyle.None

        self.view.frame = CGRectMake(0, 0, 320 * 0.78, Common.screenHeight)
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        settingTableView.reloadData()
    }

    
    // 处理点击事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        
        let halfSizeOfView = 25.0
        let insetSize = CGRectInset(self.view.bounds, CGFloat(Int(2 * halfSizeOfView)), CGFloat(Int(2 * halfSizeOfView))).size
        
        let pointX = CGFloat(UInt(arc4random() % UInt32(UInt(insetSize.width))))
        let pointY = CGFloat(UInt(arc4random() % UInt32(UInt(insetSize.height))))
        
        if(searchActive){
           imageName=filtered[indexPath.row]+".png"
        }else{
           imageName=data[indexPath.row]+".png"
        }
        
        let wid=UIImage(named: imageName)?.size.width
        let hei=UIImage(named: imageName)?.size.height
        newImageView = ImageViewList(frame: CGRectMake(pointX, pointY, wid!, hei!))
        newImageView.image=UIImage(named: imageName)
        
        
//        let homeVC=HomeViewController()
//        let sideMenu=LeftViewController()
//        sideMenu.delegate=homeVC
        let vc=Common.rootViewController
        vc.view.addSubview(newImageView)
//        self.delegate?.menuItemSelected(newImageView)
 
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive){
            if filtered.count==0{
                return data.count
            }else{
            return filtered.count
            }
        }else{
                return data.count
            }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("leftViewCell", forIndexPath: indexPath) 
        
        cell.backgroundColor = UIColor.clearColor()
        
        if(searchActive){
            if filtered.count==0{
                cell.imageView?.image = UIImage(named:data[indexPath.row]+".png")
                //        cell.textLabel?.text = data[indexPath.row]
            }else{
                cell.imageView?.image = UIImage(named:filtered[indexPath.row]+".png")
                //            cell.textLabel?.text = filtered[indexPath.row]
            }
        }else{
              cell.imageView?.image = UIImage(named:data[indexPath.row]+".png")
//        cell.textLabel?.text = data[indexPath.row]
        }
        
        return cell
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
