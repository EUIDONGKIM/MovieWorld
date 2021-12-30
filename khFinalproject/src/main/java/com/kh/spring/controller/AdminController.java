package com.kh.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.spring.entity.member.MemberDto;
import com.kh.spring.repository.member.MemberDao;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	private MemberDao memberDao;
	
	@RequestMapping("/")
	public String adminHome() {
		return "admin/main";
	}
	
	@RequestMapping("/theater")
	public String adminTheater() {
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
	
	@GetMapping("/price")
	public String adminPrice() {
		return "admin/price";
	}
	
	
	
	@RequestMapping("/memberlist")
	public String memberlist(Model model,@ModelAttribute MemberDto memberDto) {
		List<MemberDto> list = memberDao.list();
		model.addAttribute("list",list);
		return "admin/memberlist";
	}

	@RequestMapping("/memberDrop")
	@ResponseBody
	public String memberDrop(@RequestParam int memberNo) {
		System.out.println("탈퇴2");
		boolean result=memberDao.adminDrop(memberNo);
		if(result) {
			System.out.println("탈퇴3");
			return "admin/main";
		}else {
			System.out.println("탈퇴4");
			return "admin/main?error?";
		}	
	}
	
//	@GetMapping("/detail")
//	public String memberDetail() {
//		return "member/edit?memberNo";
//	}
	
}
