package com.online.shop.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.online.shop.domain.BuyerVO;
import com.online.shop.domain.CartVO;
import com.online.shop.domain.EditorVO;
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
import com.online.shop.service.CartService;
import com.online.shop.service.ProductService;
import com.online.shop.service.SellerService;
import com.online.shop.utility.EncryptUtil;

import com.online.shop.domain.PhotoVo;

@Controller // 스프링 프레임워크에 Controller bean 객체로 등록
@RequestMapping(value = "/buyer")
public class BuyerController {

	private static final Logger logger = LoggerFactory.getLogger(BuyerController.class);

	@Autowired
	ProductService productService;

	@Autowired
	private JavaMailSenderImpl mailSender;

	@Autowired
	BuyerService buyerService;

	@Autowired
	SellerService sellerService;

	@Autowired
	private QnADAO dao;

	@Autowired
	private RevDAO daoR;

	@Autowired
	private CartService cartservice;

	////////////////////////////////////////////////////////////////////////////////////////////////////

	@RequestMapping(value = "pDetail", method = RequestMethod.GET)
	public String productDetail(int p_no, String s_id, String p_name, Integer page, QnaVO vo, Model model) {

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

		// System.out.println("qnrController"); // 페이지 criteria 생성자 만들기
		PageCriteria c = new PageCriteria();
		if (page != null) {
			c.setPage(page);
		}

		List<QnaVO> list = dao.selectQna(p_no);

		List<QnaRVO> listR = new ArrayList<>();
		for (QnaVO volist : list) {
			if (volist.getQna_reply() == 1) {
				QnaRVO rvo = dao.selectQnaR(volist);
				listR.add(rvo);
			}
		}

		List<ReviewVO> list1 = daoR.selectRev(p_no);
		List<ReviewRVO> list2 = new ArrayList<>();
		for (ReviewVO volist : list1) {
			if (volist.getRev_reply() == 1) {
				ReviewRVO vo1 = daoR.selectRevReply(volist.getRev_no());
				list2.add(vo1);

			}
		}

		model.addAttribute("listQnA", list);
		model.addAttribute("listQnAR", listR);

		model.addAttribute("listRev", list1);
		model.addAttribute("listReply", list2);

		// 페이지 메이커 생성 PageMaker maker = new PageMaker(); maker.setCrieria(c);
		/*
		 * maker.setTotalCount(dao.getNumOfRecordsQna()); maker.setPageData();
		 * model.addAttribute("pageMaker", maker);
		 * 
		 * // 카테고리 검색해서 연관상품 보여주기 List<ProductVO> relativelist =
		 * productService.selectCate2(pVo.getP_cate2());
		 * model.addAttribute("relativeList", relativelist);
		 */

		return "/buyer/sudo_product_detail";

	} // end productDetail() -> 판매자 홈에서 상품 번호를 참조해 상품 상세 페이지로 넘겨주는 역할

	///////////////////////////////////////////////////////////////////////////////////////////////////// 판매자홈

	@RequestMapping(value = "/sellerHome", method = RequestMethod.GET) // 맵핑 판매자
																		// 홈으로
																		// 바꾸고
																		// 나중에
																		// 쿼리
																		// 스트링
																		// 넘겨서
																		// 각각의
																		// 판매자
																		// 홈으로
																		// 넘어가게
																		// 해줘야함
	public String sellerHome(Model model, String s_id, HttpServletRequest request) {

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

		return "/buyer/sudo_seller_home";

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
			// logger.info(productList.get(0).getP_name());

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
			// logger.info(productList.get(0).getP_name());

		}

