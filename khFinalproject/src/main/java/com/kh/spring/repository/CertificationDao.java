package com.kh.spring.repository;

import com.kh.spring.entity.CertificationDto;

public interface CertificationDao {
	void insert(CertificationDto certificationDto);
	boolean check(CertificationDto certificationDto);
	void clean();
}
