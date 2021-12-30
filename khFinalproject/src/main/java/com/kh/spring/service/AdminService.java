package com.kh.spring.service;

import com.kh.spring.vo.MemberSearchVO;

public interface AdminService {
	MemberSearchVO searchNPaging(MemberSearchVO memberSearchVO) throws Exception;
}
