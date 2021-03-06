package com.kh.spring.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.actor.ActorDto;
import com.kh.spring.entity.actor.ActorPhotoDto;
import com.kh.spring.entity.actor.TotalRoleViewDto;
import com.kh.spring.entity.movie.MoviePhotoDto;
import com.kh.spring.repository.actor.ActorDao;
import com.kh.spring.repository.actor.ActorPhotoDao;
import com.kh.spring.repository.actor.TotalRoleViewDao;
import com.kh.spring.repository.movie.MoviePhotoDao;
import com.kh.spring.vo.MovieChartVO;
import com.kh.spring.vo.PaginationActorVO;

@Service
public class ActorServiceImpl implements ActorService{
	@Autowired
	private ActorDao actorDao;
	@Autowired
	private ActorPhotoDao actorPhotoDao;
	@Autowired
	private TotalRoleViewDao totalRoleViewDao;
	@Autowired
	private MoviePhotoDao moviePhotoDao;
	
	@Value("${config.rootpath.actor}")
	public String directory;
	
	@Override
	public PaginationActorVO serachPage(PaginationActorVO paginationActorVO) throws Exception {
		int count = actorDao.count(paginationActorVO.getActorJob(),paginationActorVO.getActorName());
		paginationActorVO.setCount(count);
		paginationActorVO.calculate();
		List<ActorDto> list = actorDao.search(paginationActorVO.getActorJob(),paginationActorVO.getActorName(),paginationActorVO.getBegin(),paginationActorVO.getEnd());
		paginationActorVO.setList(list);
		
		return paginationActorVO;
	}

	@Override
	public int insert(ActorDto actorDto, MultipartFile attach) throws IllegalStateException, IOException {
		int sequence = actorDao.getSequence();
		actorDto.setActorNo(sequence);
		
		actorDao.insert(actorDto);
		
		ActorPhotoDto actorPhotoDto = new ActorPhotoDto();
		actorPhotoDto.setActorNo(actorDto.getActorNo());
		actorPhotoDto.setActorPhotoUploadName(attach.getOriginalFilename());
		actorPhotoDto.setActorPhotoSize(attach.getSize());
		actorPhotoDto.setActorPhotoType(attach.getContentType());
		
		actorPhotoDao.save(actorPhotoDto,attach);
		
		return sequence;
	}

	@Override
	public void edit(ActorDto actorDto, MultipartFile attach) throws IllegalStateException, IOException {
		
		actorDao.update(actorDto);
		
		ActorPhotoDto findPhotoDto = actorPhotoDao.getByActor(actorDto.getActorNo());
		
		if(!attach.isEmpty()) {
			if(findPhotoDto != null) {
			File target = new File(directory,String.valueOf(findPhotoDto.getActorPhotoNo()));
			target.delete();
			findPhotoDto.setActorPhotoUploadName(attach.getOriginalFilename());
			findPhotoDto.setActorPhotoSize(attach.getSize());
			findPhotoDto.setActorPhotoType(attach.getContentType());
			actorPhotoDao.update(findPhotoDto,attach);
			}else {
				ActorPhotoDto actorPhotoDto = new ActorPhotoDto();
				actorPhotoDto.setActorNo(actorDto.getActorNo());
				actorPhotoDto.setActorPhotoUploadName(attach.getOriginalFilename());
				actorPhotoDto.setActorPhotoSize(attach.getSize());
				actorPhotoDto.setActorPhotoType(attach.getContentType());
				
				actorPhotoDao.save(actorPhotoDto,attach);
			}
		}
		
	}

	@Override
	public void delete(int actorNo) {
		ActorPhotoDto findPhotoDto = actorPhotoDao.getByActor(actorNo);
		
		if(findPhotoDto != null) {
			File target = new File(directory,String.valueOf(findPhotoDto.getActorPhotoNo()));
			target.delete();
			actorPhotoDao.delete(findPhotoDto.getActorPhotoNo());
			}
		
		actorDao.delete(actorNo);
	}

	@Override
	public List<MovieChartVO> getDetailVO(int actorNo) {
		List<MovieChartVO> movieList = new ArrayList<>();
		List<TotalRoleViewDto> listByActorNo =  totalRoleViewDao.listByActorNo(actorNo);
		for(TotalRoleViewDto totalRoleViewDto : listByActorNo) {
			List<MoviePhotoDto> photoList = moviePhotoDao.getList(totalRoleViewDto.getMovieNo()); 
			MoviePhotoDto moviePhotoDto = photoList.get(0);
			
			MovieChartVO movieChartVO = new MovieChartVO();
			movieChartVO.setMovieTitle(totalRoleViewDto.getMovieTitle());
			movieChartVO.setMovieOpening(totalRoleViewDto.getMovieOpening());
			movieChartVO.setMovieNo(totalRoleViewDto.getMovieNo());
			movieChartVO.setMoviePhotoNo(moviePhotoDto.getMoviePhotoNo());
			
			movieList.add(movieChartVO);
		}
		return movieList;
	}
	
}
