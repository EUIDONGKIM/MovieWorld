package com.kh.spring.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.entity.MemberDto;
import com.kh.spring.repository.MemberDao;


@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao memberDao;
	
	//회원가입 
	@GetMapping("/join")
	public String join() {
		return "member/join";
	}
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) {
		memberDao.join(memberDto);
		return "redirect:join_success";
	}
	
	@RequestMapping("/join_success")
	public String join_success() {
		return "member/join_success";
	}
	
	//로그인
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto memberDto,HttpSession session,
						@RequestParam(required = false) String saveId,HttpServletResponse response) {
		MemberDto findDto = memberDao.login(memberDto);
		if(findDto !=null) {
		 session.setAttribute("ses",findDto.getMemberEmail());
		 session.setAttribute("grade", findDto.getMemberGrade());
			if(saveId !=null) {
				Cookie c = new Cookie("saveId",findDto.getMemberEmail());
				c.setMaxAge(4*7*24 *60 *60); //2주간 저장
				response.addCookie(c);
			}else {
				Cookie c = new Cookie("saveId",findDto.getMemberEmail());
				c.setMaxAge(0);//쿠키삭제
				response.addCookie(c);
			}
			return "redirect:/";
		}else {
			return "redirect:login?error";	
		}
		
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("ses");
		session.removeAttribute("grade");
		return "redirect:/";
	}
	
	

}
