package com.kh.spring.vo;

import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.kh.spring.entity.actor.ActorDto;
import com.kh.spring.entity.movie.MovieDto;
import com.kh.spring.entity.reservation.LastInfoViewDto;
import com.kh.spring.entity.schedule.TotalInfoViewDto;

import lombok.Data;

@Data
public class PaginationMovieVO {
	private int p;
	private String movieTitle;
	private String movieTotal;
	private int count;
	private int pageSize = 10;
	private int blockSize = 5;
	private int begin, end;
	private int startBlock, finishBlock, lastBlock;
	private Map<MovieDto,List<Map<TotalInfoViewDto,List<LastInfoViewDto>>>> list = new TreeMap<>();
	
	
	
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
		return this.movieTitle != null && !this.movieTitle.equals("");
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

	public PaginationMovieVO() {
		if(this.movieTotal == null) {
			this.movieTotal = "A";
		}
	}
	
}
