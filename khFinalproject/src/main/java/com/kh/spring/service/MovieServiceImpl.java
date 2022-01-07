package com.kh.spring.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.actor.TotalRoleViewDto;
import com.kh.spring.entity.movie.MovieDto;
import com.kh.spring.entity.movie.MovieLikeDto;
import com.kh.spring.entity.movie.MoviePhotoDto;
import com.kh.spring.repository.movie.MovieDao;
import com.kh.spring.repository.movie.MovieLikeDao;
import com.kh.spring.repository.movie.MoviePhotoDao;
import com.kh.spring.vo.MovieChartVO;
import com.kh.spring.vo.MyMovieLikeVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MovieServiceImpl implements MovieService{

	@Autowired
	private MovieDao movieDao;
	@Autowired
	private MoviePhotoDao moviePhotoDao;
	
	//저장용 폴더/
	@Value("${config.rootpath.movie}")
	public String directory;
		
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

	@Override
	public void edit(MovieDto movieDto, MultipartFile photo, List<MultipartFile> attach) throws IllegalStateException, IOException {
		log.debug("단일 파일 값확인1={}",photo);
		log.debug("멀티 파일 값확인1={}",attach);
		List<MoviePhotoDto> cutList = new ArrayList<>();
		
		boolean checkSingle = !photo.isEmpty();
		log.debug("단일 파일 트루?={}",checkSingle);
		
		//건아님이 요청하셔서전 오늘 코드를 하나도 짜지못했지만 흔쾌히 해드리는 코드
		List<MoviePhotoDto> list1 = moviePhotoDao.list(movieDto.getMovieNo());
		if(list1.isEmpty()) {
			//아무 사진도 등록되지 않았으면, 메인 포스터만 우선 먼저 등록하세요.
			MoviePhotoDto moviePhotoDto = new MoviePhotoDto();
			moviePhotoDto.setMovieNo(movieDto.getMovieNo());
			moviePhotoDto.setMoviePhotoUploadName(photo.getOriginalFilename());
			moviePhotoDto.setMoviePhotoSize(photo.getSize());
			moviePhotoDto.setMoviePhotoType(photo.getContentType());
			
			moviePhotoDao.insert(moviePhotoDto,photo);
			return;
		}
		
		
		
		if(checkSingle) {
			List<MoviePhotoDto> list = moviePhotoDao.list(movieDto.getMovieNo());
			MoviePhotoDto findDto = list.get(0);
			
			for(int i=1;i<list.size();i++) {
				cutList.add(list.get(i));
			}
			
			File target = new File(directory,String.valueOf(findDto.getMoviePhotoSaveName()));
			target.delete();

			
			MoviePhotoDto moviePhotoDto = new MoviePhotoDto();
			moviePhotoDto.setMovieNo(movieDto.getMovieNo());
			moviePhotoDto.setMoviePhotoUploadName(photo.getOriginalFilename());
			moviePhotoDto.setMoviePhotoSize(photo.getSize());
			moviePhotoDto.setMoviePhotoType(photo.getContentType());
			moviePhotoDto.setMoviePhotoNo(findDto.getMoviePhotoNo());
			moviePhotoDto.setMoviePhotoSaveName(String.valueOf(findDto.getMoviePhotoNo()));
			moviePhotoDao.update(moviePhotoDto,photo);
			
			
			boolean checkList = false;
			for(MultipartFile file : attach) {
				if(!file.isEmpty()) {
					checkList = true;
					break;
				}
			}
			log.debug("멀티 파일 트루?={}",checkList);
			//파일이 있다면 기존 파일을 삭제하고 새로운 파일을 추가해주어야 한다.
			if(checkList) {
				
				if(!cutList.isEmpty()) {
					//비어있지 않다면,
					for(MoviePhotoDto file : cutList) {
						//하나씩 꺼내서 삭제해준다.
						File target1 = new File(directory,String.valueOf(file.getMoviePhotoSaveName()));
						target1.delete();
						//파일 삭제시켜준다.
						moviePhotoDao.delete(file.getMoviePhotoNo());
					}
				}
				
				//새로운 파일이 들어온 것으로 수정해준다.
				for(MultipartFile file : attach) {
					if(!file.isEmpty()) {
						MoviePhotoDto moviePhotoDto1 = new MoviePhotoDto();
						moviePhotoDto1.setMovieNo(movieDto.getMovieNo());
						moviePhotoDto1.setMoviePhotoUploadName(file.getOriginalFilename());
						moviePhotoDto1.setMoviePhotoSize(file.getSize());
						moviePhotoDto1.setMoviePhotoType(file.getContentType());
						
						moviePhotoDao.insert(moviePhotoDto1,file);
					}
				}
			}
		}else {
			boolean checkList = false;
			for(MultipartFile file : attach) {
				if(!file.isEmpty()) {
					checkList = true;
					break;
				}
			}
			log.debug("멀티 파일 트루?={}",checkList);
			//파일이 있다면 기존 파일을 삭제하고 새로운 파일을 추가해주어야 한다.
			if(checkList) {
				List<MoviePhotoDto> list = moviePhotoDao.list(movieDto.getMovieNo());
				
				for(int i=1;i<list.size();i++) {
					cutList.add(list.get(i));
				}
				
				if(!cutList.isEmpty()) {
					//비어있지 않다면,
					for(MoviePhotoDto file : cutList) {
						//하나씩 꺼내서 삭제해준다.
						File target = new File(directory,String.valueOf(file.getMoviePhotoSaveName()));
						target.delete();
						//파일 삭제시켜준다.
						moviePhotoDao.delete(file.getMoviePhotoNo());
					}
				}
				
				//새로운 파일이 들어온 것으로 수정해준다.
				for(MultipartFile file : attach) {
					if(!file.isEmpty()) {
						MoviePhotoDto moviePhotoDto = new MoviePhotoDto();
						moviePhotoDto.setMovieNo(movieDto.getMovieNo());
						moviePhotoDto.setMoviePhotoUploadName(file.getOriginalFilename());
						moviePhotoDto.setMoviePhotoSize(file.getSize());
						moviePhotoDto.setMoviePhotoType(file.getContentType());
						
						moviePhotoDao.insert(moviePhotoDto,file);
					}
				}
			}
		}
		
	
		
		//게시판 내용 수정해준다.
		movieDao.edit(movieDto);
	}

	@Override
	public void delete(int movieNo) {
		
		List<MoviePhotoDto> list = moviePhotoDao.list(movieNo);
		
		
		if(!list.isEmpty()) {
			for(MoviePhotoDto moviePhotoDto : list) {
				
				File target = new File(directory,String.valueOf(moviePhotoDto.getMoviePhotoSaveName()));
				target.delete();
				//파일 삭제시켜준다.
				moviePhotoDao.delete(moviePhotoDto.getMoviePhotoNo());
			}
			
		}

		movieDao.delete(movieNo);
		
	}

	@Override
	public List<MyMovieLikeVO> listMyMovieLikeAndPhoto(int memberNo) {
		
		List<MovieDto> myMovieLikeList = movieDao.myMovieLikeList(memberNo); 
		List<MyMovieLikeVO> listMyMovieLikeAndPhoto = new ArrayList<MyMovieLikeVO>();
		
		for(MovieDto movieDto : myMovieLikeList) {
			
			MyMovieLikeVO myMovieLikeVO = new MyMovieLikeVO();
			myMovieLikeVO.setMoviePhotoNo(moviePhotoDao.getList(movieDto.getMovieNo()).get(0).getMoviePhotoNo());
			myMovieLikeVO.setMovieNo(movieDto.getMovieNo());
			myMovieLikeVO.setMovieTitle(movieDto.getMovieTitle());
			myMovieLikeVO.setMovieEngTitle(movieDto.getMovieEngTitle());
			myMovieLikeVO.setMovieGrade(movieDto.getMovieGrade());
			myMovieLikeVO.setMovieType(movieDto.getMovieType());
			myMovieLikeVO.setMovieCountry(movieDto.getMovieCountry());
			myMovieLikeVO.setMovieOpening(movieDto.getMovieOpening());
			myMovieLikeVO.setMovieRuntime(movieDto.getMovieRuntime());
			myMovieLikeVO.setMovieStarpoint(movieDto.getMovieStarpoint());
			myMovieLikeVO.setMovieContent(movieDto.getMovieContent());
			
			listMyMovieLikeAndPhoto.add(myMovieLikeVO);
		}
		return listMyMovieLikeAndPhoto;
	}

}
