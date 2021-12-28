package com.kh.spring.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.BoardDto;
import com.kh.spring.repository.BoardDao;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board")
public class BoardController {
	@Autowired
	private BoardDao boardDao;
	
	@RequestMapping("/main")
	public String main(Model model) {
		model.addAttribute("list",boardDao.list());
		return "board/main";
	}
	@GetMapping("/write")
	public String write() {
		return "board/write";
	}
	@PostMapping("/write")
	public String write(@ModelAttribute BoardDto boardDto,
			@RequestParam List<MultipartFile> attach,
			HttpSession session) throws IllegalStateException, IOException {
		
		boardDto.setMemberEmail((String)session.getAttribute("ses"));
		
		int boardNo = boardDto.getBoardNo();
		
		return "redirect:detail?boardNo="+boardNo;
	}
	
	@RequestMapping("/detail")
	public String detail(@RequestPart int boardNo ,HttpSession session,Model model) {
		String memberEmail = (String)session.getAttribute("ses");
		
		model.addAttribute("boardNo",boardNo);
		model.addAttribute("memberEmail",memberEmail);
		model.addAttribute("boardDto",boardDao.get(boardNo));
		return "board/detail";
	}
}
