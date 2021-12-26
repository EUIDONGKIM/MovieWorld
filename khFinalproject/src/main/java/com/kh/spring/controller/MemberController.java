package com.kh.spring.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.entity.MemberDto;
import com.kh.spring.repository.MemberDao;
import com.kh.spring.util.RandomUtil;

import lombok.extern.slf4j.Slf4j;


@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {
	@Autowired
	private MemberDao memberDao;

	@Autowired
	private RandomUtil randomUtil;
	

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
	//로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("ses");
		session.removeAttribute("grade");
		return "redirect:/";
	}
	
	@RequestMapping("/mypage")
	public String mypage() {
		return "member/mypage";
	}
	
	//아이디 찾기
	@GetMapping("/idScan")
	public String idScan() {
		return "member/idScan";
	}
	@PostMapping("/idScan")
	public String idScan(@RequestParam String memberName,@RequestParam String memberPhone,
			Model model) {
		
		MemberDto isPass=memberDao.findId(memberName, memberPhone);
		if(isPass!=null) {
			//System.out.println(isPass.getMemberEmail());
			model.addAttribute("memberEmail",isPass.getMemberEmail());
			return "member/idScanSuccess";
		}else {
			return "redirect:idScan?error";
		}
		
	}
	@RequestMapping("/idScanSuccess")
	public String idScanSuccess() {
		return "member/idScanSuccess";
	}
	

	@GetMapping("/pwScan")
	public String pwScan() {
		return "member/pwScan";
	}
	@PostMapping("/pwScan")
	public String pwScan(@RequestParam String memberEmail,@RequestParam String memberName,@RequestParam String memberPhone
			,Model model ,@ModelAttribute MemberDto memberDto) {
		MemberDto isPass=memberDao.findPw(memberName, memberEmail, memberPhone);
		//6자리의 랜덤숫자생성
		String number = randomUtil.generateRandomNumber(6);
		
		if(isPass!=null) {
			//6자리의 난수 비밀번호 생성
			isPass.setMemberPw(number);
			System.out.println("여기 1");

			String chagePw = isPass.getMemberPw();
		
			memberDao.temporayPassword(memberDto,chagePw);
			System.out.println("여기 2");
			model.addAttribute("memberPw",chagePw);
			System.out.println("여기 3");
			
			return "member/PwScanSuccess";
		}else {
			return "redirect:pwScan?error";
		}
	}
}
