package com.kh.spring.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.store.StoreDto;
import com.kh.spring.vo.StoreSearchVO;

public interface StoreService {
	StoreSearchVO searchNPaging(StoreSearchVO storeSearchVO) throws Exception;

	int write(StoreDto storeDto, List<MultipartFile> attach) throws IllegalStateException, IOException;

	void delete(int boardNo);

	void edit(StoreDto storeDto, List<MultipartFile> attach) throws IllegalStateException, IOException;
}

