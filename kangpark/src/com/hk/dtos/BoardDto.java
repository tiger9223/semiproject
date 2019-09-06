package com.hk.dtos;

import java.util.Date;

public class BoardDto {
	
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
	private String notice;
	private int member_seq;
	private int list_seq;
	private String kind;
	
	public BoardDto() {
		super();
	}

	public BoardDto(int seq, String id, String title, String content, int ref, int step, int depth, int readcount, String delflag,
			Date regdate, String notice, int member_seq, int list_seq, String kind) {
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
		this.list_seq = list_seq;
		this.kind = kind;
	}
	

	public BoardDto(String id, String title, String content) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
	}
	

	public BoardDto(int seq, String title, String content) {
		super();
		this.seq = seq;
		this.title = title;
		this.content = content;
	}
	
	public BoardDto(int seq, String id, String title, String content) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
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

	public String getNotice() {
		return notice;
	}

	public void setNotice(String notice) {
		this.notice = notice;
	}

	public int getMember_seq() {
		return member_seq;
	}

	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
	}

	public int getList_seq() {
		return list_seq;
	}

	public void setList_seq(int list_seq) {
		this.list_seq = list_seq;
	}

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

	@Override
	public String toString() {
		return "BoardDto [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", ref=" + ref
				+ ", step=" + step + ", depth=" + depth + ", readcount=" + readcount + ", delflag=" + delflag
				+ ", regdate=" + regdate + ", notice=" + notice + ", member_seq=" + member_seq + ", list_seq="
				+ list_seq + ", kind=" + kind + "]";
	}

	
}