		return "common/sudo_products";

	} // end product
	
	//buyer 검색

	// mypage 부분
	@RequestMapping(value = "buyermypage", method = RequestMethod.GET)
	public void BuyerMypage(String b_id) {

	}

	@RequestMapping(value = "buyermypage_orderlist", method = RequestMethod.GET)
	public void BuyerMypageOrderlist() {

	}

	@RequestMapping(value = "buyermypage_completelist", method = RequestMethod.GET)
	public void BuyerMypageCompletelist() {

	}

	/*
	 * //개인정보수정
	 * 
	 * @RequestMapping(value="buyermypage_updateinfo", method=RequestMethod.GET)
	 * public void BuyerMypageUpdateInfo(String b_id, Model model){
	 * System.out.println("구매자아이디: "+ b_id); BuyerVO vo =
	 * buyerService.read(b_id); model.addAttribute("buyerInfo", vo); }
	 * 
	 * //구매자 마이페이지 정보수정 기존비밀번호 일치 확인
	 * 
	 * @RequestMapping(value = "b_checkpw", method = RequestMethod.POST) public
	 * void b_checkid(@RequestBody BuyerVO vo, HttpServletResponse response)
	 * throws IOException {
	 * 
	 * logger.info("checkid 실행"); logger.info("userpw: " + vo.getB_pw()+
	 * "//id: " +vo.getB_id());
	 * 
	 * if(buyerService.isValidUser(vo.getB_id(), vo.getB_pw())) {
	 * response.getWriter().print(1); } else { response.getWriter().print(0); }
	 * 
	 * }
	 * 
	 * //개인정보수정
	 * 
	 * @RequestMapping(value="buyermypage_updateinfo",
	 * method=RequestMethod.POST) public void
	 * BuyerMypageUpdateInfoPost(@RequestBody BuyerVO vo, HttpServletResponse
	 * response) throws IOException{ System.out.println("vo: "
	 * +vo.getB_id()+"/"+vo.getB_pw()+"/"+vo.getB_email());
	 * 
	 * int result = buyerService.updateBuyerInfo(vo);
	 * System.out.println("결과:"+result); if(result == 1) {
	 * response.getWriter().print(1); }else { response.getWriter().print(0); } }
	 */

	// 구매자가 qna를 등록하기위한 페이지 띄움
	@RequestMapping(value = "insertQnA", method = RequestMethod.GET)
	public void insertQnA(int p_no, String b_id, Model model) {
		System.out.println("insertQnA GET/" + b_id);
		model.addAttribute("p_no", p_no);
		model.addAttribute("b_id", b_id);
	}

	// 구매자가 qna를 작성하고 등록버튼을 클릭했을때 처리
	@RequestMapping(value = "insertQnA", method = RequestMethod.POST)
	public void insertQnAPOST(@RequestBody QnaVO vo, HttpServletResponse response) throws IOException {
		System.out.println("insert qna Post");
		// System.out.println("vo:"+ vo.getB_email() + "/"+vo.getQna_cont());

		int result = dao.insertQnA(vo);

		if (result == 1) {
			response.getWriter().print(1);
		} else {
			response.getWriter().print(0);
		}
	}

	// 구매자가 후기를 등록하기위한 페이지
	@RequestMapping(value = "insertReview", method = RequestMethod.GET)
	public void insertReview(int p_no, String b_id, Model model) {
		System.out.println("vovovovovovvovovo");
		CartVO vo = new CartVO();
		vo.setB_id(b_id);
		vo.setP_no(p_no);
		List<CartVO> list = cartservice.selectCartBuyer(vo);
		model.addAttribute("p_no", p_no);
		model.addAttribute("b_id", b_id);
		model.addAttribute("cartlist", list);

	}

	// 구매자가 후기를 등록하기위한 페이지
	@RequestMapping(value = "insertReview", method = RequestMethod.PUT)
	public void insertReviewPut(@RequestBody CartVO vo, HttpServletResponse response) throws IOException {
		// System.out.println("vo: "+ vo.getB_id()+"vo: " +vo.getP_no());

		// int result =1;
		List<CartVO> list = cartservice.selectCartBuyer(vo);

		if (list.size() > 0) {
			response.getWriter().print(1);
		} else {
			response.getWriter().print(0);
		}

	}

	// 구매자가 후기를 작성하고 저장하는 과정
	@RequestMapping(value = "insertReview", method = RequestMethod.POST)
	public void insertReviewPOST(@RequestBody ReviewVO vo, HttpServletResponse response) throws IOException {
		// System.out.println("vo: "+ vo.getRev_score());
		// System.out.println("vo: " + vo.getRev_cont());
		int result = daoR.insertRev(vo);
		// System.out.println("insert 결과: "+result);
		if (result == 1) {
			response.getWriter().print(1);
		} else {
			response.getWriter().print(0);
		}
	}

	// buyer개인정보수정
	@RequestMapping(value = "buyermypage_updateinfo", method = RequestMethod.GET)
	public void BuyerMypageUpdateInfo(String b_id, Model model) {
		System.out.println("구매자아이디: " + b_id);
		BuyerVO vo = buyerService.read(b_id);
		model.addAttribute("buyerInfo", vo);
	}

	// 구매자 마이페이지 정보수정 기존비밀번호 일치 확인
	@RequestMapping(value = "b_checkpw", method = RequestMethod.POST)
	public void b_checkpw(@RequestBody BuyerVO vo, HttpServletResponse response) throws IOException {

		logger.info("checkpw 실행");
		logger.info("userpw: " + vo.getB_pw() + "//id: " + vo.getB_id());
		vo.setB_pw(EncryptUtil.getEncryptMD5(vo.getB_pw()));
		if (buyerService.isValidUser(vo.getB_id(), vo.getB_pw())) {
			response.getWriter().print(1);
		} else {
			response.getWriter().print(0);
		}

	}

	// 구매자 개인정보수정
	@RequestMapping(value = "buyermypage_updateinfo", method = RequestMethod.POST)
	public void BuyerMypageUpdateInfoPost(@RequestBody BuyerVO vo, HttpServletResponse response) throws IOException {
		System.out.println("vo: " + vo.getB_id() + "/" + vo.getB_pw() + "/" + vo.getB_email());
		vo.setB_pw(EncryptUtil.getEncryptMD5(vo.getB_pw()));
		int result = buyerService.updateBuyerInfo(vo);
		System.out.println("결과:" + result);
		if (result == 1) {
			response.getWriter().print(1);
		} else {
			response.getWriter().print(0);
		}
	}

	// 구매자회원탈퇴페이지
	@RequestMapping(value = "buyermypage_drop", method = RequestMethod.GET)
	public void buyerDrop(String b_id, Model model) {

		System.out.println("구매자아이디: " + b_id);
		BuyerVO vo = buyerService.read(b_id);
		model.addAttribute("buyerInfo", vo);
	}

	// 구매자회원탈퇴
	@RequestMapping(value = "buyermypage_drop_commit", method = RequestMethod.PUT)
	public void buyerDropcommit(@RequestBody BuyerVO vo, HttpServletRequest request, HttpServletResponse response)
			throws IOException {

		System.out.println("구매자아이디: " + vo.getB_id());
		int result = buyerService.deletebuyer(vo.getB_id());
		// int result = 1;
		if (result == 1) {
			HttpSession session = request.getSession();
			session.invalidate();
			response.getWriter().print(1);
			logger.info("세션 비우기 성공!");
		} else {
			response.getWriter().print(0);
			logger.info("세션 비우기 실패!");
		}
	}
	
	// 구매자 로그인 했을때 검색 
	@RequestMapping(value="search_form", method=RequestMethod.POST)
	public String search_form(String searching, Model model){
		logger.info("검색어 : "+searching);
		String p_name = searching;
		logger.info("search_form 컨트롤러 실행");

		List<ProductVO> productListByPcate = productService.selectSearch(p_name);
		logger.info("검색 리스트");
		int length = productListByPcate.size();
		int numOfPage = length / 9;
		if (length % 9 > 0) {
			numOfPage++; // 나머지가 있으면 올림
		}
		int remainder = length % 9;
		model.addAttribute("productListByPcate", productListByPcate);
		model.addAttribute("numOfPage", numOfPage);
		model.addAttribute("remainder", remainder);
		logger.info("length : " + length);
		logger.info("numOfPage : " + numOfPage);
		logger.info("remainder : " + remainder);
		return "common/sudo_products";

	}
	
	// 판매자 홈 게시판
	@RequestMapping(value="/seller_board", method=RequestMethod.GET)
	public void seller_board(Integer page, Model model, String s_id){
		logger.info("page : " + page);
		SellerVO sellerInfo = sellerService.readSellerInfo(s_id);
		
		model.addAttribute("sellerInfo", sellerInfo);
				
		PageCriteria c = new PageCriteria();
		if (page != null) {
			c.setPage(page);
		}
		
		List<EditorVO> list = sellerService.readBoard(c);
		model.addAttribute("boardList", list);
		
		PageMaker maker = new PageMaker();
		maker.setCrieria(c);
		maker.setTotalCount(sellerService.getNumOfRecordsBoard());
		maker.setPageData();
		model.addAttribute("pageMaker", maker);
		
	}
	
	// 판매자 홈 게시판 글 등록
	@RequestMapping(value="/seller_board_register", method=RequestMethod.GET)
	public void seller_board_register(String s_id, Model model){
		logger.info("register 호출 : " + s_id);
		SellerVO sellerInfo = sellerService.readSellerInfo(s_id);
		
		model.addAttribute("sellerInfo", sellerInfo);
	}
	
	// 판매자 홈 게시판 글 등록
		@RequestMapping(value="/seller_board_register", method=RequestMethod.POST)
		public String seller_board_registerPOST(EditorVO vo, RedirectAttributes attr, Model model){
		 	
			int result = sellerService.create(vo);
			logger.info("입력 결과 : " + result);
		 	logger.info("vo : " + vo.getEditor());
		 	logger.info("s_id :" + vo.getS_id());
		 	if(result == 1) {
		 		attr.addFlashAttribute("insert_result", "success");
		 	} else{
		 		attr.addFlashAttribute("insert_result", "fail");
		 	}
		 	
		 	return "redirect:seller_board?s_id=" + vo.getS_id();
		}
	
	// 스마트 에디터 단일파일업로드
		@RequestMapping("/file_uploader")
		public String photoUpload(HttpServletRequest request, PhotoVo vo, @RequestParam("Filedata")MultipartFile file){
			System.out.println("photoUpload() 호출...");
		    String callback = vo.getCallback();
		    String callback_func = vo.getCallback_func();
		    String file_result = "";
		    
		    logger.info("callback: " + callback);
		    logger.info("callback_func: " + callback_func);
		    logger.info("파일 : " + vo.getFiledata());
		    try {
		        if(vo.getFiledata() != null && vo.getFiledata().getOriginalFilename() != null && !vo.getFiledata().getOriginalFilename().equals("")){
		            //파일이 존재하면
		            String original_name = vo.getFiledata().getOriginalFilename();
		            String ext = original_name.substring(original_name.lastIndexOf(".")+1);
		            //파일 기본경로
		            String defaultPath = request.getSession().getServletContext().getRealPath("/");
		            //파일 기본경로 _ 상세경로
		            String path = defaultPath + "resources" + File.separator + "photo_upload" + File.separator;              
		            File filez = new File(path);
		            System.out.println("path:"+path);
		            //디렉토리 존재하지 않을경우 디렉토리 생성
		            if(!filez.exists()) {
		                filez.mkdirs();
		            }
		            //서버에 업로드 할 파일명(한글문제로 인해 원본파일은 올리지 않는것이 좋음)
		            String realname = UUID.randomUUID().toString() + "." + ext;
		        ///////////////// 서버에 파일쓰기 ///////////////// 
		            vo.getFiledata().transferTo(new File(path+realname));
		            file_result += "&bNewLine=true&sFileName="+original_name+"&sFileURL=/notice01/resources/photo_upload/"+realname;
		          /* file_result += "&bNewLine=true&sFileName="+original_name+"&sFileURL=resources/photo_upload/"+realname;*/
		            
		            logger.info("realname:" + realname);
		        } else {
		            file_result += "&errstr=error";
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return "redirect:" + callback + "?callback_func="+callback_func+file_result;
		}
		
		// 해당 번호 게시글 상세보기
		@RequestMapping(value="/seller_board_detail", method=RequestMethod.GET)
		public void seller_board_detail(int bd_bno, Model model, String s_id){
		 	logger.info("bd_bno = " + bd_bno);
		 	SellerVO sellerInfo = sellerService.readSellerInfo(s_id);
			
			model.addAttribute("sellerInfo", sellerInfo);
		 	EditorVO vo = sellerService.readBoard(bd_bno);
		 	model.addAttribute("board", vo);
		}


} // end class
