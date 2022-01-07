package com.kh.spring.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.movie.MovieDto;
import com.kh.spring.vo.MyMovieLikeVO;

public interface MovieService {

	int insert(MovieDto movieDto, MultipartFile photo, List<MultipartFile> attach) throws IllegalStateException, IOException;

	void edit(MovieDto movieDto, MultipartFile photo, List<MultipartFile> attach) throws IllegalStateException, IOException;

	void delete(int movieNo);
	
	//내가 좋아요한 영화 목록
	List<MyMovieLikeVO> listMyMovieLikeAndPhoto(int memberNo);

}
