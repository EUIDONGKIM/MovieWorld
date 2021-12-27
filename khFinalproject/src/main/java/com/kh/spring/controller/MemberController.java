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

import com.kh.spring.entity.member.MemberDto;
import com.kh.spring.repository.MemberDao;
import com.kh.spring.service.EmailService;
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
	
	@Autowired
	private EmailService emailService;
	

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
	
	//이메일 체크
	@PostMapping("/email_check")
	public String check(@ModelAttribute MemberDto memberDto) {
		boolean success = true;//certiDao.check(certiDTO);
		if(success) {
			return "redirect:/success";//절대경로
//			return "redirect:success";//상대경로
		}
		else {
			return "redirect:/?error";
		}
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
		 //임시 비밀번호로 변경하여 로그인할시 세션에 저장되어있는 값이 있다면 비밀번호
		 //변경 페이지로 리다이렉트
		 String redirectPassword= (String)session.getAttribute("temparayPassword");
		 	if(redirectPassword != null) {
		 		//넘어 왔으면 세션을 삭제한다
		 		session.removeAttribute("temparayPassword");
		 		return "redirect:changePw";
		 	}
			
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
			,Model model ,@ModelAttribute MemberDto memberDto ,HttpSession session) {
		MemberDto isPass=memberDao.findPw(memberName, memberEmail, memberPhone);
		//6자리의 랜덤숫자생성
		String number = randomUtil.generateRandomNumber(6);
		
		if(isPass!=null) {
			//6자리의 난수 비밀번호 생성
			isPass.setMemberPw(number);
			
			String chagePw = isPass.getMemberPw();
		
			memberDao.temporayPassword(memberDto,chagePw);
			model.addAttribute("memberPw",chagePw);
			//임시 비밀번호로 바뀌면 세션에 아이디를 저장
			session.setAttribute("temparayPassword", memberDto.getMemberEmail());
			System.out.println(memberDto.getMemberEmail());
			return "member/PwScanSuccess";
		}else {
			return "redirect:pwScan?error";
		}
	}
	
	@GetMapping("/changePw")
	public String changePw() {
		return "member/changePw";
	}
	
	@PostMapping("/changePw")
	public String changePw(
			@RequestParam String memberPw, 
			@RequestParam String changePw, 
			HttpSession session) {
		String memberId = (String) session.getAttribute("ses");
		boolean result = memberDao.changePassword(memberId, memberPw, changePw);

		if(result) {
			return "redirect:/";
		}
		else {
			return "redirect:changePw?error";
		}
	}
	
	//회원탈퇴
	@RequestMapping("/quit")
	public String quit() {
		return "member/quit";
	}
	
	@PostMapping("/quit")
	public String quit(String memberPw,HttpSession session) {
		String memberEmail = (String)session.getAttribute("ses");
		System.out.println(memberPw);
		System.out.println(memberEmail);
		boolean result =memberDao.quit(memberEmail, memberPw);
		if(result) {
			session.removeAttribute("ses");
			session.removeAttribute("grade");
			return "redirect:quit_success";
		}else {
			return "redirect:quit?error";
		
	}
	
   }
	@RequestMapping("quit_success")
	public String quit_success() {
		return "member/quit_success";
	}
}
