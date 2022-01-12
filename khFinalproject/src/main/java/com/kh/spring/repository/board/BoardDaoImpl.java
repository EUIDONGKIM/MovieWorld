package com.kh.spring.repository.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.board.BoardDto;
import com.kh.spring.entity.board.BoardVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSession sqlsession;
	@Override
	public void write(BoardDto boardDto) {
		sqlsession.insert("board.write",boardDto);
	}
	
	@Override
	public List<BoardVO> list() {
		return sqlsession.selectList("board.list");
	}

	@Override
	public BoardDto get(int boardNo) {
		return sqlsession.selectOne("board.get",boardNo);
	}

	@Override
	public BoardVO get2(int boardNo) {
		return sqlsession.selectOne("board.get2",boardNo);
	}

	@Override
	public int getSequence() {
		return sqlsession.selectOne("board.getSeq");
	}
	
	@Override
	public List<BoardVO> getUserWrite(String memberEmail) {
	
		return sqlsession.selectList("board.myWrite",memberEmail);
	}

	@Override
	public boolean delete(int boardNo) {
		BoardDto boardDto = new BoardDto();
		boardDto.setBoardNo(boardNo);
		int count = sqlsession.delete("board.delete",boardDto);
		return count>0;
	}

	@Override
	public boolean edit(BoardDto boardDto) {
		int count = sqlsession.update("board.edit",boardDto);
		return count>0;
	}

	@Override
	public boolean viewUp(int boardNo) {
		int result =sqlsession.update("board.viewUp",boardNo);
		return result>0;
	}

	@Override
	public List<BoardVO> search(String column, String keyword, int begin, int end,int boardTypeName) {
		Map<String,Object> param = new HashMap<>();
		param.put("column",column);
		param.put("keyword",keyword);
		param.put("begin",begin);
		param.put("end",end);
		param.put("boardTypeName",boardTypeName);
		return sqlsession.selectList("board.search",param);
	}

	@Override
	public int count(String column, String keyword ,int boardTypeName) {
		Map<String,Object> param = new HashMap<>();
		param.put("column",column);
		param.put("keyword",keyword);
		param.put("boardTypeName",boardTypeName);
	
		return sqlsession.selectOne("board.count",param);
	}

	@Override
	public void write1(BoardDto boardDto) {
		sqlsession.insert("board.write1",boardDto);
	}

	@Override
	public void write2(BoardDto boardDto) {
		sqlsession.insert("board.write2",boardDto);
	}

	@Override
	public int count1(String column, String keyword, String memberEmail) {
		Map<String,Object> param = new HashMap<>();
		param.put("column",column);
		param.put("keyword",keyword);
		param.put("memberEmail",memberEmail);
	
		return sqlsession.selectOne("board.count1",param);
	}

	@Override
	public List<BoardVO> search1(String column, String keyword, int begin, int end, String memberEmail) {
		Map<String,Object> param = new HashMap<>();
		param.put("column",column);
		param.put("keyword",keyword);
		param.put("begin",begin);
		param.put("end",end);
		param.put("memberEmail",memberEmail);

		return sqlsession.selectList("board.search1",param);
	}






}
