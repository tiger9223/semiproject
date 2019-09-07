package com.hk.daos;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hk.config.SqlMapConfig;
import com.hk.dtos.BoardDto;
import com.hk.dtos.BoardDto;

public class BoardDao  extends SqlMapConfig{

	public BoardDao() {
		super();
	}
	
	private String nameSpace="com.hk.boardlist.";
	
	//게시판 종류 가져오기
	public List<BoardDto> getBoardList(){
		List<BoardDto> list=new ArrayList<>();
		SqlSession sqlSession=null;
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			list=sqlSession.selectList(nameSpace+"boardlist");
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return list;
	}
	
	//한개의 게시판 가져오기
	public BoardDto getBoardListBySeq(int seq){
		BoardDto board= new BoardDto();
		SqlSession sqlSession=null;
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			board=sqlSession.selectOne(nameSpace+"boardlistbyseq", seq);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return board;
	}
	
	//게시판 추가하기
	public boolean insertBoardList(BoardDto dto) {
		int count=0;
		SqlSession sqlSession=null;
		try {
			
			sqlSession=getSqlSessionFactory().openSession(true);
			count=sqlSession.insert(nameSpace+"insertboardlist", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return count>0?true:false;
	}
	//게시판 수정하기
	public boolean updateBoardList(BoardDto dto) {
		int count=0;
		SqlSession sqlSession=null;
		try {
			sqlSession=getSqlSessionFactory().openSession(true);
			count=sqlSession.update(nameSpace+"updateboardlist", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return count>0?true:false;
	}
	//게시판 삭제하기
	public boolean deleteBoardList(BoardDto dto) {
		int count=0;
		SqlSession sqlSession=null;
		try {
			sqlSession=getSqlSessionFactory().openSession(true);
			count=sqlSession.delete(nameSpace+"deleteboardlist", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return count>0?true:false;
	}
}
