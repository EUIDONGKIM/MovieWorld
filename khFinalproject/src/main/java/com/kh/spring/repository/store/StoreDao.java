package com.kh.spring.repository.store;

import java.util.List;


import com.kh.spring.entity.store.StoreDto;
import com.kh.spring.entity.store.StorePhotoDto;

public interface StoreDao {
	void insert(StoreDto storeDto);
//	void insert (StorePhotoDto storePhotoDto,Multipart photo);
	boolean changeInformation(StoreDto storeDto);
	
	List<StoreDto> list();
	int count(String column, String keyword);

	List<StoreDto> search(String column, String keyword, int begin, int end);

	StoreDto get(int productNo);
	boolean delete(int productNo);
	
	//시퀀스 번호  미리 뽑기
	int getSeq();
}