package com.kh.spring.repository.store;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.store.StorePhotoDto;


public interface StorePhotoDao {
	int getPhotoSequence();

	void insert(StorePhotoDto storePhotoDto, MultipartFile photo) throws IllegalStateException, IOException;
}
