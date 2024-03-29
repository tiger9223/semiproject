package com.hk.daos;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.hk.config.SqlMapConfig;
import com.hk.dtos.PostDto;

public class PostDao extends SqlMapConfig{

	public PostDao() {
		super();
	}
	
	private String nameSpace="com.hk.post.";
	
	//전체 게시글 조회(list를 반환)
		public List<PostDto> getPostList(){
			List<PostDto> list=new ArrayList<>();
			SqlSession sqlSession=null;
			try {
				sqlSession = getSqlSessionFactory().openSession(true);
				list=sqlSession.selectList(nameSpace+"PostList");
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			return list;
		}
		
		//특정 게시판의 게시글 리스트 조회
		public List<PostDto> getPostByBoardSeq(int boardSeq){
			List<PostDto> list=new ArrayList<>();
			SqlSession sqlSession=null;
			try {
				sqlSession = getSqlSessionFactory().openSession(true);
				list=sqlSession.selectList(nameSpace+"PostlistByBoardSeq", boardSeq);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			return list;
		}

		//새글추가(id,title,content값 전달받음)
		public boolean insertPost(PostDto dto) {
			int count=0;
			SqlSession sqlSession=null;
			try {
				//         <--SqlSessionFactory객체에서 sqlSession객체를 구함
				sqlSession=getSqlSessionFactory().openSession(true);
				count=sqlSession.insert(nameSpace+"insertPost", dto);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			return count>0?true:false;
		}
		
		//공지글 추가
		public boolean insertNotice(PostDto dto) {
			int count=0;
			SqlSession sqlSession=null;
			try {
				//         <--SqlSessionFactory객체에서 sqlSession객체를 구함
				sqlSession=getSqlSessionFactory().openSession(true);
				count=sqlSession.insert(nameSpace+"insertNotice", dto);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			return count>0?true:false;
		}
		
		public PostDto getPostDetail(int PostSeq) {
			PostDto dto=new PostDto();
			SqlSession sqlSession=null;
			try {
				sqlSession=getSqlSessionFactory().openSession(true);
				dto=sqlSession.selectOne(nameSpace+"getCategoryTitle", PostSeq);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			return dto;
		
		}
		
		//글상세보기(AnsDto반환)
		public PostDto getPost(int MemberSeq,int PostSeq){
			PostDto dto=new PostDto();
			SqlSession sqlSession=null;
			Map<String, Integer> map=new HashMap<>();
			map.put("MemberSeq", MemberSeq);
			map.put("PostSeq", PostSeq);
			try {
				sqlSession=getSqlSessionFactory().openSession(true);
				dto=sqlSession.selectOne(nameSpace+"getPost", map);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			return dto;
		}
		//글수정하기(seq,title,content값 전달받음)
		public boolean updatePost(PostDto dto) {
			int count=0;
			SqlSession sqlSession=null;
			try {
				sqlSession=getSqlSessionFactory().openSession(true);
				count=sqlSession.update(nameSpace+"updatePost", dto);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			return count>0?true:false;
		}
		//글삭제하기(seq,여러글/글하나 삭제기능 같이사용)
		public boolean mulDel(String[] seqs) {

			int count=0;
			Map<String, String[]>map=new HashMap<>();
			map.put("seqs", seqs);
			SqlSession sqlSession=null;
			try {
				sqlSession=getSqlSessionFactory().openSession(true);
				count=sqlSession.update(nameSpace+"mulDel", map);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			
			return count>0?true:false;
		}
		//글삭제하기(seq)
		public boolean deletePost(int postSeq) {

			int count=0;
			SqlSession sqlSession=null;
			try {
				sqlSession=getSqlSessionFactory().openSession(true);
				count=sqlSession.update(nameSpace+"DeletePost", postSeq);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			
			return count>0?true:false;
		}
		//조회수(seq)
		public boolean readCount(int seq) {
			int count=0;
			SqlSession sqlSession=null;
			try {
				sqlSession=getSqlSessionFactory().openSession(true);
				count=sqlSession.update(nameSpace+"readcount", seq);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			return count>0?true:false;
		}
		//답글달기(id,title,content,부모의 seq)
		public boolean replyPost(PostDto dto) {
			int count=0;
			SqlSession sqlSession=null;
			try {                                         //transaction처리
				sqlSession=getSqlSessionFactory().openSession(false);//autocommit=false
				sqlSession.update(nameSpace+"replyupdate", dto);//update작업
				count=sqlSession.insert(nameSpace+"replyinsert", dto);//insert작업
				sqlSession.commit();//transaction처리
			} catch (Exception e) {
				sqlSession.rollback();//transaction처리
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			return count>0?true:false;
		}
	
	
	
	public PostDto getContent(int seq) {
		PostDto dto=new PostDto();
		SqlSession sqlSession=null;
		try {
			sqlSession=getSqlSessionFactory().openSession(true);
			dto=sqlSession.selectOne(nameSpace+"contentAjax", seq);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return dto;
	}
}
