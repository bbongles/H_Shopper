package com.online.shop.controller;


import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.online.shop.domain.ImageVO;
import com.online.shop.domain.OptionVO;
import com.online.shop.domain.ProductVO;
import com.online.shop.domain.QnaRVO;
import com.online.shop.domain.QnaVO;
import com.online.shop.domain.ReviewRVO;
import com.online.shop.domain.ReviewVO;
import com.online.shop.domain.SellerVO;
import com.online.shop.pageutil.PageCriteria;
import com.online.shop.pageutil.PageMaker;
import com.online.shop.persistence.QnADAO;
import com.online.shop.persistence.RevDAO;
import com.online.shop.service.BuyerService;
import com.online.shop.service.ProductService;
import com.online.shop.service.SellerService;

@Controller // 스프링 프레임워크에 Controller bean 객체로 등록
@RequestMapping(value="/seller")
public class SellerController {

	private static final Logger logger = 
			LoggerFactory.getLogger(SellerController.class);
	
	@Autowired 
	ProductService productService;
	
	@Autowired
	SellerService sellerService;
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	@Autowired
	BuyerService buyerService;
	
	@Autowired
	private QnADAO dao;
	
	@Autowired
	private RevDAO daoR;
	
	@RequestMapping(value="/sellerHome", method=RequestMethod.GET) // 맵핑 판매자 홈으로 바꾸고 나중에 쿼리 스트링 넘겨서 각각의 판매자 홈으로 넘어가게 해줘야함
	public String sellerHome(Model model, String s_id, HttpServletRequest request) {
		
		// 로그인한 판매자의 세션 정보 받아오기
/*		HttpSession session = request.getSession();
	    Object id = session.getAttribute("s_login_id");
		
		String s_login_id = (String) id;*/
		
		SellerVO sellerInfo = sellerService.readSellerInfo(s_id);
		
		// 전체 상품 리스트
		List<ProductVO> productList = sellerService.readProductBySid(s_id);
		
		int length = productList.size();
		int numOfPage = length / 8;
		if (length % 8 > 0) {
			numOfPage++; // 나머지가 있으면 올림
			// 뷰페이저로 한 페이지에 4개씩 출력 !
			// ex) (9/4 = 2.X )=> 3페이지 필요
		}
		int remainder = length % 8;
		
		
		logger.info("productList size: " + productList.size());
		// 전체 상품 리스트를 Model 객체에 넣어서 View(jsp)에 전달
		model.addAttribute("productList", productList);

		// 판매자 정보를 Model 객체에 넣어서 View(jsp)에 전달
		model.addAttribute("sellerInfo", sellerInfo);
		
		model.addAttribute("numOfPage", numOfPage);
		model.addAttribute("remainder", remainder);
		
		logger.info("length : " + length);
		logger.info("numOfPage : " + numOfPage);
		logger.info("remainder : " + remainder);
		

		return "/seller/sudo_seller_home";
		
	} // end sellerHome() -> 판매자 홈에서 상품 리스트를 보여주는 역할
	
	
	@RequestMapping(value = "/products", method = RequestMethod.GET)
	public String product(Model model, String p_cate1, String p_cate2) {
		logger.info("main 컨트롤러 실행");
		
		logger.info("p_cate1=" + p_cate1);
		if (p_cate1 != null && p_cate2 == null) {
		
		// 카테고리 1로 상품 받아오기
		List<ProductVO> productListByPcate = sellerService.readAllProductByPcate1(p_cate1);
		
		int length = productListByPcate.size();
		int numOfPage = length / 9;
		if (length % 9 > 0) {
			numOfPage++; // 나머지가 있으면 올림
			// 뷰페이저로 한 페이지에 4개씩 출력 !
			// ex) (9/4 = 2.X )=> 3페이지 필요
		}
		int remainder = length % 9;
		
		// 전체 상품 리스트를 Model 객체에 넣어서 View(jsp)에 전달
		model.addAttribute("productListByPcate", productListByPcate);
		model.addAttribute("numOfPage", numOfPage);
		model.addAttribute("remainder", remainder);
		logger.info("length : " + length);
		logger.info("numOfPage : " + numOfPage);
		logger.info("remainder : " + remainder);
//		logger.info(productList.get(0).getP_name()); 
		
		}
		
		logger.info("p_cate2=" + p_cate2);
		if (p_cate1 == null && p_cate2 != null) {
		
		// 카테고리 2로 상품 받아오기
		List<ProductVO> productListByPcate = sellerService.readAllProductByPcate2(p_cate2);
		
		int length = productListByPcate.size();
		int numOfPage = length / 9;
		if (length % 9 > 0) {
			numOfPage++; // 나머지가 있으면 올림
			// 뷰페이저로 한 페이지에 4개씩 출력 !
			// ex) (9/4 = 2.X )=> 3페이지 필요
		}
		int remainder = length % 9;
		
		// 전체 상품 리스트를 Model 객체에 넣어서 View(jsp)에 전달
		model.addAttribute("productListByPcate", productListByPcate);
		model.addAttribute("numOfPage", numOfPage);
		model.addAttribute("remainder", remainder);
		logger.info("length : " + length);
		logger.info("numOfPage : " + numOfPage);
		logger.info("remainder : " + remainder);
//		logger.info(productList.get(0).getP_name());
		
		}

		return "common/sudo_products";

	} // end product
	
