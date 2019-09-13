package com.hk.dtos;

import java.sql.Date;

public class PostDto {

	
	private int seq;
	private String id;
	private String title;
	private String content;
	private int ref;
	private int step;
	private int depth;
	private int readcount;
	private String delflag;
	private Date regdate;
	private int notice;
	private int member_seq;
	private int board_seq;
	private int category_seq;
	private String category_title;
	
	public PostDto() {
		super();
	}

	public PostDto(int seq, String title, String content) {
		super();
		this.seq = seq;
		this.title = title;
		this.content = content;
	}



	public PostDto(int seq, String id, String title, String content, int ref, int step, int depth, int readcount,
			String delflag, Date regdate, int notice, int member_seq, int board_seq, int category_seq) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.ref = ref;
		this.step = step;
		this.depth = depth;
		this.readcount = readcount;
		this.delflag = delflag;
		this.regdate = regdate;
		this.notice = notice;
		this.member_seq = member_seq;
		this.board_seq = board_seq;
		this.category_seq = category_seq;
	}

	public PostDto(String title, String content, int member_seq, int board_seq, int category_seq) {
		super();
		this.title = title;
		this.content = content;
		this.member_seq = member_seq;
		this.board_seq = board_seq;
		this.category_seq = category_seq;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public String getDelflag() {
		return delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public int getNotice() {
		return notice;
	}

	public void setNotice(int notice) {
		this.notice = notice;
	}

	public int getMember_seq() {
		return member_seq;
	}

	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
	}

	public int getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}

	public int getCategory_seq() {
		return category_seq;
	}

	public void setCategory_seq(int category_seq) {
		this.category_seq = category_seq;
	}

	public String getCategory_title() {
		return category_title;
	}

	public void setCategory_title(String category_title) {
		this.category_title = category_title;
	}

	@Override
	public String toString() {
		return "PostDto [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", ref=" + ref
				+ ", step=" + step + ", depth=" + depth + ", readcount=" + readcount + ", delflag=" + delflag
				+ ", regdate=" + regdate + ", notice=" + notice + ", member_seq=" + member_seq + ", board_seq="
				+ board_seq + ", category_seq=" + category_seq + ", categoryTitle=" + category_title + "]";
	}


	
	
}
