package com.kh.spring.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.actor.TotalRoleViewDto;
import com.kh.spring.entity.movie.MovieDto;
import com.kh.spring.entity.movie.MovieLikeDto;
import com.kh.spring.entity.movie.MoviePhotoDto;
import com.kh.spring.entity.movie.VideoDto;
import com.kh.spring.entity.reservation.LastInfoViewDto;
import com.kh.spring.entity.schedule.TotalInfoViewDto;
import com.kh.spring.repository.actor.ActorDao;
import com.kh.spring.repository.actor.TotalRoleViewDao;
import com.kh.spring.repository.movie.MovieDao;
import com.kh.spring.repository.movie.MovieLikeDao;
import com.kh.spring.repository.movie.MoviePhotoDao;
import com.kh.spring.repository.movie.VideoDao;
import com.kh.spring.repository.reservation.LastInfoViewDao;
import com.kh.spring.repository.reservation.StatisticsInfoViewDao;
import com.kh.spring.repository.schedule.TotalInfoViewDao;
import com.kh.spring.service.ActorService;
import com.kh.spring.service.MovieService;
import com.kh.spring.vo.ChartVO;
import com.kh.spring.vo.MovieChartVO;
import com.kh.spring.vo.OrderByCount;
import com.kh.spring.vo.OrderByRatio;
import com.kh.spring.vo.OrderByStar;
import com.kh.spring.vo.PaginationActorVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/movie")
public class MovieController {
	
	@Autowired
	private MovieDao movieDao;
	@Autowired
	private MovieService movieService;
	@Autowired
	private ActorDao actorDao;
	@Autowired
	private TotalInfoViewDao totalInfoViewDao;
	@Autowired
	private LastInfoViewDao lastInfoViewDao;
	@Autowired
	private StatisticsInfoViewDao statisticsInfoViewDao;
	@Autowired
	private ActorService actorService;
	@Autowired
	private MoviePhotoDao moviePhotoDao;
	@Autowired
	private VideoDao videoDao;
	@Autowired
	private TotalRoleViewDao totalRoleViewDao;
	
	
	
	//좋아요
	@Autowired
	private MovieLikeDao movieLikeDao;
	
	
	@GetMapping("/insert")
	public String insert() {
		return "movie/insert";
	}
		
	@PostMapping("/insert")
	public String insert(
			@ModelAttribute MovieDto movieDto,
			@RequestParam MultipartFile photo,
			@RequestParam List<MultipartFile> attach
			) throws IllegalStateException, IOException {
		
		int sequence = movieService.insert(movieDto,photo,attach);
		
		return "redirect:/movie/insert_actor?movieNo="+sequence;
	}
	
	@GetMapping("/insert_actor")
	public String insertActor(Model model,@RequestParam int movieNo) {
		model.addAttribute("movieNo",movieNo);
		return "movie/insert_actor";
	}
	
	@GetMapping("/insert_popup")
	public String insertPopup(
			@RequestParam int movieNo,
			@ModelAttribute PaginationActorVO paginationActorVO,
			Model model) throws Exception {

		model.addAttribute("PaginationActorVO",actorService.serachPage(paginationActorVO));
		model.addAttribute("movieNo",movieNo);
		return "movie/insert_actor_popup";
	}
	
