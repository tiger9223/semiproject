package com.hk.dtos;

public class BoardDto {

	private int seq;
	private String title;
	
	public BoardDto() {
		super();
	}
	

	public BoardDto(int seq) {
		super();
		this.seq = seq;
	}


	public BoardDto(String title) {
		super();
		this.title = title;
	}
	

	public BoardDto(int seq, String title) {
		super();
		this.seq = seq;
		this.title = title;
	}


	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Override
	public String toString() {
		return "BoardDto [seq=" + seq + ", title=" + title + "]";
	}
	
	
}
