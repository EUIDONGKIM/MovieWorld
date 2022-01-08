package com.kh.spring.repository.board;


import java.util.List;

import com.kh.spring.entity.board.ReviewDto;
import com.kh.spring.vo.ReplyVO;

public interface ReviewDao {

	void insert(ReviewDto reviewDto);

	List<ReplyVO> list(int movieNo);

	boolean delete(int movieNo, int memberNo);

	void update(ReviewDto reviewDto);

	void replyLike(int memberNo, int movieNo);

	ReviewDto getByNo(int memberNo, int movieNo);

	List<ReplyVO> listByPage(int movieNo, int startRow, int endRow);

}

