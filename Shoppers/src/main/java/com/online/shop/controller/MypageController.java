package com.online.shop.controller;



import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.online.shop.domain.BuyerVO;
import com.online.shop.service.BuyerService;

 
@Controller
@RequestMapping(value="/mypage")
public class MypageController {

	public static final Logger logger = LoggerFactory.getLogger(MypageController.class);

	@Autowired
	private BuyerService buyersevice;
	
	
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
	
	//개인정보수정
	@RequestMapping(value="buyermypage_updateinfo", method=RequestMethod.GET)
	public void BuyerMypageUpdateInfo(String b_id, Model model){
		System.out.println("구매자아이디: "+ b_id);
		BuyerVO vo = buyersevice.read(b_id);
		model.addAttribute("buyerInfo", vo);
	}
	
	//구매자 마이페이지 정보수정 기존비밀번호 일치 확인
	@RequestMapping(value = "b_checkpw", method = RequestMethod.POST)
	public void b_checkid(@RequestBody BuyerVO vo, HttpServletResponse response) throws IOException {

		logger.info("checkid 실행");
		logger.info("userpw: " + vo.getB_pw()+ "//id: " +vo.getB_id());

		if(buyersevice.isValidUser(vo.getB_id(), vo.getB_pw())) {
			response.getWriter().print(1);
		} else {
			response.getWriter().print(0);
		}

	}
	
	//개인정보수정
	@RequestMapping(value="buyermypage_updateinfo", method=RequestMethod.POST)
	public void BuyerMypageUpdateInfoPost(@RequestBody BuyerVO vo, HttpServletResponse response) throws IOException{
		System.out.println("vo: " +vo.getB_id()+"/"+vo.getB_pw()+"/"+vo.getB_email());
		
		int result = buyersevice.updateBuyerInfo(vo);
		System.out.println("결과:"+result);
		if(result == 1) {
			response.getWriter().print(1);
		}else {
			response.getWriter().print(0);
		}		
	}
	
}
