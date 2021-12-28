package com.kh.spring.entity.board;

import lombok.Data;

@Data
public class BoardFileDto {
	private int boardFileNo;
	private int boardNo;
	private String boardFileUploadName;
	private String boardFileServerName;
	private long boardFileSize;
	private String boardFileType;
}
