package com.kh.spring.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpSession;

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


import com.kh.spring.entity.store.StoreDto;
import com.kh.spring.entity.store.StoreFileDto;
import com.kh.spring.repository.store.StoreDao;
import com.kh.spring.repository.store.StoreFileDao;
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
//	@GetMapping("/main")
//	public String main(Model model, @RequestParam(required = false) String column,
//			@RequestParam(required = false) String keyword, @RequestParam(required = false, defaultValue = "0") int p)
//			throws Exception {
//		StoreSearchVO vo = new StoreSearchVO();
//		vo.setColumn(column);
//		vo.setKeyword(keyword);
//		vo.setP(p);
//		StoreSearchVO param = storeService.searchNPaging(vo);
//		model.addAttribute("boardSearchVO", param);
//
//		return "store/storeMain";
//	}
//	@GetMapping("/main")
//	public String list(
//			@ModelAttribute StoreSearchVO storeSearchVO,
//			Model model) throws Exception {
//		//리스트랑 페이지네이션 정보를 서비스에서 받아온다.
//		StoreSearchVO param = storeService.searchNPaging(storeSearchVO);
//		model.addAttribute("storeSearchVO",param);
//		return "store/storeMain";
//}
//	@GetMapping("/write")
//	public String write(@RequestParam(required = false,defaultValue = "0") int storeSuperno,Model model) {
//		if(storeSuperno != 0) {
//			model.addAttribute("storeSuperno",storeSuperno);
//		}
//		return "store/storeMain";
//	}	
//	@GetMapping("/detail")
//	public String detail(@RequestParam int productNo,
//			HttpSession session,
//			Model model) {
//
//		StoreDto storeDto = storeDao.get(productNo);
//		List<StoreFileDto> storeFileList = storeFileDao.list(storeDto.getProductNo());
//		model.addAttribute("productNo",productNo);
//		model.addAttribute("storeDto",storeDto);
//		model.addAttribute("storeFileList",storeFileList);
//		
//			
//		return "board/detail";
//	}
//	
//	@RequestMapping("/viewUp")
//	public String viewUp(@RequestParam int productNo) {
//		//제목 누르면 viweUp을 통해 들어와서 리다이렉트
//		storeDao.viewUp(productNo);	
//		return "redirect:storeDetail?productNo="+productNo;
//	}
//	
//	@RequestMapping("/delete")
//	public String delete(int productNo) {
//		storeDao.delete(productNo);
//		return "redirect:/store/storeMain";
//	}
//	
//	@GetMapping("/edit")
//	public String edit(@RequestParam int productNo , Model model) {
//		model.addAttribute("storeDto",storeDao.get(productNo));
//		return "store/storeEdit";
//	}
//	@PostMapping("/edit")
//	public String edit(@ModelAttribute StoreDto storeDto) {	
//		storeDao.edit(storeDto);
//		int productNo=storeDto.getProductNo();
//		return "redirect:/store/storeDetail?productNo="+productNo;
//	}
//	
//	@GetMapping("/file")
//	@ResponseBody//이 메소드만큼은 뷰 리졸버를 쓰지 않겠다.
//	public ResponseEntity<ByteArrayResource> file(@RequestParam int productPhotoNo) throws IOException {
//		
//		StoreFileDto storeFileDto = storeFileDao.get(productPhotoNo);
//		log.debug("storeFileDto@@@@@@@@@@@@@@@={}",storeFileDto);
//		byte[] data = storeFileDao.load(productPhotoNo);
//		ByteArrayResource resource = new ByteArrayResource(data);
//		
//		log.debug("storeFileDto.getProductFileUploadName()@@@@@@@@@@@@@@@={}",storeFileDto.getProductFileUploadName());
//		String encodeName = URLEncoder.encode(storeFileDto.getProductFileUploadName(), "UTF-8");
//		encodeName = encodeName.replace("+", "%20");
//		return ResponseEntity.ok()
//				.contentType(MediaType.APPLICATION_OCTET_STREAM)
//				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+encodeName+"\"")
//				.header("Content-Encoding", "UTF-8")
//				.contentLength(storeFileDto.getProductFileSize())
//				.body(resource);
//	}
}