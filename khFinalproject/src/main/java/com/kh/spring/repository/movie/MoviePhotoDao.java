package com.kh.spring.repository.movie;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.movie.MoviePhotoDto;

public interface MoviePhotoDao {

	int getPhotoSequence();

	void insert(MoviePhotoDto moviePhotoDto, MultipartFile photo) throws IllegalStateException, IOException;

}