	@GetMapping("/list")
	public String list(
			Model model,
			@RequestParam(required = false) String movieTitle,
			@RequestParam(required = false) String movieTotal,
			@RequestParam(required = false) String scheduleStart,
			@RequestParam(required = false) String scheduleEnd
			) {//리스트를 찍으려면 뭔가가 필요합니다잉
		// 영화 => 개봉일 기준 검색 / 제목 검색
		
		// 상영 영화 검색 / 상영 중이지 않음 / 모두
		
		// 처음 => 상영 중인것만 보여준다.
		// 검색 시 상영 끝난것 위주로 보여준다 이력들 영화 검색.
		Map<MovieDto,List<Map<TotalInfoViewDto,List<LastInfoViewDto>>>> sendList = new TreeMap<>();
		List<MovieDto> movieList = new ArrayList<>();
		
		if(movieTitle != null) {
			movieList = movieDao.getTitleList(movieTitle);
			for(MovieDto movieDto : movieList) {
				List<Map<TotalInfoViewDto,List<LastInfoViewDto>>> movieValue = new ArrayList<>();
				
				List<TotalInfoViewDto> totalInfoList = totalInfoViewDao.list(movieDto.getMovieNo());
				
				for(TotalInfoViewDto totalInfoViewDto : totalInfoList) {
					Map<TotalInfoViewDto,List<LastInfoViewDto>> tempMap = new HashMap<>();
					List<LastInfoViewDto> list = lastInfoViewDao.listByScheduleNo(totalInfoViewDto.getScheduleNo());
					tempMap.put(totalInfoViewDto,list);
					
					movieValue.add(tempMap);
				}
				
				sendList.put(movieDto,movieValue);
			}
			model.addAttribute("movieTitle", movieTitle);
		}else if(movieTotal != null) {
			movieList = movieDao.listNotContent();
			for(MovieDto movieDto : movieList) {
				List<Map<TotalInfoViewDto,List<LastInfoViewDto>>> movieValue = new ArrayList<>();
				sendList.put(movieDto,movieValue);
				model.addAttribute("movieTitle", movieTitle);
			}
			model.addAttribute("movieTotal", movieTotal);
		}else if(scheduleStart != null && scheduleEnd != null) {
			List<Integer> movieNoList = totalInfoViewDao.moiveListByPeriod(scheduleStart,scheduleEnd);
			movieList = movieDao.nowList(movieNoList);
			for(MovieDto movieDto : movieList) {
				List<Map<TotalInfoViewDto,List<LastInfoViewDto>>> movieValue = new ArrayList<>();
				
				List<TotalInfoViewDto> totalInfoList = totalInfoViewDao.list(movieDto.getMovieNo());
				
				for(TotalInfoViewDto totalInfoViewDto : totalInfoList) {
					Map<TotalInfoViewDto,List<LastInfoViewDto>> tempMap = new HashMap<>();
					List<LastInfoViewDto> list = lastInfoViewDao.listByScheduleNo(totalInfoViewDto.getScheduleNo());
					tempMap.put(totalInfoViewDto,list);
					
					movieValue.add(tempMap);
				}
				
				sendList.put(movieDto,movieValue);
			}
			model.addAttribute("scheduleStart", scheduleStart);
			model.addAttribute("scheduleEnd", scheduleEnd);
		}
		else {			
			
			List<Integer> movieNoList = totalInfoViewDao.nowMoiveList();
			movieList = movieDao.nowList(movieNoList);
			for(MovieDto movieDto : movieList) {
				List<Map<TotalInfoViewDto,List<LastInfoViewDto>>> movieValue = new ArrayList<>();
				
				List<TotalInfoViewDto> totalInfoList = totalInfoViewDao.nowList(movieDto.getMovieNo());
				
				for(TotalInfoViewDto totalInfoViewDto : totalInfoList) {
					Map<TotalInfoViewDto,List<LastInfoViewDto>> tempMap = new HashMap<>();
					List<LastInfoViewDto> list = lastInfoViewDao.nowListByScheduleNo(totalInfoViewDto.getScheduleNo());
					tempMap.put(totalInfoViewDto,list);
					
					movieValue.add(tempMap);
				}
				
				sendList.put(movieDto,movieValue);
			}
			
		}
		
		
		model.addAttribute("sendList", sendList);
		return "movie/list";//잊지마세요 뷰.리.졸.버 - 김동율 뷰! 리졸버~
	}

	//무비차트
	@GetMapping("/movieChart")
	public String movieChart(Model model,
			@RequestParam(required = false,defaultValue = "0") int nowMovie,
			@RequestParam(required = false,defaultValue = "0") int order) {
		
		List<Integer> movieNoList = new ArrayList<>();
		if(nowMovie == 1) {
			movieNoList = totalInfoViewDao.nowMoiveList();
		}else {
			movieNoList = totalInfoViewDao.nowTMoiveListContainSoon();
		}
		List<MovieDto> movieList = movieDao.nowList(movieNoList);
		
		List<ChartVO> vo = new ArrayList<>();
		List<ChartVO> voForCount = new ArrayList<>();
		
		List<MovieChartVO> list = new ArrayList<>();
		
		int total = 0;
		
			vo = statisticsInfoViewDao.countForReservationRatio();
			for(ChartVO chartVO : vo) {
				total += chartVO.getCount();//총 예매 건수 합
			}
			
		if(order==2) {			
			voForCount = lastInfoViewDao.countByTotal();
		}

		
		for(MovieDto movieDto : movieList) {
			
			List<MoviePhotoDto> photoList = moviePhotoDao.getList(movieDto.getMovieNo()); 
			MoviePhotoDto moviePhotoDto = photoList.get(0);
			
			MovieChartVO movieChartVO = new MovieChartVO();
			movieChartVO.setMovieTitle(movieDto.getMovieTitle());
			movieChartVO.setMovieGrade(movieDto.getMovieGrade());
			movieChartVO.setMovieNo(movieDto.getMovieNo());
			movieChartVO.setMovieOpening(movieDto.getMovieOpening());
			movieChartVO.setMovieStarpoint(movieDto.getMovieStarpoint());
			movieChartVO.setMoviePhotoNo(moviePhotoDto.getMoviePhotoNo());
			
				
				for(ChartVO chartVO : vo) {
					if(movieDto.getMovieTitle().equals(chartVO.getText())) {
						float movieRatio = (float)chartVO.getCount() / (float)total * 100;
						String num = String.format("%.2f" , movieRatio);
						float changeToTwo = Float.parseFloat(num);
						movieChartVO.setMovieRatio(changeToTwo);
						break;
						
					}
				}
			
				if(order==2) {
				
				for(ChartVO chartVO : voForCount) {
					if(movieDto.getMovieTitle().equals(chartVO.getText())) {
						movieChartVO.setMovieCount(chartVO.getCount());
					}
				}
				
			}
			
			list.add(movieChartVO);
		}

		if(order==2) {
			Collections.sort(list,new OrderByCount());		
		}else if(order==1){
			Collections.sort(list,new OrderByStar());
		}else {
			Collections.sort(list,new OrderByRatio());
		}
		model.addAttribute("order",order);
		model.addAttribute("list",list);
		model.addAttribute("nowMovie",nowMovie);
		return "movie/movieChart";
	}
	
