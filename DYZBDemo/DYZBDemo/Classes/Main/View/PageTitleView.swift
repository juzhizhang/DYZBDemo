//
//  PageTitleView.swift
//  DYZBDemo
//
//  Created by admin on 17/12/16.
//  Copyright © 2017年 tdin360. All rights reserved.
//

import UIKit




fileprivate let kScrollLine:CGFloat = 2

fileprivate let kNormalColor:(CGFloat,CGFloat,CGFloat)=(85,85,85)
fileprivate let kSelectColor:(CGFloat,CGFloat,CGFloat)=(255,128,0)
protocol PageTitleViewDeletage:class {
    
    func pageTitleview(titleView:PageTitleView,SelectIndex index :Int)
   
}

class PageTitleView: UIView {

 
    fileprivate lazy var titleLabels:[UILabel] = [UILabel]()
    fileprivate var titles=[String]()
    fileprivate var currentIndex=0
    weak var deletage:PageTitleViewDeletage?
    init(frame: CGRect,titles:[String]) {
        super.init(frame: frame)
    
        self.titles=titles
    
         self.setupUI()
    }
    
    
    fileprivate lazy var scrollView:UIScrollView={
    
        let scrollView = UIScrollView()
        
        scrollView.showsHorizontalScrollIndicator=false
        scrollView.scrollsToTop=false
        scrollView.bounces=false

        return scrollView
    
    }()
    
 
    //添加滚动线条
    
    fileprivate lazy var scrollLine:UIView={
        
        let scrollLine=UIView()
        
        scrollLine.backgroundColor=UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        return scrollLine
        
    }()
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }

}

//添加scrollview
extension PageTitleView{


    
    func setupUI()  {
     
        self.addSubview(scrollView)
        scrollView.frame=bounds
        
        self.setupTitles()
        self.setupBootomLine()
        
    }

    //添加标题
    private func setupTitles(){
    
    
        let labelW:CGFloat=frame.width/CGFloat(titles.count)
        let labelH:CGFloat=frame.height-kScrollLine
        let labelY:CGFloat=0
        
        for (idx,title) in titles.enumerated(){
        
            
            let label = UILabel()
            
            label.text=title
            label.tag=idx
            label.font=UIFont.systemFont(ofSize: 16)
            label.textColor=UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            let labelX:CGFloat=labelW*CGFloat(idx)
        
            
            label.frame = CGRect(x:labelX,y:labelY,width:labelW,height:labelH)
            
            scrollView.addSubview(label)
            
            self.titleLabels.append(label)
            
            //添加点击事件
            
            label.isUserInteractionEnabled=true
            
            let tap = UITapGestureRecognizer()
            
            tap.addTarget(self, action: #selector(self.titleClick(tap:)))
            label.addGestureRecognizer(tap)
        
        }
        
        
    
    }
    
    //添加底部线条
    private func setupBootomLine(){
    
    
        let lineH:CGFloat=0.5
        let line = UIView(frame:CGRect(x:0,y:frame.height-lineH,width:frame.width,height:0.5))
        line.backgroundColor=UIColor.lightGray
        self.addSubview(line)
        
        self.scrollView.addSubview(scrollLine)
        
        guard let firstLabel = titleLabels.first else {return}
        self.scrollLine.frame=CGRect(x:firstLabel.frame.origin.x,y:self.frame.height-kScrollLine,width:firstLabel.frame.width,height:kScrollLine)
        firstLabel.textColor=UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
    
    }

  
}

extension PageTitleView{


    @objc fileprivate func titleClick(tap:UITapGestureRecognizer){
       
        
        
        
        //获取当前label
        guard  let currentLabel = tap.view as? UILabel else {return}
        
        
        
        if currentIndex==currentLabel.tag{return}
        
        //获取上一个label
        let oldLabel = titleLabels[currentIndex]
        
        //改变label颜色
        currentLabel.textColor=UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //保存当前index
        self.currentIndex=currentLabel.tag
        
        //设置下标滚动
        
        let scrollLineX = CGFloat(currentLabel.tag)*scrollLine.frame.width
        
        UIView.animate(withDuration: 0.15, animations: {
        
         self.scrollLine.frame.origin.x=scrollLineX
        
        })
        //设置代理回调
        
        if deletage != nil {
        
         self.deletage?.pageTitleview(titleView: self, SelectIndex: currentIndex)
        
        }
       
    }

}

extension PageTitleView{


    func setTitleProgress(progress:CGFloat,sourceIndex:Int,targetIndex:Int) {
        
        
        let sourceLabel = titleLabels[sourceIndex]
        
        let tragetLabel = titleLabels[targetIndex]
   
        //处理滑块逻辑
        
         let moveTotalX = tragetLabel.frame.origin.x-sourceLabel.frame.origin.x
        
         let moveX = moveTotalX * progress
        
         self.scrollLine.frame.origin.x=sourceLabel.frame.origin.x + moveX
        
        
       //处理渐变
        
        //1取出变化范围
        
        let colorDelta = (kSelectColor.0-kNormalColor.0,kSelectColor.1-kNormalColor.1,kSelectColor.2-kNormalColor.2)
        
        sourceLabel.textColor=UIColor.init(r: kSelectColor.0-colorDelta.0*progress, g: kSelectColor.1-colorDelta.1*progress, b: kSelectColor.2-colorDelta.2*progress)
        
        tragetLabel.textColor=UIColor.init(r: kNormalColor.0+colorDelta.0*progress, g: kNormalColor.1+colorDelta.1*progress, b: kNormalColor.2+colorDelta.2*progress)
        //记录index
          currentIndex=targetIndex
    }

}
