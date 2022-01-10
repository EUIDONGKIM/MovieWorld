package com.kh.spring.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.spring.entity.theater.SeatDto;
import com.kh.spring.service.SeatService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/seat")
@Slf4j
public class SeatController {
	
	@Autowired
	private SeatService seatService;
	
	@PostMapping("/insert")
	public String insert(@RequestParam List<String> seat,@RequestParam int hallNo, RedirectAttributes redirectAttributes) {
		
		List<SeatDto> seatList = new ArrayList<>();
		
		for(String s : seat) {
			SeatDto seatDto = new SeatDto();
			StringTokenizer st = new StringTokenizer(s,"-");
			
			while(st.hasMoreTokens()) {
				seatDto.setSeatRows(Integer.parseInt(st.nextToken()));
				seatDto.setSeatCols(Integer.parseInt(st.nextToken()));
				seatDto.setSeatStatus(st.nextToken());
				st.nextToken();
			}

			seatList.add(seatDto);
			}
			
		seatService.setSeatandUpdateHall(seatList,hallNo);
		
		redirectAttributes.addAttribute("hallNo",hallNo);
		
		return "redirect:/hall/detail";
	}
}
