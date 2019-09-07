package com.hk.dtos;

public class BoardListDto {
	private int seq;
	private String list;
	
	public BoardListDto() {
		super();
	}

	public BoardListDto(int seq, String list) {
		super();
		this.seq = seq;
		this.list = list;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getList() {
		return list;
	}

	public void setList(String list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "BoardListDto [seq=" + seq + ", list=" + list + "]";
	}
	
	
}
