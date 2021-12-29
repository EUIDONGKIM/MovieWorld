package com.kh.spring.repository.board;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.board.BoardFileDto;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Repository
public class BoardFileDaoImpl implements BoardFileDao{
	@Autowired
	private SqlSession sqlSession;
	
	//저장용 폴더
	private File directory = new File("C:\\Users\\USER\\upload");
	
	@Override
	public void save(BoardFileDto boardFileDto, MultipartFile file) throws IllegalStateException, IOException {
		//시퀀스 생성
		int sequence = sqlSession.selectOne("boardFile.getSeq");
		
		File target = new File(directory,String.valueOf(sequence));
		file.transferTo(target);
		
		boardFileDto.setBoardFileNo(sequence);
		boardFileDto.setBoardFileSaveName(String.valueOf(sequence));
		
		log.debug("값확인2!!!!!!!!!!!{}",boardFileDto);
		
		sqlSession.insert("boardFile.save",boardFileDto);
	}

	@Override
	public List<BoardFileDto> list(int boardNo) {
		return sqlSession.selectList("boardFile.list",boardNo);
	}

	@Override
	public BoardFileDto get(int boardFileNo) {
		return sqlSession.selectOne("boardFile.get",boardFileNo);
	}

	@Override
	public byte[] load(int boardFileNo) throws IOException {
		File target = new File(directory,String.valueOf(boardFileNo));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
	}

	@Override
	public void delete(int boardFileNo) {
		sqlSession.delete("boardFile.delete",boardFileNo);
	}

}