package com.kh.spring.vo;

import java.util.Comparator;

public class OrderByCount implements Comparator<MovieChartVO>{

	@Override
	public int compare(MovieChartVO o1, MovieChartVO o2) {
		return o2.getMovieCount()-o1.getMovieCount();
	}

}
