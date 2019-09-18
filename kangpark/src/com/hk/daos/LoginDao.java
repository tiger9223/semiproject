package com.hk.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hk.config.SqlMapConfig;
import com.hk.dtos.LoginDto;

import jdk.nashorn.internal.ir.SetSplitState;

public class LoginDao extends SqlMapConfig{
	
	private String nameSpace = "com.hk.login.";
	
	public LoginDao() {
		super();
	}
	
	//사용자 기능
	//1. 회원가입 기능 구현 
	public boolean insertUser(LoginDto dto) {
		int count = 0;
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);//autocommit->true
			count = sqlSession.insert(nameSpace+"insertUser" , dto);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return count > 0 ? true:false;
	}
	
	public boolean insertAdmin(LoginDto dto) {
		int count = 0;
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);//autocommit->true
			count = sqlSession.insert(nameSpace+"insertAdmin" , dto);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return count > 0 ? true:false;
	}
	
	//2. 로그인 기능 구현 --> id와 password를 입력받아서 두개의 값을 만족하는 조건을 확인해서 결과가 있으면 로그인 실행
	public LoginDto getLogin(String id, String password) {
		LoginDto dto = new LoginDto(id,password);
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			dto = sqlSession.selectOne(nameSpace+"getLogin", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	//3. 나의 정보 조회 기능 구현 (seq,id,name,address,phone,email,regdate)
	public LoginDto getUserInfo(int seq) {
		LoginDto dto = new LoginDto();
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			dto = sqlSession.selectOne(nameSpace+"getUserInfo", seq);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return dto;
	}
	
	//4. 나의 정보 수정 기능 구현 (address, phone, email 수정)
	public boolean userUpdate(LoginDto dto) {
		int count = 0;
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.update(nameSpace+"userUpdate", dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count>0 ? true : false;
	}
	//5. 회원 탈퇴 기능 구현 (enabled를 'N'으로 수정 --> getLogin(): 로그인시 쿼리 수정해야 됨)
	public boolean withdraw(String id) {
		int count = 0;
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.update(nameSpace+"withdraw", id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count>0 ? true : false;
	}
	//5. 회원 복원 기능 구현 (enabled를 'Y'으로 수정 --> getLogin(): 로그인시 쿼리 수정해야 됨)
	public boolean restore(String id) {
		int count = 0;
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.update(nameSpace+"restore", id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		
		return count>0 ? true : false;
	}
	//6. 아이디 중복 체크 기능 구현
	public LoginDto idChk(String id) {
		LoginDto dto = new LoginDto();
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			dto = sqlSession.selectOne(nameSpace+"idChk", id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		return dto;
	}
	
	
	//관리자 기능
	//1. 전체 회원 조회(탈퇴에 대한 상태 여부까지 모두 조회)
	public List<LoginDto> getAllUserStatus() {
		List<LoginDto> list = new ArrayList<>();
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			list = sqlSession.selectList(nameSpace+"getAllUserStatus");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		return list;
	}
	
	//2.사용자 전체 회원 조회(사용중인 회원에 대한 조회)
		public List<LoginDto> getAllUserList(){
			List<LoginDto> list=new ArrayList<>();
			SqlSession sqlSession = null;
			
			try {
				sqlSession = getSqlSessionFactory().openSession(true);
				list = sqlSession.selectList(nameSpace+"getAllUserList");
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				sqlSession.close();
			}
			return list;
		}
		
	//3.사용자 상세 조회 
	public LoginDto getUser(int seq){
		LoginDto dto=new LoginDto();
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			dto = sqlSession.selectOne(nameSpace+"getUser", seq);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		return dto;
	}
	
	//4. 사용자 등급 변경 기능 조회
	public boolean updateUserRole(int seq, String role) {
		int count = 0;
		LoginDto dto = new LoginDto(seq, null, role);
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.update(nameSpace+"updateUserRole",dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
		return count>0?true:false;
	}
	
}
