package com.kh.spring.repository.store;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.store.StoreFileDto;

public interface StoreFileDao {
	void save(StoreFileDto storeFileDto, MultipartFile file) throws IllegalStateException, IOException;

	List<StoreFileDto> list(int productNo);

	StoreFileDto get(int productPhotoNo);

	byte[] load(int productPhotoNo) throws IOException;

	void delete(int productPhotoNo);
}
