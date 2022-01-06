package com.kh.spring.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.board.BoardDto;
import com.kh.spring.entity.board.BoardFileDto;
import com.kh.spring.entity.board.BoardVO;
import com.kh.spring.repository.board.BoardDao;
import com.kh.spring.repository.board.BoardFileDao;
import com.kh.spring.vo.BoardSearchVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class BoardServiceImpl  implements BoardService {

	@Autowired
	private BoardDao boardDao;
	@Autowired
	private BoardFileDao boardFileDao;
	//저장용 폴더
	@Value("${config.rootpath.board}")
	public String directory;

//	@Override
//	public BoardSearchVO searchNPaging(BoardSearchVO boardSearchVO) throws Exception {
//		int count = boardDao.count(boardSearchVO.getColumn(),boardSearchVO.getKeyword());
//		boardSearchVO.setCount(count);
//		boardSearchVO.calculate();
//		List<BoardDto> list = boardDao.search(boardSearchVO.getColumn(), boardSearchVO.getKeyword(),boardSearchVO.getBegin(),boardSearchVO.getEnd());
//		boardSearchVO.setList(list);
//		return boardSearchVO;
//	}

	@Override
	public BoardSearchVO searchNPaging(BoardSearchVO boardSearchVO) throws Exception {
		int count = boardDao.count(boardSearchVO.getColumn(),boardSearchVO.getKeyword(),boardSearchVO.getBoardTypeName());
		boardSearchVO.setCount(count);
		boardSearchVO.calculate();
		List<BoardVO> list = boardDao.search(boardSearchVO.getColumn(), boardSearchVO.getKeyword(),boardSearchVO.getBegin(),boardSearchVO.getEnd(),boardSearchVO.getBoardTypeName());
		boardSearchVO.setList(list);
		return boardSearchVO;
	}


	@Override
	public int write(BoardDto boardDto, List<MultipartFile> attach) throws IllegalStateException, IOException {
		int sequence = boardDao.getSequence();
		boardDto.setBoardNo(sequence);
		
		if(boardDto.getBoardSuperno() > 0) {
			System.out.println(boardDto.getBoardSuperno()+"1");
			BoardDto parent = boardDao.get(boardDto.getBoardSuperno());
			boardDto.setBoardGroupno(parent.getBoardGroupno());
			boardDto.setBoardDepth(parent.getBoardDepth()+1);
			boardDao.write1(boardDto);
		}else {
			boardDto.setBoardGroupno(sequence);
			System.out.println(boardDto.getBoardSuperno()+"2");
			boardDao.write2(boardDto);
		}
		
		//파일도 저장해야한다.
		for(MultipartFile file : attach) {
			if(!file.isEmpty()) {
				BoardFileDto boardFileDto = new BoardFileDto();
				boardFileDto.setBoardNo(boardDto.getBoardNo());
				boardFileDto.setBoardFileUploadName(file.getOriginalFilename());
				boardFileDto.setBoardFileType(file.getContentType());
				boardFileDto.setBoardFileSize(file.getSize());
				boardFileDao.save(boardFileDto,file);
			}
		}
		return sequence;
	}

	@Override
	public void delete(int boardNo) {
		//해당 번호에 파일 업도드 되어 있는지 확인한다
		List<BoardFileDto> boardFileList = boardFileDao.list(boardNo);
		if(!boardFileList.isEmpty()) {
			//비어있지 않다면,
			for(BoardFileDto file : boardFileList) {
				//하나씩 꺼내서 삭제해준다.
				File target = new File(directory,String.valueOf(file.getBoardFileSaveName()));
				target.delete();
				//파일 삭제시켜준다.
				boardFileDao.delete(file.getBoardFileNo());
			}
		}
		
		
		boardDao.delete(boardNo); // 게시판을 삭제해준다
		
	}

	@Override
	public void edit(BoardDto boardDto, List<MultipartFile> attach) throws IllegalStateException, IOException {
		boolean check = false;
		for(MultipartFile file : attach) {
			if(!file.isEmpty()) {
				check = true;
				break;
			}
		}
		
		//파일이 있다면 기존 파일을 삭제하고 새로운 파일을 추가해주어야 한다.
		if(check) {
			//해당 번호에 파일 업도드 되어 있는지 확인한다
			List<BoardFileDto> boardFileList = boardFileDao.list(boardDto.getBoardNo());
			if(!boardFileList.isEmpty()) {
				//비어있지 않다면,
				for(BoardFileDto file : boardFileList) {
					//하나씩 꺼내서 삭제해준다.
					File target = new File(directory,String.valueOf(file.getBoardFileSaveName()));
					target.delete();
					//파일 삭제시켜준다.
					boardFileDao.delete(file.getBoardFileNo());
				}
			}
			
			//새로운 파일이 들어온 것으로 수정해준다.
			for(MultipartFile file : attach) {
				if(!file.isEmpty()) {
					BoardFileDto boardFileDto = new BoardFileDto();
					boardFileDto.setBoardNo(boardDto.getBoardNo());
					boardFileDto.setBoardFileUploadName(file.getOriginalFilename());
					boardFileDto.setBoardFileType(file.getContentType());
					boardFileDto.setBoardFileSize(file.getSize());
					boardFileDao.save(boardFileDto,file);
				}
			}
		}
		
		//게시판 내용 수정해준다.
		boardDao.edit(boardDto);
		
	}

	@Override
		public BoardSearchVO searchNPagingByMember(BoardSearchVO boardSearchVO, String memberEmail) throws Exception {

		int count1 = boardDao.count1(boardSearchVO.getColumn(),boardSearchVO.getKeyword(),memberEmail);
		boardSearchVO.setCount(count1);
	
		boardSearchVO.calculate();
		
		List<BoardVO> list = boardDao.search1(boardSearchVO.getColumn(), boardSearchVO.getKeyword(),boardSearchVO.getBegin(),boardSearchVO.getEnd(),memberEmail);
		boardSearchVO.setList(list);
		return boardSearchVO;
	}


	
	
	
}