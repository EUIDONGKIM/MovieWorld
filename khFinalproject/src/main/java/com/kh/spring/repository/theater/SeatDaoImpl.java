package com.kh.spring.repository.theater;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.theater.SeatDto;

@Repository
public class SeatDaoImpl implements SeatDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(SeatDto seatDto) {
		sqlSession.insert("seat.insert",seatDto);
	}

	@Override
	public List<SeatDto> list(int hallNo) {
		return sqlSession.selectList("seat.list",hallNo);
	}

	@Override
	public int getSeatNo(int hallNo, int seatRows, int seatCols) {
		Map<String,Object> param = new HashMap<>();
		param.put("hallNo",hallNo);
		param.put("seatRows",seatRows);
		param.put("seatCols",seatCols);
		
		return sqlSession.selectOne("seat.getSeatNo",param);
	}

	@Override
	public void delete(int hallNo) {
		sqlSession.delete("seat.delete",hallNo);
	}

}
