package com.online.shop.controller;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

 
@Controller
@RequestMapping(value="/mypage")
public class MypageController {

	public static final Logger logger = LoggerFactory.getLogger(MypageController.class);

	
	@RequestMapping(value="buyermypage", method=RequestMethod.GET)
	public void BuyerMypage(String b_id){
		
	}
	
	@RequestMapping(value="buyermypage_orderlist", method=RequestMethod.GET)
	public void BuyerMypageOrderlist(){
		
	}
	

	@RequestMapping(value="buyermypage_completelist", method=RequestMethod.GET)
	public void BuyerMypageCompletelist(){
		
	}
	
	@RequestMapping(value="sellermypage", method=RequestMethod.GET)
	public void SellerMypage(){
		
	}
	
	@RequestMapping(value="sellermypage_order", method=RequestMethod.GET)
	public void SellerMypageOrder(){
		
	}
	
	@RequestMapping(value="sellermypage_complete", method=RequestMethod.GET)
	public void SellerMypageComplete(){
		
	}
	
	@RequestMapping(value="sellermypage_product", method=RequestMethod.GET)
	public void SellerMypageProductAcc(){
		
	}
	
	
	
}
