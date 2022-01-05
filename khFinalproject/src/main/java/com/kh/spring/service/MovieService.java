package com.kh.spring.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.movie.MovieDto;

public interface MovieService {

	int insert(MovieDto movieDto, MultipartFile photo, List<MultipartFile> attach) throws IllegalStateException, IOException;

	void edit(MovieDto movieDto, MultipartFile photo, List<MultipartFile> attach) throws IllegalStateException, IOException;

	void delete(int movieNo);

}
