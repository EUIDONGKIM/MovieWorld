package com.kh.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping("/review")
@Controller
public class ReviewController {
	
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
