package com.kh.spring.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.member.CertificationDto;

@Repository
public class CertificationImpl implements CertificationDao{
	@Autowired
	 private SqlSession sqlSession;

	@Override
	public void insert(CertificationDto certificationDto) {
//		//인증번호 발송 이력 조회 (프로그래밍 위주 방식)
//		CertificationDto findDto =sqlSession.selectOne("certification.get",certificationDto.getEmail());
//		if(findDto !=null) { //인증된 비밀번호가 발송된적이 있다면
//			sqlSession.update("certification.update",certificationDto);
//		}else {
//			sqlSession.insert("certification.insert",certificationDto);
//		}
//		
	    //Merge into 구문 호출
		sqlSession.insert("certification.allInOneInsert",certificationDto);
		
	}

	@Override
	public boolean check(CertificationDto certificationDto) {
		CertificationDto findDto =sqlSession.selectOne("certification.check",certificationDto);
		if(findDto !=null) { //인증 성공시
			sqlSession.delete("certification.delete",certificationDto.getMemberEmail());
			return true;
		}else { //인증실패시
			return false;
		}
	}

	@Override
	public void clean() {
		sqlSession.delete("certification.clean");	
	}

	
}
