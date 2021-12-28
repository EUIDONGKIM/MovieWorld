package com.kh.spring.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.MovieDto;
import com.kh.spring.entity.MoviePhotoDto;
import com.kh.spring.repository.MovieDao;
import com.kh.spring.repository.MoviePhotoDao;

@Service
public class MovieServiceImpl implements MovieService{

	@Autowired
	private MovieDao movieDao;
	@Autowired
	private MoviePhotoDao moviePhotoDao;
	//저장용 폴더/
	private File directory = new File("C:\\Users\\USER\\upload\\movie");
		
	@Override
	public int insert(MovieDto movieDto, MultipartFile photo, List<MultipartFile> attach) throws IllegalStateException, IOException {

		int sequence = movieDao.getSequence();
		movieDto.setMovieNo(sequence);
		
		movieDao.insert(movieDto);
		
		MoviePhotoDto moviePhotoDto = new MoviePhotoDto();
		moviePhotoDto.setMovieNo(movieDto.getMovieNo());
		moviePhotoDto.setMoviePhotoUploadName(photo.getOriginalFilename());
		moviePhotoDto.setMoviePhotoType(photo.getContentType());
		moviePhotoDto.setMoviePhotoSize(photo.getSize());
		
		moviePhotoDao.insert(moviePhotoDto,photo);//프로필
		
		for(MultipartFile file : attach) {
			if(!file.isEmpty()) {
				MoviePhotoDto photoDto = new MoviePhotoDto();
				photoDto.setMovieNo(movieDto.getMovieNo());
				photoDto.setMoviePhotoUploadName(file.getOriginalFilename());
				photoDto.setMoviePhotoType(file.getContentType());
				photoDto.setMoviePhotoSize(file.getSize());
				
				moviePhotoDao.insert(photoDto,file);//스틸컷	
			}
		}
		return sequence;
	}

}
