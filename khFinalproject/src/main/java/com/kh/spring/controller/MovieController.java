package com.kh.spring.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

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
			) {
		movieService.getMovieList(movieTitle,movieTotal,scheduleStart,scheduleEnd);
		
		if(movieTitle != null) {
			model.addAttribute("movieTitle", movieTitle);
		}else if(movieTotal != null) {
			model.addAttribute("movieTotal", movieTotal);
		}else if(scheduleStart != null && scheduleEnd != null) {
			model.addAttribute("scheduleStart", scheduleStart);
			model.addAttribute("scheduleEnd", scheduleEnd);
		}
		
		Map<MovieDto,List<Map<TotalInfoViewDto,List<LastInfoViewDto>>>> sendList = 
				movieService.getMovieList(movieTitle,movieTotal,scheduleStart,scheduleEnd);		
		model.addAttribute("sendList", sendList);
		return "movie/list";
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
		List<MovieChartVO> list = movieService.getChartList(movieNoList,order);

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
