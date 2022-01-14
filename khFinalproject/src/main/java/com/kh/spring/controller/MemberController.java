package com.kh.spring.controller;

import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
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

import com.kh.spring.entity.member.HistoryDto;
import com.kh.spring.entity.member.MemberDto;
import com.kh.spring.entity.reservation.ReservationDto;
import com.kh.spring.repository.member.HistoryDao;
import com.kh.spring.repository.member.MemberDao;
import com.kh.spring.repository.movie.MovieLikeDao;
import com.kh.spring.repository.reservation.ReservationDao;
import com.kh.spring.service.EmailService;

import lombok.extern.slf4j.Slf4j;


@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private HistoryDao historyDao;
	
	@Autowired
	private ReservationDao reservationDao;

	@Autowired
	private MovieLikeDao movieLikeDao;
	

  

	
	

	//회원가입 
	@GetMapping("/join")
	public String join() {
		return "member/join";
	}
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) {
		System.out.println(memberDto);
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
	public String login(@ModelAttribute MemberDto memberDto,HttpSession session,HttpServletRequest request,
						@RequestParam(required = false) String saveId,HttpServletResponse response) {
		
		MemberDto findDto = memberDao.login(memberDto);
		

		if(findDto !=null) {
		
		 session.setAttribute("memberNo", findDto.getMemberNo());
		 session.setAttribute("ses",findDto.getMemberEmail());
		 session.setAttribute("grade", findDto.getMemberGrade());
		 //마지막 로그인 정보 업데이트
		 memberDao.lastLogin(findDto.getMemberEmail());
		 
		 //만약 등급이 정지라면 로그인 실패
		 String memberGrade = (String)session.getAttribute("grade");
		 if(memberGrade.equals("정지")){
			 return "redirect:login?stop";
		 }
		
		 
		 //임시 비밀번호로 변경하여 로그인할시 세션에 저장되어있는 값이 있다면 비밀번호
		 //변경 페이지로 리다이렉트
		 String redirectPassword= (String)session.getAttribute("temparayPassword");
		 	if(redirectPassword != null) {
		 		//넘어 왔으면 세션을 삭제한다
		 		session.removeAttribute("temparayPassword");
		 		return "redirect:changePw2";
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
		session.removeAttribute("memberNo");
		return "redirect:/";
	}
	
	@RequestMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		//세션에서 아이디를 꺼내와서 해당 아이디로 조회후 값이 있다면 마이페이지로 이동
		String memberEmail = (String)session.getAttribute("ses");
		model.addAttribute("memberDto",memberDao.get(memberEmail));
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
		System.out.println(memberName);
		System.out.println(memberPhone);
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
	@Autowired
	private EmailService emailService;
	
	@PostMapping("/pwScan")
	public String pwScan(@RequestParam String memberEmail,@RequestParam String memberName,@RequestParam String memberPhone
			,Model model ,@ModelAttribute MemberDto memberDto ,HttpSession session) throws MessagingException {
		MemberDto isPass=memberDao.findPw(memberName, memberEmail, memberPhone);
		//랜덤 난수 글자 생성 
		//String tmpPw = randomUtil.generateRandomPassword(10);
		
		if(isPass!=null) {
			
			String chagePw = emailService.examPw(memberEmail);
			//암호화 하여 셋팅
//			String origin = tmpPw;
//			String encrypt = encoder.encode(origin);
			//비밀번호를 업데이트 해준다
//			isPass.setMemberPw(tmpPw);
//			String chagePw = isPass.getMemberPw();
			
			//비밀번호를 업데이트
			memberDao.temporayPassword(memberDto,chagePw);
//			model.addAttribute("memberPw",chagePw);
//			//임시 비밀번호로 바뀌면 세션에 아이디를 저장
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
	
	@GetMapping("/changePw2")
	public String changePw2() {
		return "member/changePw2";
	}
	
	@PostMapping("/changePw")
	public String changePw(
			@RequestParam String memberPw, 
			@RequestParam String changePw, 
			HttpSession session) {
		String memberId = (String) session.getAttribute("ses");
		boolean result = memberDao.changePassword(memberId, memberPw, changePw);
		if(result) {
			return "redirect:mypage";
		}
		else {
			return "redirect:changePw?error";
		}
	}
	
	@PostMapping("/changePw2")
	public String changePw2(
			@RequestParam String memberPw, 
			@RequestParam String changePw, 
			HttpSession session) {
		String memberId = (String) session.getAttribute("ses");
		boolean result = memberDao.changePassword(memberId, memberPw, changePw);
		if(result) {
			return "redirect:/";
		}
		else {
			return "redirect:changePw2?error";
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
		boolean result =memberDao.quit(memberEmail, memberPw);
		System.out.println("quit");
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
	//회원 수정
	@GetMapping("/edit")
	public String edit(HttpSession session, Model model) {
		String memberEmail = (String) session.getAttribute("ses");
		//관리자만 수정가능하게 등급도 같이 보내준다.
		String grade = (String)session.getAttribute("grade");
		MemberDto memberDto = memberDao.get(memberEmail);
		
		model.addAttribute("grade",grade);
		model.addAttribute("memberDto", memberDto);
		return "member/edit";
	}

	@PostMapping("/edit")
	public String edit(@ModelAttribute MemberDto memberDto, HttpSession session
			,@RequestParam String memberPw) {
//		String memberEmail = (String) session.getAttribute("ses");
//		memberDao.get(memberEmail);

		boolean result = memberDao.changeInformation(memberDto,memberPw);
		if (result) {
			return "redirect:mypage";
		} else {
			return "redirect:edit?error";
		}
	}

	@RequestMapping("/edit_success")
	public String editSuccess() {

		return "member/edit_success";
	}
	
	@GetMapping("/history")
	public String history(HttpSession session,Model model,@ModelAttribute HistoryDto historyDto
			,@ModelAttribute MemberDto memberDto) {		
		String memberEmail =(String)session.getAttribute("ses");
		List<HistoryDto> list = historyDao.list(memberEmail);
			
//		int point=memberDao.getPoint(memberEmail);
//		

		model.addAttribute("point",memberDao.getPoint(memberEmail));
		model.addAttribute("list",list);	
			return "member/history";		
	}
	//예매내역 페이지
	@GetMapping("/ReservationHistoryList")
	public String ReservationHistoryList(HttpSession session,Model model,
			@ModelAttribute ReservationDto reservationDto) {
		//세션에서 아이디를 꺼내서 조회를한다.
		String memberEmail = (String)session.getAttribute("ses");
		MemberDto findDto = memberDao.get(memberEmail);
		
		//만약 아이디로 조회시 null아니라면 findDto에서 memberNo를 가져온다
		if(findDto !=null) {
			int memberNo=findDto.getMemberNo();
			List<ReservationDto> list =reservationDao.list(memberNo);
		
			model.addAttribute("list", list);

		}
		
		
		return "member/ReservationHistoryList";
	}
	
	
	//결제내역 페이지
	@GetMapping("payHistroy")
		public String payHistroy() {
			return "member/payHistroy";
	}
	
	@GetMapping("/movieLikeList")
	public void movieLikeList(Model model, HttpSession session) { 
		int memberNo = (int)session.getAttribute("memberNo");
		
		model.addAttribute("count",movieLikeDao.count(memberNo));
		
	}
	
}
