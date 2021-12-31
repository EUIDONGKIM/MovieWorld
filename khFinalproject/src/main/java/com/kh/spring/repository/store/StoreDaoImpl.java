package com.kh.spring.repository.store;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.kh.spring.entity.store.StoreDto;

@Repository
public class StoreDaoImpl implements StoreDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(StoreDto storeDto) {
		System.out.println("1");
		sqlSession.insert("store.insert",storeDto);
		System.out.println("2");
	}

	@Override
	public boolean changeInformation(StoreDto storeDto) {
		int count = sqlSession.update("product.changeInformation", storeDto);
		return count > 0;
	}

	@Override
	public List<StoreDto> list() {
		List<StoreDto> list = sqlSession.selectList("store.list");
		return list;
	}

	


}
