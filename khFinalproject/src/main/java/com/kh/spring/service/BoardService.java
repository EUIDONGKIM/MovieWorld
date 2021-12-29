package com.kh.spring.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.board.BoardDto;
import com.kh.spring.vo.BoardSearchVO;

public interface BoardService {
	BoardSearchVO searchNPaging(BoardSearchVO boardSearchVO) throws Exception;

	int write(BoardDto boardDto, List<MultipartFile> attach) throws IllegalStateException, IOException;

	void delete(int boardNo);

	void edit(BoardDto boardDto, List<MultipartFile> attach) throws IllegalStateException, IOException;
}
