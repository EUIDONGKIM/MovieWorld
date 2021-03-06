package com.kh.spring.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.kh.spring.entity.member.CertificationDto;
import com.kh.spring.entity.member.MemberDto;
import com.kh.spring.repository.member.CertificationDao;
import com.kh.spring.repository.member.MemberDao;
import com.kh.spring.util.RandomUtil;


@Service
public class GmailService implements EmailService{
	
	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	private RandomUtil randomUtil;
	
	@Autowired
	private CertificationDao  certificationDao;
	
	@Autowired
	private MemberDao memberDao;

	@Override
	public void sendCertificationNumber(String to) throws MessagingException {
		//랜덤번호생성
		String number = randomUtil.generateRandomNumber(6);
//		SimpleMailMessage message = new SimpleMailMessage();
	
		MimeMessage message = sender.createMimeMessage();
		//실제 이메일 발송 부분
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
		helper.setTo(to);
		helper.setSubject("[영화보조] 회원가입 인증번호 메일입니다");
//		message.setText("인증번호 :"+ number);
		helper.setText("<h1>영화보조</h1> <br/><br/>"+
	    		"<h3>인증코드를 확인해주세요.</h3>"+
				"<div align='center' style='border:2px solid black; font-family:verdana; width:120px;'>"+ 		
				"<h1 style='color:pink;'>"+number+"</h1>"+ 
	    		"</div>"+
	    		"<br/><br/>이메일 인증 절차에 따라 이메일 인증코드를 발급해드립니다." 
	    		,true);
		sender.send(message);
		
		//기록은 항상 나중에
		CertificationDto certificationDto =new CertificationDto();
		certificationDto.setMemberEmail(to);
		certificationDto.setSerial(number);
		
		certificationDao.insert(certificationDto);
	}
	
	@Override
	public String examPw(String to) throws MessagingException {

		//랜덤번호생성
		String number = randomUtil.generateRandomNumber(6);
//		SimpleMailMessage message = new SimpleMailMessage();
		MemberDto findDto = memberDao.get(to);
		//랜덤번호를 설정해준다
		findDto.setMemberPw(number);
		
		String changePw = findDto.getMemberPw();
		
		MimeMessage message = sender.createMimeMessage();
		//실제 이메일 발송 부분
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
		helper.setTo(to);
		helper.setSubject("[영화보조]  임시 비밀번호 메일입니다");
//		message.setText("인증번호 :"+ number);
		helper.setText("<h1>영화보조</h1> <br/><br/>"+
	    		"<h3>임시비밀번호입니다.</h3>"+
				"<div align='center' style='border:2px solid black; font-family:verdana; width:120px;'>"+ 		
				"<h1 style='color:pink;'>"+changePw+"</h1>"+ 
	    		"</div>"+
	    		"<br/><br/>이메일 인증 절차에 따라 이메일 인증코드를 발급해드립니다." 
	    		,true);
		sender.send(message);
		return changePw;
	}
	
}