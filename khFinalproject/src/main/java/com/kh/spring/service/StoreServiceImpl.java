package com.kh.spring.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.store.StoreDto;
import com.kh.spring.entity.store.StorePhotoDto;
import com.kh.spring.repository.store.StoreDao;
import com.kh.spring.repository.store.StorePhotoDao;
import com.kh.spring.vo.StoreSearchVO;

import lombok.extern.slf4j.Slf4j;

@Service
public class StoreServiceImpl implements StoreService{
	@Autowired
	private StoreDao storeDao;
	@Autowired
	private StorePhotoDao storePhotoDao;
	
	@Override	
	public StoreSearchVO searchNPaging(StoreSearchVO storeSearchVO) throws Exception {
		int count = storeDao.count(storeSearchVO.getColumn(),storeSearchVO.getKeyword());
		storeSearchVO.setCount(count);
		storeSearchVO.calculate();
		List<StoreDto> list = storeDao.search(storeSearchVO.getColumn(), storeSearchVO.getKeyword(),storeSearchVO.getBegin(),storeSearchVO.getEnd());
		storeSearchVO.setList(list);
		return storeSearchVO;
	}


	@Override
	public void delete(int productNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void edit(StoreDto storeDto, List<MultipartFile> attach) throws IllegalStateException, IOException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int insert(StoreDto storeDto, MultipartFile photo) throws IllegalStateException, IOException {
		int seq = storeDao.getSeq();
		storeDto.setProductNo(seq);
		
		storeDao.insert(storeDto);
		
		StorePhotoDto storePhotoDto = new StorePhotoDto();
		storePhotoDto.setProductNo(storeDto.getProductNo());
		storePhotoDto.setProductPhotoUploadName(photo.getOriginalFilename());
		storePhotoDto.setProductPhotoType(photo.getContentType());
		storePhotoDto.setProductPhotoSize(photo.getSize());
		
		storePhotoDao.insert(storePhotoDto, photo);
		
		return seq;
	}


}
