package com.kh.spring.repository;

import com.kh.spring.entity.BoardDto;

public interface BoardDao {
	void write(BoardDto boardDto);
}
