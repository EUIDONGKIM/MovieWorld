package com.kh.spring.repository.board;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.board.BoardFileDto;

public interface BoardFileDao {
	void save(BoardFileDto boardFileDto, MultipartFile file) throws IllegalStateException, IOException;

	List<BoardFileDto> list(int boardNo);

	BoardFileDto get(int boardFileNo);

	byte[] load(int boardFileNo) throws IOException;

	void delete(int boardFileNo);
}