	@GetMapping("/movieDetail")
		public String movieDetail(@RequestParam int movieNo, Model model, HttpSession session) {
		
		ChartVO checkStatus = totalInfoViewDao.checkStatus(movieNo);
		MovieDto movieDto = movieDao.get(movieNo);
		List<TotalRoleViewDto> totalRoleViewList = totalRoleViewDao.listByMovieNo(movieNo);
		List<MoviePhotoDto> moviePhotoList = moviePhotoDao.getList(movieNo);
		List<VideoDto> videoList = videoDao.listByMovie(movieNo);

		model.addAttribute("totalRoleViewList", totalRoleViewList);
		int memberNo;
		if(session.getAttribute("memberNo") == null) {
			memberNo = 0;
		}
		else {
			memberNo = (int)session.getAttribute("memberNo");
		}
		log.debug("memberNo==={}",memberNo);
		log.debug("myMovieLike==={}",movieLikeDao.get(movieNo, memberNo));
		
		model.addAttribute("showStatus",checkStatus.getText());
		model.addAttribute("myMovieLike",movieLikeDao.get(movieNo, memberNo));
		model.addAttribute("movieDto", movieDto);
		model.addAttribute("moviePhotoList", moviePhotoList);
		model.addAttribute("videoList", videoList);
		return "movie/movieDetail";
		}
	
	
	@GetMapping("/delete")
	public String delete(@RequestParam int movieNo) {
		movieService.delete(movieNo);
		return "redirect:/movie/list";
	}
	
	@GetMapping("/edit")
	public String edit(@RequestParam int movieNo,Model model) {
		MovieDto movieDto = movieDao.get(movieNo);
		model.addAttribute("movieDto",movieDto);
		return "movie/edit";
	}
	@PostMapping("/edit")
	public String edit(
			@ModelAttribute MovieDto movieDto,
			@RequestParam(required = false) MultipartFile photo,
			@RequestParam(required = false) List<MultipartFile> attach
			) throws IllegalStateException, IOException {	
		
		movieService.edit(movieDto,photo,attach);
		
		return "redirect:/movie/movieDetail?movieNo="+movieDto.getMovieNo();
	}
	
//	다운로드에 대한 요청 처리

//	//덩어리를 옮겨야함. 덩어리는 무비에 대한 정보를 알고있다. 
//	차트vo에다가 무비포토넘버를 하나 추가, 무비컨트롤러에서 
//	무비넘버에 있는 파일들을 꺼내서, 무비포토에대한 리스트가 여러개 나오는데, 
//	리스트에.get0 각파일리스트에있는 첫번쨰있는걸 따올수 있음. 이걸 저장해서 넘긴다.

	@GetMapping("/movieImg")
	@ResponseBody					
	public ResponseEntity<ByteArrayResource> imgFile(
				@RequestParam int moviePhotoNo
			) throws IOException {
		MoviePhotoDto moviePhotoDto = moviePhotoDao.get(moviePhotoNo);
		byte[] data = moviePhotoDao.load(moviePhotoNo);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		String encodeName = URLEncoder.encode(moviePhotoDto.getMoviePhotoUploadName() , "UTF-8");
		encodeName = encodeName.replace("+", "%20");
		
		return ResponseEntity.ok()				
									.contentType(MediaType.APPLICATION_OCTET_STREAM)
									.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+encodeName+"\"")
									.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
									.contentLength(moviePhotoDto.getMoviePhotoSize())
									.body(resource);
	}
	

	//좋아요 기능
	@PostMapping("/data/insertLike")
	@ResponseBody
	public void insertLike(@ModelAttribute MovieLikeDto movieLikeDto, HttpSession session) {
		movieLikeDao.insert(movieLikeDto);
	}
	
	@DeleteMapping("/data/deleteLike")
	@ResponseBody
	public void deleteLike(@ModelAttribute MovieLikeDto movieLikeDto, HttpSession session) {
		movieLikeDao.delete(movieLikeDto);
	}
}
