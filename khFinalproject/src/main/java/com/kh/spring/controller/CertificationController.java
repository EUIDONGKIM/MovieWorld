package com.kh.spring.controller;

import java.util.Random;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.spring.entity.member.CertificationDto;
import com.kh.spring.repository.member.CertificationDao;
import com.kh.spring.service.EmailService;

@Controller
public class CertificationController {
 @Autowired
 private EmailService emailService;
 
 @Autowired
 private CertificationDao  certificationDao;
 
 @Autowired
 private JavaMailSender javaMailSender;
 
// 	@GetMapping("/")
// 	public String root() {
// 		return "root";
// 	}
 	@GetMapping("/send")
 	public String send() {
 		return "member/join";
 	}
 	@PostMapping("/send")
 	public String sned(@RequestParam String memberEmail) throws MessagingException {
 		emailService.sendCertificationNumber(memberEmail);
 		return "member/join";
 	}
 
 	@PostMapping("/")
 	public String cert(@RequestParam String email ,Model model) throws MessagingException {
 		emailService.sendCertificationNumber(email);
 		model.addAttribute("email",email);
 		return "";
 	}
 	@PostMapping("/check")
 	public String check(@ModelAttribute CertificationDto certificationDto) {
 		boolean success=certificationDao.check(certificationDto);
 	if(success) {
 		return "redirect:/success"; //절대경로
// 		return "redirect:success"; //상대경로
 		
 	}else {
 		return "redirect:/?error";
 	}
 	}
	@RequestMapping("/CheckMail")
    @ResponseBody
	public String SendMail(String mail, HttpSession session) {

		Random random = new Random();
		String key = "";

		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(mail); // 스크립트에서 보낸 메일을 받을 사용자 이메일 주소
		// 입력 키를 위한 코드
		for (int i = 0; i < 3; i++) {
			int index = random.nextInt(25) + 65; // A~Z까지 랜덤 알파벳 생성
			key += (char) index;
		}
		int numIndex = random.nextInt(8999) + 1000; // 4자리 정수를 생성
		key += numIndex;
		message.setSubject("인증번호 입력을 위한 메일 전송");
		message.setText("인증 번호 : " + key);
		javaMailSender.send(message);

		return key;
	}
 	
 	@GetMapping("/success")
 	public String success() {
 		return "success";
 	}
}
