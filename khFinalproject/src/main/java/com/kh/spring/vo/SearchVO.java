package com.kh.spring.vo;

import java.util.List;

import com.kh.spring.entity.actor.ActorDto;

import lombok.Data;

@Data
public class SearchVO {
	private int p;
	private String keyword;
	private int count;
	private int pageSize = 6;
	private int blockSize = 5;
	private int begin, end;
	private int startBlock, finishBlock, lastBlock;
	private List<MovieChartVO> list;
	
	public void calculate() throws Exception {
		//rownum 계산
		if(this.p <= 0) this.p = 1;
		
		this.end = this.p * this.pageSize;
		this.begin = this.end - (this.pageSize - 1);
		
		//block 계산
		this.lastBlock = (this.count - 1) / this.pageSize + 1;
		this.startBlock = (this.p - 1) / this.blockSize * this.blockSize + 1;
		this.finishBlock = this.startBlock + (this.blockSize - 1);
	}
	
	//추가 : 이전이 존재하나요?
	public boolean isPreviousAvailable() {
		return this.startBlock > 1;
	}
	//추가 : 검색모드인가요?
	public boolean isSearch() {
		return (this.keyword != null && !this.keyword.equals(""));
	}
	//추가 : 다음이 존재하나요?
	public boolean isNextAvailable() {
		return this.finishBlock < this.lastBlock; 
	}
	//추가 : 진짜 마지막 블록 번호 반환
	public int getRealLastBlock() {
		return Math.min(this.finishBlock, this.lastBlock);
	}
	//추가 : 이전을 누르면 나오는 블록 번호
	public int getPreviousBlock() {
		return this.startBlock - 1;
	}
	//추가 : 다음을 누르면 나오는 블록 번호
	public int getNextBlock() {
		return this.finishBlock + 1;
	}
	
}
