package com.kh.spring.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.store.StoreDto;
import com.kh.spring.vo.StoreSearchVO;

public interface StoreService {
	StoreSearchVO searchNPaging(StoreSearchVO storeSearchVO) throws Exception;

	void delete(int productNo);

	void edit(StoreDto storeDto, List<MultipartFile> attach) throws IllegalStateException, IOException;

	int insert(StoreDto storeDto, MultipartFile photo) throws IllegalStateException, IOException;
}