	/*----------------------------------------------------------------------------*/
	
	@RequestMapping(value="pDetail", method=RequestMethod.GET)
	public String productDetail(int p_no, String s_id, String p_name, Integer page, QnaVO vo, Model model, HttpServletRequest request) {
		
		ProductVO pVo = sellerService.readItemByPno(p_no); // 상품 번호에 의한 각 상품의 전체
		// 정보 받아오기
		List<OptionVO> optionList = sellerService.readOpByPno(p_no); // 옵션 정보를
		// 받아오기
		List<ImageVO> imageList = sellerService.readImgByPno(p_no); // 이미지 정보를
		// 받아오기
		List<ProductVO> cateCheck = productService.selectCate2(pVo.getP_cate2()); // 카테고리가
		// 연관된
		// 작품
		// 리스트

		// 판매자 정보 받아오기
		s_id = pVo.getS_id();
		SellerVO sVo = sellerService.readSellerInfo(s_id);

		int length = cateCheck.size();
		int numOfPage = length / 3;
		if (length % 3 > 0) {
			numOfPage++; // 나머지가 있으면 올림
		}
		int remainder = length % 3;

		model.addAttribute("productVO", pVo); // 전체 정보를 Model 객체에 넣어서 View(jsp)에
		// 전달
		model.addAttribute("optionList", optionList); // 받아온 옵션 정보를 Model 객체에
		// 넣어서 View(jsp)에 전달
		model.addAttribute("imageList", imageList); // 받아온 이미지 정보를 Model 객체에 넣어서
		// View(jsp)에 전달

		// 전체 상품 리스트를 Model 객체에 넣어서 View(jsp)에 전달
		// model.addAttribute("productList", productList);
		model.addAttribute("numOfPage", numOfPage);
		model.addAttribute("remainder", remainder);
		model.addAttribute("relativeList", cateCheck); // 카테고리 검색해서 연관상품 보여주기
		model.addAttribute("sVo", sVo);

		
		//System.out.println("qnrController");
		// 페이지 criteria 생성자 만들기
		PageCriteria c = new PageCriteria();
		if (page != null){
			c.setPage(page);
		}
		
		List<QnaVO> list = dao.selectQna(p_no);

		List<QnaRVO> listR = new ArrayList<>();
		for(QnaVO volist : list) {
			if(volist.getQna_reply() == 1) {
			QnaRVO rvo = dao.selectQnaR(volist);
			listR.add(rvo);
			}
		}
		
		List<ReviewVO>list1 = daoR.selectRev(p_no);
		List<ReviewRVO> list2 = new ArrayList<>();
		for(ReviewVO volist : list1) {
			if(volist.getRev_reply() == 1) {
			ReviewRVO vo1 = daoR.selectRevReply(volist.getRev_no());
			list2.add(vo1);
			
			}
		}

		model.addAttribute("listQnA", list);
		model.addAttribute("listQnAR", listR);
				
		model.addAttribute("listRev", list1);
		model.addAttribute("listReply", list2);
		
		// 페이지 메이커 생성
		PageMaker maker = new PageMaker();
		maker.setCrieria(c);
		maker.setTotalCount(dao.getNumOfRecordsQna());
		maker.setPageData();
		model.addAttribute("pageMaker", maker);
		
		// 카테고리 검색해서 연관상품 보여주기
		List<ProductVO> relativelist = productService.selectCate2(pVo.getP_cate2());
		model.addAttribute("relativeList", relativelist);
		
		return "/seller/sudo_product_detail";
		
	} // end productDetail() -> 판매자 홈에서 상품 번호를 참조해 상품 상세 페이지로 넘겨주는 역할 

	
	@RequestMapping(value="logoPop", method=RequestMethod.GET)
	public void logoPopGet() {
		
	}
	
	@RequestMapping(value="logoPop", method=RequestMethod.POST)
	public void logoPopPost(@RequestBody SellerVO sVo, String s_id, HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		Object id = session.getAttribute("s_login_id");
		s_id = (String) id;
		logger.info("infoPop 로고 s_id........"+s_id + "/"+sVo.getS_logo());
		// 서비스 객체를 사용하여 로고 이미지 update
		int LUpResult = sellerService.updateLogo(sVo, s_id);
		//logger.info("결과: " + LUpResult);
		//int LUpResult = 1;
		if(LUpResult == 1) {
			response.getWriter().print(1);
		}else {
			response.getWriter().print(0);
		}
			
	}
	
	@RequestMapping(value="infoPop", method=RequestMethod.GET)
	public void infoPopGet() {
		
	}
	
	@RequestMapping(value="infoPop", method=RequestMethod.POST)
	public void infoPopPost(@RequestBody SellerVO sVo, String s_id, HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
	    Object id = session.getAttribute("s_login_id");
		s_id = (String) id;
		logger.info("infoPop 로고 s_id........"+s_id+"//"+sVo.getS_info());
		
		// 서비스 객체를 사용하여 판매자 정보 update
		//int IUpResult = 1;
		int IUpResult = sellerService.updateInfo(sVo, s_id);
		logger.info("결과: " + IUpResult);
		if(IUpResult == 1) {
			response.getWriter().print(1);
		}else {
			response.getWriter().print(0);
		}
	}

	/*----------------------------------------------------------------------------*/
	
	// mypage 호출
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

	
	
} // end class SellerController
