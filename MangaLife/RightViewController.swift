//
//  RightViewController.swift
//  MangaLife
//
//  Created by suncihai on 16/2/9.
//  Copyright © 2016年 suncihai. All rights reserved.
//

import UIKit

class RightViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let data = ["大教室1","大教室2","大教室3","大教室4","图书馆1","图书馆2","图书馆3","图书馆4","林荫小道1","林荫小道2","樱花树1","竹林","街景1","街景2","街景5","餐厅10","餐厅11","机房","超市1","酒吧"]
    
    @IBOutlet weak var settingTableView: UITableView!
    @IBOutlet weak var searchBar:UISearchBar!
    
    var searchActive:Bool=false
    var filtered:[String]=[]
    var imageName:String!
    
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
            imageName=filtered[indexPath.row]+".jpg"
        }else{
            imageName=data[indexPath.row]+".jpg"
        }
        
        let wid=UIImage(named: imageName)?.size.width
        let hei=UIImage(named: imageName)?.size.height
        let newImageView = ImageViewList(frame: CGRectMake(pointX, pointY, wid!, hei!))
        newImageView.image=UIImage(named: imageName)
        
        let vc=Common.rootViewController
        vc.view.addSubview(newImageView)
        
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
        return 70
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("rightViewCell", forIndexPath: indexPath)
        
        cell.backgroundColor = UIColor.clearColor()
        
        if(searchActive){
            if filtered.count==0{
                cell.imageView?.image = UIImage(named:data[indexPath.row]+".jpg")
                //        cell.textLabel?.text = data[indexPath.row]
            }else{
                cell.imageView?.image = UIImage(named:filtered[indexPath.row]+".jpg")
                //            cell.textLabel?.text = filtered[indexPath.row]
            }
        }else{
            cell.imageView?.image = UIImage(named:data[indexPath.row]+".jpg")
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