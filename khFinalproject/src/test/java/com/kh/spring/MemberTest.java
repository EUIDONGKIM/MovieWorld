package com.kh.spring;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.spring.repository.member.MemberDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
public class MemberTest {
	  @Autowired
	  MemberDao memberDao;
	  
	  @Autowired
	  SqlSession sqlSession;
	  
	  @Test
	  public void test01() {
		  log.debug("리스트={}",sqlSession.selectOne("member.getPoint","khmaster@kh.com").toString());
	  }
}
