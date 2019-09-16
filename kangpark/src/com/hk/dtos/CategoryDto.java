package com.hk.dtos;

public class CategoryDto {

	private int seq;
	private String title;
	private int board_seq;
	
	public CategoryDto() {
		super();
	}
	

	public CategoryDto(int seq) {
		super();
		this.seq = seq;
	}

	
	public CategoryDto(int seq, String title) {
		super();
		this.seq = seq;
		this.title = title;
	}


	public CategoryDto(int seq, String title, int board_seq) {
		super();
		this.seq = seq;
		this.title = title;
		this.board_seq = board_seq;
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

	public int getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}

	@Override
	public String toString() {
		return "CategoryDto [seq=" + seq + ", title=" + title + ", board_seq=" + board_seq + "]";
	}
	
	
}
