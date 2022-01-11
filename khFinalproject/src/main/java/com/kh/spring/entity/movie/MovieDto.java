package com.kh.spring.entity.movie;

import java.text.Format;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
public class MovieDto implements Comparable<MovieDto>{
	private int movieNo;
	private String movieTitle;
	private String movieEngTitle;
	private String movieGrade;
	private String movieType;
	private String movieCountry;
	private String movieOpening;
	private int movieRuntime;
	private float movieStarpoint;
	private String movieContent;
	
	public String getOpeningDay() {
		return this.movieOpening.substring(0,10);
	}
	public String getEndingDay() {
		String string = movieOpening;
		Calendar c = Calendar.getInstance();
		c.set(Integer.parseInt(string.substring(0,4)), Integer.parseInt(string.substring(5,7))-1, Integer.parseInt(string.substring(8,10)));
		c.add(Calendar.DATE, 60);
		Date d = c.getTime();

		Format f = new SimpleDateFormat("yyyy-MM-dd");
		return f.format(d);
	}
	@Override
	public int compareTo(MovieDto o) {
		return o.movieNo-this.movieNo;
	}
}
