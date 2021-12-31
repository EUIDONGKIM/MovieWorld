package com.kh.spring.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.Logger;
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

import com.kh.spring.entity.board.BoardFileDto;
import com.kh.spring.entity.member.MemberDto;
import com.kh.spring.entity.store.StoreDto;
import com.kh.spring.entity.store.StoreFileDto;
import com.kh.spring.repository.store.StoreDao;
import com.kh.spring.repository.store.StoreFileDao;
import com.kh.spring.service.StoreService;
import com.kh.spring.vo.StoreSearchVO;

import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/store")
public class StoreController {

	@Autowired
	private StoreDao storeDao;

//	@Autowired
//	private StoreFileDao storeFileDao;

//	@Autowired
//	private StoreService storeService;
	
	@GetMapping("/storeMain")
	public String main() {
		return "store/storeMain";
	}
	@GetMapping("/storeInsert")
	public String insert() {
		return "store/storeInsert";
	}
	
	@PostMapping("/storeInsert")
	public String insert(@ModelAttribute StoreDto storeDto) {
		System.out.println("테스트@@");
		System.err.println(storeDto.getProductNo());
		System.err.println(storeDto.getProductType());
		System.err.println(storeDto.getProductName());
		System.err.println(storeDto.getProductPrice());
		System.err.println(storeDto.getProductOrigin());
		System.err.println(storeDto.getProductIntro());
		System.err.println(storeDto.getProductContent());
		storeDao.insert(storeDto);
		return "store/storeMain";
	}
	@GetMapping("/storeEdit")
	public String edit(Model model) {
		List<StoreDto> storeList = storeDao.list();
		
	    
		model.addAttribute("storeList",storeList);
		
		return "store/storeEdit";
	}
	@PostMapping("/storeEdit")
	public String edit(@ModelAttribute StoreDto storeDto, HttpSession session) {

		boolean result = storeDao.changeInformation(storeDto);
		if (result) {
			return "redirect:storeEditSuccess";
		} else {
			return "redirect:storeEdit?error";
		}
	}

	@RequestMapping("/storeEditSuccess")
	public String editSuccess() {

		return "store/storeEditSuccess";
	}
}