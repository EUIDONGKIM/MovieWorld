package com.kh.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.entity.member.MemberDto;
import com.kh.spring.entity.theater.TheaterDto;
import com.kh.spring.repository.member.MemberDao;
import com.kh.spring.repository.theater.TheaterDao;
import com.kh.spring.service.AdminService;
import com.kh.spring.vo.MemberSearchVO;
import com.kh.spring.vo.PaginationVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private TheaterDao theaterDao;
	
	@RequestMapping("/")
	public String adminHome() {
		return "admin/main";
	}
	
	@GetMapping("/theater")
	public String adminTheater(@ModelAttribute PaginationVO paginationVO, Model model) throws Exception {
		paginationVO.setCount(theaterDao.count(paginationVO));
		paginationVO.calculate();
		
		log.debug("paginationVO...{}",paginationVO);
		List<TheaterDto> list = theaterDao.search(paginationVO);
		model.addAttribute("totalCount",theaterDao.list().size());
		model.addAttribute("list",list);
		
		return "admin/theater";
	}
	
	@RequestMapping("/hall")
	public String adminHall() {
		return "admin/hall";
	}
	
	@RequestMapping("/schedule")
	public String main() {
		return "admin/schedule";
	}
	
	@GetMapping("/movieInfo")
	public String adminMovieInfo() {
		return "admin/movieInfo";
	}
	
	@GetMapping("/actorInfo")
	public String adminActorInfo() {
		return "admin/actorInfo";
	}
	
	@GetMapping("/review")
	public String adminReview() {
		return"admin/review";
	}
	@GetMapping("/statistics")
	public String statistics() {
		return "admin/statistics";
	}
	
	
	@GetMapping("/price")
	public String adminPrice() {
		return "admin/price";
	}
	
	
	//@ModelAttribute MemberDto memberDto
	@GetMapping("/memberlist")
	public String memberlist(Model model,
			@ModelAttribute MemberSearchVO memberSearchVO) throws Exception {
		//리스트랑 페이지네이션 정보를 서비스에서 받아온다.
		MemberSearchVO param = adminService.searchNPaging(memberSearchVO);
		System.err.println(param);
		model.addAttribute("memberSearchVO",param);
		
//		List<MemberDto> list = memberDao.list();
//		model.addAttribute("list",list);
	
		return "admin/memberlist";
	}

	

	
	//관리자가 회원 요청에 의해서 회원 탈퇴를 시켜줘야 할경우
	@GetMapping("/memberDrop")
	public String memberDrop(@RequestParam int memberNo) {
			boolean result=memberDao.adminDrop(memberNo);
			if(result) {
				return "admin/main";
			}else {
				return "admin/main?error?";
			}	
	}
	

	
	//관리자가 회원정보 수정
	@GetMapping("/member/edit2")
	public String adminMemberEdit(@RequestParam int memberNo,Model model) {
		model.addAttribute("memberDto",memberDao.get2(memberNo));
		return "member/edit2";
	}
	@PostMapping("/member/edit2")
	public String adminMemberEdit(@ModelAttribute MemberDto memberDto) {
		memberDao.changeInformationAdmin(memberDto);
		return "member/edit2";
	}

}
