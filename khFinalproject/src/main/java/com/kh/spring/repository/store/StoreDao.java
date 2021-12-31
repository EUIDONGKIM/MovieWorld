package com.kh.spring.repository.store;

import java.util.List;

import com.kh.spring.entity.store.StoreDto;

public interface StoreDao {
	void insert(StoreDto storeDto);
	
	boolean changeInformation(StoreDto storeDto);

	List<StoreDto> list();
	
}
