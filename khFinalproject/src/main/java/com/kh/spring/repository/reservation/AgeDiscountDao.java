package com.kh.spring.repository.reservation;

import java.util.List;

import com.kh.spring.entity.reservation.AgeDiscountDto;

public interface AgeDiscountDao {

	int getPrice(String ageName);

	List<AgeDiscountDto> list();
	
	void insert(AgeDiscountDto ageDiscountDto);
	
	boolean delete(int ageNo);
	
	void edit(AgeDiscountDto ageDiscountDto);
	
}
