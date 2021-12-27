package com.kh.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.kh.spring.entity.CertificationDto;
import com.kh.spring.repository.CertificationDao;
import com.kh.spring.util.RandomUtil;


@Service
public class GmailService implements EmailService{
	
	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	private RandomUtil randomUtil;
	
	@Autowired
	private CertificationDao  certificationDao;

	@Override
	public void sendCertificationNumber(String to) {
		String number = randomUtil.generateRandomNumber(6);
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(to);
		message.setSubject("[영화보조] 회원가입 인증번호 메일입니다");
		message.setText("인증번호 :"+ number);
		sender.send(message);
		
		//기록은 항상 나중에
		CertificationDto certificationDto =new CertificationDto();
		certificationDto.setEmail(to);
		certificationDto.setSerial(number);
		
		certificationDao.insert(certificationDto);
	}
	
}