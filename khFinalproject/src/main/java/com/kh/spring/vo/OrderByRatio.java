package com.kh.spring.vo;

import java.util.Comparator;

public class OrderByRatio implements Comparator<MovieChartVO>{

	@Override
	public int compare(MovieChartVO o1, MovieChartVO o2) {
		return (int) (o2.getMovieRatio()-o1.getMovieRatio());
	}

}
