package com.kh.spring.repository.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.board.ReviewDto;
import com.kh.spring.vo.ReplyVO;


@Repository
public class ReviewDaoImpl implements ReviewDao{	
	
	@Autowired
	private SqlSession sqlSession;
//	@Override
//	public void reviewWrite(ReviewDto reviewDto) {
//		SqlSession.insert("review.write", reviewDto);
//	}

	@Override
	public void insert(ReviewDto reviewDto) {
		sqlSession.insert("review.insert",reviewDto);
	}

	@Override
	public List<ReplyVO> list(int movieNo) {
		return sqlSession.selectList("review.list",movieNo);
	}

	@Override
	public boolean delete(int movieNo, int memberNo) {
		Map<String,Object> param = new HashMap<>();
		param.put("movieNo", movieNo);
		param.put("memberNo", memberNo);
		return sqlSession.delete("review.delete",param)>0;
	}

	@Override
	public void update(ReviewDto reviewDto) {
		sqlSession.update("review.update",reviewDto);
	}

	@Override
	public void replyLike(int memberNo, int movieNo) {
		Map<String,Object> param = new HashMap<>();
		param.put("movieNo", movieNo);
		param.put("memberNo", memberNo);

		sqlSession.insert("review.replyLike",param);
	}

	@Override
	public ReviewDto getByNo(int memberNo, int movieNo) {
		Map<String,Object> param = new HashMap<>();
		param.put("movieNo", movieNo);
		param.put("memberNo", memberNo);
		return sqlSession.selectOne("review.getByNo",param);
	}

	@Override
	public List<ReplyVO> listByPage(int movieNo, int startRow, int endRow) {
		Map<String,Object> param = new HashMap<>();
		param.put("movieNo", movieNo);
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		
		return sqlSession.selectList("review.listByPage",param);
	}
}
