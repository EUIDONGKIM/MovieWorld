package com.kh.spring.repository.store;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.store.StorePhotoDto;

@Repository
public class StorePhotoDaoImpl implements StorePhotoDao{
	
	@Autowired
	private SqlSession sqlSession;
	//저장용 폴더
	private File directory = new File("C:/Users/RENEWCOM/upload");

	@Override
	public int getPhotoSequence() {
		return sqlSession.selectOne("storePhoto.getPhotoSequence");
	}

	@Override
	public void insert(StorePhotoDto storePhotoDto, MultipartFile file) throws IllegalStateException, IOException {
		int sequencePhoto = getPhotoSequence();
	
		File target = new File(directory,String.valueOf(sequencePhoto));
		
		file.transferTo(target);
		
		storePhotoDto.setProductPhotoNo(sequencePhoto);

		storePhotoDto.setProductPhotoSaveName(String.valueOf(sequencePhoto));

		sqlSession.insert("storePhoto.insert",storePhotoDto);
		
	}

	@Override
	public StorePhotoDto get(int productPhotoNo) {
	
		return sqlSession.selectOne("productPhoto.get",productPhotoNo);
	}

	@Override
	public byte[] load(int productPhotoNo) throws IOException {
		File target = new File(directory,String.valueOf(productPhotoNo));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
	}

	@Override
	public StorePhotoDto get(String productNo) {
		
		return sqlSession.selectOne("storePhoto.getByNo",productNo);
	}

}
