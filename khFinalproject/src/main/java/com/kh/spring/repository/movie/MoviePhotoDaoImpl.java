package com.kh.spring.repository.movie;

import java.io.File;
import java.io.IOException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.movie.MoviePhotoDto;

@Repository
public class MoviePhotoDaoImpl implements MoviePhotoDao{
	
	@Autowired
	private SqlSession sqlSession;
	//저장용 폴더
	@Value("${config.rootpath}")
	public String directory;
	
	@Override
	public int getPhotoSequence() {
		return sqlSession.selectOne("moviePhoto.getPhotoSequence");
	}

	@Override
	public void insert(MoviePhotoDto moviePhotoDto, MultipartFile photo) throws IllegalStateException, IOException {
		int sequencePhoto = getPhotoSequence();
		
		File target = new File(directory,String.valueOf(sequencePhoto));
		photo.transferTo(target);
		
		moviePhotoDto.setMoviePhotoNo(sequencePhoto);
		moviePhotoDto.setMoviePhotoSaveName(String.valueOf(sequencePhoto));
		sqlSession.insert("moviePhoto.insert",moviePhotoDto);
	}

}
