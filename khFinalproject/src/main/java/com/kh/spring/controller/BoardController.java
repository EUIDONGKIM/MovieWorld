package com.kh.spring.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.entity.board.BoardDto;
import com.kh.spring.repository.board.BoardDao;

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
	
	//@RequestParam List<MultipartFile> attach
	@PostMapping("/write")
	public String write(@ModelAttribute BoardDto boardDto,
			HttpSession session) throws IllegalStateException, IOException {
		//맴버 아이디를 세션에서 받아서 주기
		String mebmerEmail = (String)session.getAttribute("ses");
		boardDto.setMemberEmail(mebmerEmail);
		
		int boardNo = boardDao.write(boardDto);
		
		return "redirect:/board/detail?boardNo="+boardNo;
	}
	
	
	@GetMapping("/detail")
	public String detail(@RequestParam int boardNo,
			HttpSession session,
			Model model) {
		
		BoardDto boardDto = boardDao.get(boardNo);
//		List<ReplyDto> replyList = replyDao.list(boardDto.getBoardNo());
//		List<BoardFileDto> boardFileList = boardFileDao.list(boardDto.getBoardNo());
		
		model.addAttribute("boardNo",boardNo);
		model.addAttribute("memberEmail",(String)session.getAttribute("ses"));
		model.addAttribute("boardDto",boardDto);
//		model.addAttribute("replyList",replyList);
//		model.addAttribute("boardFileList",boardFileList);
		
		return "board/detail";
	}
	@RequestMapping("/delete")
	public String delete(int boardNo) {
		boardDao.delete(boardNo);
		return "redirect:/board/main";
	}
	
	@GetMapping("/edit")
	public String edit(@RequestParam int boardNo , Model model) {
		model.addAttribute("boardDto",boardDao.get(boardNo));
		System.out.println("수정페이지접근");
		return "board/edit";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute BoardDto boardDto) {
		System.out.println("수정1");
		boardDao.edit(boardDto);
		System.out.println("수정2");
		int boardNo=boardDto.getBoardNo();
		System.out.println(boardNo);
		return "redirect:/board/detail?boardNo="+boardNo;
	}
}
