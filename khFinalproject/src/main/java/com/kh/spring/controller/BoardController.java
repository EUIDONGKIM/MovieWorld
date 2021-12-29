package com.kh.spring.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.board.BoardDto;
import com.kh.spring.entity.board.BoardFileDto;
import com.kh.spring.repository.board.BoardDao;
import com.kh.spring.repository.board.BoardFileDao;
import com.kh.spring.service.BoardService;
import com.kh.spring.vo.BoardSearchVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board")
public class BoardController {
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private BoardFileDao boardFileDao;
	
	@Autowired
	private BoardService boardService;	
	
	@GetMapping("/main")
	public String main(Model model, @RequestParam(required = false) String column,
     @RequestParam(required = false) String keyword,@RequestParam(required = false, defaultValue = "0") int p) throws Exception {
		BoardSearchVO vo = new BoardSearchVO();
		vo.setColumn(column);
		vo.setKeyword(keyword);
		vo.setP(p);
		BoardSearchVO param = boardService.searchNPaging(vo);
		model.addAttribute("boardSearchVO",param);

		//model.addAttribute("list",boardDao.list());
		return "board/main";
	}
	
	@GetMapping("/main")
	public String list(
			@ModelAttribute BoardSearchVO boardSearchVO,
			Model model) throws Exception {
		//리스트랑 페이지네이션 정보를 서비스에서 받아온다.
		BoardSearchVO param = boardService.searchNPaging(boardSearchVO);
		model.addAttribute("boardSearchVO",param);
		return "board/main";
	}
	
	@GetMapping("/write")
	public String write(@RequestParam(required = false,defaultValue = "0") int boardSuperno,Model model) {
		if(boardSuperno != 0) {
			model.addAttribute("boardSuperno",boardSuperno);
		}
		return "board/write";
	}
	
	
	@PostMapping("/write")
	public String write(@ModelAttribute BoardDto boardDto,
						@RequestParam List<MultipartFile> attach,
			HttpSession session) throws IllegalStateException, IOException {
		//맴버 아이디를 세션에서 받아서 주기
		String mebmerEmail = (String)session.getAttribute("ses");
		boardDto.setMemberEmail(mebmerEmail);
		
		int boardNo = boardService.write(boardDto, attach);
//		int boardNo = boardDao.write(boardDto);
		
		//return "redirect:/board/detail?boardNo="+boardNo;
		return "redirect:/";
	}
	
	
	@GetMapping("/detail")
	public String detail(@RequestParam int boardNo,
			HttpSession session,
			Model model) {

		BoardDto boardDto = boardDao.get(boardNo);
		List<BoardFileDto> boardFileList = boardFileDao.list(boardDto.getBoardNo());
		String memberEmail=(String)session.getAttribute("ses");
		model.addAttribute("boardNo",boardNo);
		model.addAttribute("memberEmail",memberEmail);
		model.addAttribute("boardDto",boardDto);
		model.addAttribute("boardFileList",boardFileList);
		
			
		return "board/detail";
	}
	
	@RequestMapping("/viewUp")
	public String viewUp(@RequestParam int boardNo) {
		//제목 누르면 viweUp을 통해 들어와서 리다이렉트
		boardDao.viewUp(boardNo);	
		return "redirect:detail?boardNo="+boardNo;
	}
	
	@RequestMapping("/delete")
	public String delete(int boardNo) {
		boardDao.delete(boardNo);
		return "redirect:/board/main";
	}
	
	@GetMapping("/edit")
	public String edit(@RequestParam int boardNo , Model model) {
		model.addAttribute("boardDto",boardDao.get(boardNo));
		return "board/edit";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute BoardDto boardDto) {	
		boardDao.edit(boardDto);
		int boardNo=boardDto.getBoardNo();
		return "redirect:/board/detail?boardNo="+boardNo;
	}
	
	@GetMapping("/file")
	@ResponseBody//이 메소드만큼은 뷰 리졸버를 쓰지 않겠다.
	public ResponseEntity<ByteArrayResource> file(@RequestParam int boardFileNo) throws IOException {
		
		BoardFileDto boardFileDto = boardFileDao.get(boardFileNo);
		log.debug("boardFileDto@@@@@@@@@@@@@@@={}",boardFileDto);
		byte[] data = boardFileDao.load(boardFileNo);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		log.debug("boardFileDto.getBoardFileUploadName()@@@@@@@@@@@@@@@={}",boardFileDto.getBoardFileUploadName());
		String encodeName = URLEncoder.encode(boardFileDto.getBoardFileUploadName(), "UTF-8");
		encodeName = encodeName.replace("+", "%20");
		return ResponseEntity.ok()
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+encodeName+"\"")
				.header("Content-Encoding", "UTF-8")
				.contentLength(boardFileDto.getBoardFileSize())
				.body(resource);
	}
}
