package com.kh.spring.controller;


import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.store.StoreDto;
import com.kh.spring.repository.store.StoreDao;
import com.kh.spring.service.StoreService;
import com.kh.spring.vo.StoreSearchVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/store")
public class StoreController {

	@Autowired
	private StoreDao storeDao;

//	@Autowired
//	private StoreFileDao storeFileDao;

	@Autowired
	private StoreService storeService;
	
	@GetMapping("/storeMain")
	public String main() {
		return "store/storeMain";
	}

	@GetMapping("/storeInsert")
	public String insert() {
		return "store/storeInsert";
	}
	 
	@PostMapping("/storeInsert")
	public String insert(@ModelAttribute StoreDto storeDto,
			@RequestParam MultipartFile photo) throws IllegalStateException, IOException {

		int no = storeService.insert(storeDto,photo);

		return "store/storeMain";
	}
	
	@GetMapping("/storeEdit")
	public String edit(@RequestParam int productNo, Model model) {
		
		model.addAttribute("StoreDto", storeDao.get(productNo));
		//model.addAttribute("productNo", productNo);
		return "store/storeEdit";
	}
	
	@PostMapping("/storeEdit")
	public String edit(@ModelAttribute StoreDto storeDto,@ModelAttribute StoreSearchVO storeSearchVO,Model model) throws Exception {
		
		storeDao.changeInformation(storeDto);
		StoreSearchVO parm = storeService.searchNPaging(storeSearchVO);
		model.addAttribute("storeSearchVO",parm);
		return "store/storeList";
		
	}

	@RequestMapping("/storeEditSuccess")
	public String editSuccess() {

		return "store/storeEditSuccess";
	}
	@GetMapping("/storeList")
	public String list(@ModelAttribute StoreSearchVO storeSearchVO,Model model) throws Exception {
		StoreSearchVO parm = storeService.searchNPaging(storeSearchVO);
		model.addAttribute("storeSearchVO",parm);
		return "store/storeList";
	}
	//상품 삭제
	@RequestMapping("/delete")
	public String delete(@RequestParam int productNo) {
		boolean result=storeDao.delete(productNo);
		if(result) {
			return "store/storeMain";
		}else {
			return "store/storeMain?error?";
		}	
	}
	
}

