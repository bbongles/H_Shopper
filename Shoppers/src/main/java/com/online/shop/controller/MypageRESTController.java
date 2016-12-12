package com.online.shop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.online.shop.domain.CartandBuy;
import com.online.shop.pageutil.PageCriteria;
import com.online.shop.pageutil.PageMaker;
import com.online.shop.service.BuyerService;

@RestController
@RequestMapping(value="/userid")
public class MypageRESTController { 
	private static final Logger logger = LoggerFactory.getLogger(MypageRESTController.class);
	
	@Autowired
	private BuyerService buyerservice;
	
	@RequestMapping(value="all/{id}", method=RequestMethod.GET)
	public ResponseEntity<List<CartandBuy>> readBuy(@PathVariable("id") String b_id){
		logger.info("b_id = " + b_id);
		List<CartandBuy> list = buyerservice.readM(b_id);
		logger.info("List.count : " + list.get(0).getCount());
		
		ResponseEntity<List<CartandBuy>> entity = null;
		if (list != null){
			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} 
		return entity;
	} 
	
	@RequestMapping(value="all2/{id}", method=RequestMethod.GET)
	public ResponseEntity<List<CartandBuy>> completeBuy(@PathVariable("id") String b_id){
		logger.info("b_id = " + b_id);
		List<CartandBuy> list = buyerservice.complete(b_id);
		logger.info("List.count : " + list.get(0).getCount());
		
		ResponseEntity<List<CartandBuy>> entity = null;
		if (list != null){
			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} 
		return entity;
	} 
	
	@RequestMapping(value="all3/{id}", method=RequestMethod.GET)
	public ResponseEntity<List<CartandBuy>>  readordermain(@PathVariable("id") String b_id){
		logger.info("b_id = " + b_id);
		List<CartandBuy> list = buyerservice.readmain(b_id);
		logger.info("List.name : " + list.get(0).getB_name());
		
		ResponseEntity<List<CartandBuy>> entity = null;
		if (list != null){
			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} 
		return entity;
	}
	
	@RequestMapping(value="all4/{id}", method=RequestMethod.GET)
	public ResponseEntity<List<CartandBuy>>  readCompletemain(@PathVariable("id") String b_id){
		logger.info("b_id = " + b_id);
		List<CartandBuy> list = buyerservice.readCompleteMain(b_id);
		logger.info("List.name : " + list.get(0).getB_name());
		
		ResponseEntity<List<CartandBuy>> entity = null;
		if (list != null){
			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} 
		return entity;
	}
	
	@RequestMapping(value="all5/{id}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>>  readOrderMain(@PathVariable("id") String b_id, Integer page){
		logger.info("b_id = " + b_id);
		logger.info("page : " + page);
		
		PageCriteria c = new PageCriteria();
		if (page != null){
			c.setPage(page);
		}
		
		List<CartandBuy> list2 = buyerservice.readordermain(b_id);
		List<CartandBuy> list = buyerservice.readmainPage(c, b_id);
		logger.info("List.size : " + list2.size());
		
		
		PageMaker maker = new PageMaker();
		maker.setCrieria(c);
		maker.setTotalCount(list2.size());
		maker.setPageData();
		
		Map<String, Object> data = new HashMap<>();
		data.put("pageMaker", maker);
		data.put("list", list);
		
		ResponseEntity<Map<String, Object>> entity = new ResponseEntity<>(data, HttpStatus.OK);

		return entity;
	}
	
	@RequestMapping(value="all6/{id}", method=RequestMethod.GET)
	public ResponseEntity<List<CartandBuy>>  readCompleteMain2(@PathVariable("id") String b_id){
		logger.info("b_id = " + b_id);
		List<CartandBuy> list = buyerservice.readCompleteMain2(b_id);
		logger.info("List.name : " + list.get(0).getB_name());
		
		ResponseEntity<List<CartandBuy>> entity = null;
		if (list != null){
			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} 
		return entity;
	}
	
	
	
	
}
