package com.kh.spring.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.actor.ActorDto;
import com.kh.spring.entity.actor.ActorPhotoDto;
import com.kh.spring.entity.actor.TotalRoleViewDto;
import com.kh.spring.entity.movie.MoviePhotoDto;
import com.kh.spring.repository.actor.ActorDao;
import com.kh.spring.repository.actor.ActorPhotoDao;
import com.kh.spring.repository.actor.TotalRoleViewDao;
import com.kh.spring.repository.movie.MoviePhotoDao;
import com.kh.spring.service.ActorService;
import com.kh.spring.vo.MovieChartVO;
import com.kh.spring.vo.PaginationActorVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/actor")
public class ActorController {

	@Autowired
	private ActorDao actorDao;
	@Autowired
	private ActorService actorService;
	@Autowired
	private ActorPhotoDao actorPhotoDao;

	@GetMapping("/insert")
	public String insert() {
		return "actor/insert";
	}
	
	@PostMapping("/insert")
	public String insert(@ModelAttribute ActorDto actorDto,
			@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		int sequence = actorService.insert(actorDto,attach);
		
		return "redirect:/actor/list";
//		return "redirect:/actor/detail?actorNo="+sequence;
//		return"redirect:/actor/detail?actorNo="+actorDto.getActorNo();
	}
	
	//@GetMapping("/list")
	public String list(Model model) {
		model.addAttribute("list", actorDao.list());
		return "actor/list";
	}
	@GetMapping("/list")
	public String list(
			@ModelAttribute PaginationActorVO paginationActorVO,
			Model model) throws Exception {
		model.addAttribute("PaginationActorVO",actorService.serachPage(paginationActorVO));
		return "actor/list";
	}
	
	@GetMapping("/delete")
	public String delete(@RequestParam int actorNo) throws Exception {
		actorService.delete(actorNo);
		return "redirect:/actor/list";
	}
	
	@GetMapping("/edit")
	public String edit(@RequestParam int actorNo,Model model) {
		ActorDto actorDto = actorDao.get(actorNo);
		model.addAttribute("actorDto",actorDto);
		return "actor/edit";
	}
	@PostMapping("/edit")
	public String edit(
			@ModelAttribute ActorDto actorDto,
			@RequestParam(required = false) MultipartFile attach
			) throws IllegalStateException, IOException {	
		
		actorService.edit(actorDto,attach);
		return "redirect:/actor/list";
		//return "redirect:/actor/detail?actor="+actorDto.getActorNo();
	}	
	@GetMapping("/actorImg")
	@ResponseBody					
	public ResponseEntity<ByteArrayResource> imgFile(
				@RequestParam int actorNo
			) throws IOException {
		ActorPhotoDto actorPhotoDto = actorPhotoDao.getByActor(actorNo);
		byte[] data = actorPhotoDao.load(actorPhotoDto.getActorPhotoNo());
		ByteArrayResource resource = new ByteArrayResource(data);
		
		String encodeName = URLEncoder.encode(actorPhotoDto.getActorPhotoUploadName() , "UTF-8");
		encodeName = encodeName.replace("+", "%20");
		
		return ResponseEntity.ok()				
									.contentType(MediaType.APPLICATION_OCTET_STREAM)
									.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+encodeName+"\"")
									.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
									.contentLength(actorPhotoDto.getActorPhotoSize())
								.body(resource);
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam int actorNo,Model model) {
		ActorDto actorDto = actorDao.get(actorNo);
		List<MovieChartVO> movieList = actorService.getDetailVO(actorNo);
		
		model.addAttribute("movieList",movieList);
		model.addAttribute("actorDto",actorDto);
		return "actor/detail";
	}
	
}
