package com.kh.spring.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.spring.entity.MemberDto;


@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberDto memberDto;
	
	@GetMapping("/join")
	public String join() {
		return "join";
	}
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) throws IllegalStateException, IOException {
		return "redirect:join_success";
	}
}
