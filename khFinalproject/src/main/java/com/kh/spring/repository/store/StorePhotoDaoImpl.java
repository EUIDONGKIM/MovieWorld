package com.kh.spring.repository.store;

import java.io.File;
import java.io.IOException;

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
	@Value("${config.rootpath.store}")
	public String directory;

	@Override
	public int getPhotoSequence() {
		return sqlSession.selectOne("storePhoto.getPhotoSequence");
	}

	@Override
	public void insert(StorePhotoDto storePhotoDto, MultipartFile file) throws IllegalStateException, IOException {
		int sequencePhoto = getPhotoSequence();
		
		System.out.println("storePhotoDao 1");
		File target = new File(directory,String.valueOf(sequencePhoto));
		file.transferTo(target);
		
		storePhotoDto.setProductPhotoNo(sequencePhoto);

		storePhotoDto.setProductPhotoSaveName(String.valueOf(sequencePhoto));

		sqlSession.insert("storePhoto.insert",storePhotoDto);
		
	}

}
