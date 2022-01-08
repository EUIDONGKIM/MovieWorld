package com.kh.spring.vo;

import java.util.Comparator;

public class OrderByStar implements Comparator<MovieChartVO>{

	@Override
	public int compare(MovieChartVO o1, MovieChartVO o2) {
		return (int) (o2.getMovieStarpoint()-o1.getMovieStarpoint());
	}

}
