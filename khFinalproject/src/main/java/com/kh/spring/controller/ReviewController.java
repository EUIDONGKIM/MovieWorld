package com.kh.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.spring.service.ReviewService;

@RequestMapping("/review")
@Controller
public class ReviewController {
	
	@Autowired 
//	private ReviewService reviewService;
	
	
	@GetMapping("/write")
	public String write() {
		return "review/write";
	}
	
	@GetMapping("/list")
	public String list() {
		return "review/list";
	}
	
//		@GetMapping("/review")
//		public ModelAndView list() throws Exception{
//			List<Reviewmain> reviewList = reviewService.findAll();
//			ModelAndView nextPage = new ModelAndView("review/home");
//			nextPage.addObject("reviewList", reviewList);
//			return nextPage;
//		}
	
	
}
