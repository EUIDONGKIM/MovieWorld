package com.kh.spring.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.movie.MovieDto;
import com.kh.spring.entity.reservation.LastInfoViewDto;
import com.kh.spring.entity.schedule.TotalInfoViewDto;
import com.kh.spring.vo.MovieChartVO;
import com.kh.spring.vo.MyMovieLikeVO;

public interface MovieService {

	int insert(MovieDto movieDto, MultipartFile photo, List<MultipartFile> attach) throws IllegalStateException, IOException;

	void edit(MovieDto movieDto, MultipartFile photo, List<MultipartFile> attach) throws IllegalStateException, IOException;

	void delete(int movieNo);
	
	//내가 좋아요한 영화 목록
	List<MyMovieLikeVO> myMovieLikeList(int memberNo, int startRow, int endRow);

	Map<MovieDto, List<Map<TotalInfoViewDto, List<LastInfoViewDto>>>> getMovieList(String movieTitle, String movieTotal,
			String scheduleStart, String scheduleEnd);

	List<MovieChartVO> getChartList(List<Integer> movieNoList, int order);

}
