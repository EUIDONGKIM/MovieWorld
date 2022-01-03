package com.kh.spring.repository.member;

import java.util.List;

import com.kh.spring.entity.member.HistoryDto;

public interface HistoryDao {
	void insert(HistoryDto historyDto );
	List<HistoryDto> list(String memberEmail);
	HistoryDto get(int historyNo);
}
