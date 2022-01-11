package com.kh.spring.repository.movie;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.entity.movie.MovieDto;

@Repository
public class MovieDaoImpl implements MovieDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<MovieDto> list() {
		return sqlSession.selectList("movie.list");
	}

	@Override
	public MovieDto get(int movieNo) {
		return sqlSession.selectOne("movie.get", movieNo);
	}

	@Override
	public int getSequence() {
		return sqlSession.selectOne("movie.getSequence");
	}

	@Override
	public void insert(MovieDto movieDto) {
		sqlSession.insert("movie.insert",movieDto);
	}

	@Override
	public List<MovieDto> listWithoutDuplicate(int theaterNo) {
		return sqlSession.selectList("movie.listWithoutDuplicate", theaterNo);
	}
		
	@Override
	public List<MovieDto> listByOpening() {
		return sqlSession.selectList("movie.listByOpening");
	}

	@Override
	public List<MovieDto> nowList(List<Integer> movieNoList) {
		Map<String,Object> param = new HashMap<>();
		param.put("list",movieNoList);
		
		return sqlSession.selectList("movie.nowList",param);
	}

	@Override
	public List<MovieDto> getTitleList(String movieTitle) {
		return sqlSession.selectList("movie.getTitleList", movieTitle);
	}

	@Override
	public List<Integer> notHaveSchedule() {
		return sqlSession.selectList("movie.notHaveSchedule");
	}

	@Override
	public void delete(int movieNo) {
		sqlSession.delete("movie.delete",movieNo);
	}

	@Override
	public void edit(MovieDto movieDto) {
		sqlSession.update("movie.update",movieDto);
	}

	@Override
	public List<MovieDto> myMovieLikeList(int memberNo, int startRow, int endRow) {
		Map<String, Object> param = new HashMap<>();
		param.put("memberNo", memberNo);
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		return sqlSession.selectList("movie.myMovieLike", param);
	}

	@Override
	public void refreshStar(int movieNo) {
		sqlSession.update("movie.refreshStar",movieNo);
	}

	@Override
	public List<MovieDto> listNotContent() {
		return sqlSession.selectList("movie.listNotContent");
	}

	@Override
	public int listNotContentCount() {
		return sqlSession.selectOne("movie.listNotContentCount");
	}

	@Override
	public List<MovieDto> listNotContentSearch(int begin, int end) {
		Map<String, Object> param = new HashMap<>();
		param.put("begin", begin);
		param.put("end", end);
		return sqlSession.selectList("movie.listNotContentSearch",param);
	}

}
