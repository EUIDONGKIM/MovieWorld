package com.kh.spring.repository.movie;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.movie.MoviePhotoDto;

public interface MoviePhotoDao {

	int getPhotoSequence();
	
	//이미지 등록
	void insert(MoviePhotoDto moviePhotoDto, MultipartFile photo) throws IllegalStateException, IOException;
	
	List<MoviePhotoDto>getList(int movieNo);
	
}
