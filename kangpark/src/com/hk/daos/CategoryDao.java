package com.hk.daos;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hk.config.SqlMapConfig;
import com.hk.dtos.CategoryDto;

public class CategoryDao extends SqlMapConfig{

	public CategoryDao() {
		super();
	}

	private String nameSpace="com.hk.category.";
	
		//특정 게시판의 category 전체조회
		public List<CategoryDto> getCategoryList(int seq){
			List<CategoryDto> list=new ArrayList<>();
			SqlSession sqlSession=null;
			try {
				sqlSession = getSqlSessionFactory().openSession(true);
				list=sqlSession.selectList(nameSpace+"getCategory",seq);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			return list;
		}
		
		//categorytitle 조회
		public CategoryDto getCategoryTitleBySeq(int seq){
			CategoryDto dto = new CategoryDto();
			SqlSession sqlSession=null;
			try {
				sqlSession = getSqlSessionFactory().openSession(true);
				dto=sqlSession.selectOne(nameSpace+"categorytitleByseq", seq);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			return dto;
		}
		
		//categorytitle 조회
			public CategoryDto getCategoryBySeq(int seq){
				CategoryDto dto = new CategoryDto();
				SqlSession sqlSession=null;
				try {
					sqlSession = getSqlSessionFactory().openSession(true);
					dto=sqlSession.selectOne(nameSpace+"getCategory", seq);
				} catch (Exception e) {
					e.printStackTrace();
				}finally {
					sqlSession.close();
				}
				return dto;
			}
		
		//게시판의 게시글 유형 가져오기
		public List<CategoryDto> getCategoryByBoardSeq(int seq){
			List<CategoryDto> list=new ArrayList<>();
			SqlSession sqlSession=null;
			try {
				sqlSession = getSqlSessionFactory().openSession(true);
				list=sqlSession.selectList(nameSpace+"CategoryByBoardSeq", seq);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			return list;
		}
		public CategoryDto getCateByBoardSeq(int seq){
			CategoryDto dto = new CategoryDto();
			SqlSession sqlSession=null;
			try {
				sqlSession = getSqlSessionFactory().openSession(true);
				dto=sqlSession.selectOne(nameSpace+"CategoryByBoardSeq", seq);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			return dto;
		}
		
		//게시글 유형 추가하기
		public boolean insertCategory(CategoryDto dto) {
			int count=0;
			SqlSession sqlSession=null;
			try {
				
				sqlSession=getSqlSessionFactory().openSession(true);
				count=sqlSession.insert(nameSpace+"InsertCategory", dto);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			return count>0?true:false;
		}
		//게시글 유형 수정하기
		public boolean updateCategory(CategoryDto dto) {
			int count=0;
			SqlSession sqlSession=null;
			try {
				sqlSession=getSqlSessionFactory().openSession(true);
				count=sqlSession.update(nameSpace+"UpdateCategory", dto);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			return count>0?true:false;
		}
		//게시글 유형 삭제하기
		public boolean deleteCategory(CategoryDto dto) {
			int count=0;
			SqlSession sqlSession=null;
			try {
				sqlSession=getSqlSessionFactory().openSession(true);
				count=sqlSession.delete(nameSpace+"DeleteCategory", dto);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				sqlSession.close();
			}
			return count>0?true:false;
		}
	
}
