package com.kh.spring.repository.theater;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.theater.TheaterDto;
import com.kh.spring.vo.TheaterCityVO;

import lombok.extern.slf4j.Slf4j;

@Repository
public class TheaterDaoImpl implements TheaterDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<TheaterDto> listByCity(String city) {
		return sqlSession.selectList("theater.listByCity",city);
	}

	@Override
	public List<TheaterDto> list() {
		return sqlSession.selectList("theater.list");
	}

	//극장 생성
	@Override
	public void create(TheaterDto theaterDto) {
		int theaterNo = sqlSession.selectOne("theater.seq");
		theaterDto.setTheaterNo(theaterNo);
		sqlSession.insert("theater.create",theaterDto);
	}

	@Override
	public List<TheaterCityVO> cityList() {
		return sqlSession.selectList("theater.city");
	}

	@Override
	public List<TheaterDto> listByCity2(String city) {
		return sqlSession.selectList("theater.listByCity2",city);
	}

	@Override
	public TheaterDto get(int theaterNo) {
		return sqlSession.selectOne("theater.get", theaterNo);
	}

	@Override
	public boolean delete(int theaterNo) {
		
		return sqlSession.delete("theater.delete",theaterNo) > 0;
	}

	@Override
	public boolean edit(TheaterDto theaterDto) {
		return sqlSession.update("theater.edit",theaterDto) > 0;
	}

}