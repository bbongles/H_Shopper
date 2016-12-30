package com.online.shop.domain;

import java.util.Date;

public class EditorVO {
	
	private String bd_title; // 게시판 제목
	private String editor; // tag와 함께 저장될 content
	private int bd_bno; // 게시글 번호
	private String s_id; // 판매자 아이디
	private String bid; // 구매자 아이디
	private Date bd_reg; // 작성 시간
	
	public EditorVO() {}

	public String getBd_title() {
		return bd_title;
	}

	public void setBd_title(String bd_title) {
		this.bd_title = bd_title;
	}

	public String getEditor() {
		return editor;
	}

	public void setEditor(String value) {
		this.editor = value;
	}

	public int getBd_bno() {
		return bd_bno;
	}

	public void setBd_bno(int bd_bno) {
		this.bd_bno = bd_bno;
	}

	public String getS_id() {
		return s_id;
	}

	public void setS_id(String s_id) {
		this.s_id = s_id;
	}

	public String getBid() {
		return bid;
	}

	public void setBid(String bid) {
		this.bid = bid;
	}

	public Date getBd_reg() {
		return bd_reg;
	}

	public void setBd_reg(Date bd_reg) {
		this.bd_reg = bd_reg;
	}
	
	
	
	
	
	

}
