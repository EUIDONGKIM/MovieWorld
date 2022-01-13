package com.kh.spring.controller;


import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.spring.entity.reservation.LastInfoViewDto;
import com.kh.spring.entity.theater.TheaterDto;
import com.kh.spring.repository.reservation.LastInfoViewDao;
import com.kh.spring.repository.schedule.TotalInfoViewDao;
import com.kh.spring.repository.theater.HallDao;
import com.kh.spring.repository.theater.TheaterDao;
import com.kh.spring.service.TheaterService;
import com.kh.spring.vo.TheaterCityVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/theater")
@Slf4j
public class TheaterController {

	@Autowired
	private TheaterDao theaterDao;
	
	@Autowired
	private HallDao hallDao;
	
	@Autowired
	private TotalInfoViewDao totalInfoViewDao;
	
	@Autowired
	private LastInfoViewDao lastInfoViewDao;
	
	@Autowired
	private TheaterService theaterService;
	
	@GetMapping("/admin/create")
	public String create() {
		return "theater/create";
	}
	
	@PostMapping("/admin/create")
	public String create(@ModelAttribute TheaterDto theaterDto) {
		theaterDao.create(theaterDto);
		
		return "redirect:/theater/detail?theaterNo="+theaterDto.getTheaterNo();
	}
	
	@RequestMapping("/list")
	public String list(@ModelAttribute TheaterCityVO theaterCityVO, Model model) {
		List<TheaterCityVO> list = theaterDao.cityList();
		model.addAttribute("cityList",list);
		
		return "theater/list";
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam int theaterNo, Model model,@RequestParam(required = false) String errorSchedule) {

		model.addAttribute("theaterDto",theaterDao.get(theaterNo));
		model.addAttribute("hallList",hallDao.list(theaterNo));
		model.addAttribute("scheduleList", totalInfoViewDao.listByTheater(theaterNo));
		if(errorSchedule != null) {
			model.addAttribute("errorSchedule",errorSchedule);
		}
		List<Map<Integer,Map<Integer,List<LastInfoViewDto>>>> list = new ArrayList<>();
		List<String> dateList = new ArrayList<>();
		
		Calendar c = Calendar.getInstance();
		Format f = new SimpleDateFormat("yyyy-MM-dd");
		
		for(int i = 0 ; i < 7 ; i++) {
			Date d = c.getTime();
			String day = f.format(d);
			
			Map<Integer,Map<Integer,List<LastInfoViewDto>>> movieMap = new HashMap<>();
			List<Integer> movieNoList = lastInfoViewDao.getMovieNo(theaterNo,day);
			
			for(int movieNo : movieNoList) {
				Map<Integer,List<LastInfoViewDto>> hallMap = new HashMap<>();
				List<Integer> hallNoList =lastInfoViewDao.hallNoList(theaterNo,day,movieNo);
					
					for(int hallNo : hallNoList) {
						List<LastInfoViewDto> listByNo = lastInfoViewDao.listByhallNoForMap(theaterNo,day,movieNo,hallNo);
						hallMap.put(hallNo,listByNo);
					}
					
				movieMap.put(movieNo,hallMap);
				
			}
			
			list.add(movieMap);
			dateList.add(day);
			c.add(Calendar.DATE, 1);
		}

		
		model.addAttribute("infoList1", list.get(0));
		model.addAttribute("infoList2", list.get(1));
		model.addAttribute("infoList3", list.get(2));
		model.addAttribute("infoList4", list.get(3));
		model.addAttribute("infoList5", list.get(4));
		model.addAttribute("infoList6", list.get(5));
		model.addAttribute("infoList7", list.get(6));		
		model.addAttribute("dateList", dateList);
		
		return "theater/detail";
	}
	
	@GetMapping("/admin/edit")
	public String edit(@RequestParam int theaterNo, Model model) {
		TheaterDto theaterDto = theaterDao.get(theaterNo);
		model.addAttribute("scheduleList",totalInfoViewDao.listByTheater(theaterNo));
		model.addAttribute("theaterDto",theaterDto);
		
		return "theater/edit";
	}
	@PostMapping("/admin/edit")
	public String edit(@ModelAttribute TheaterDto theaterDto, RedirectAttributes redirectAttributes) {
		theaterService.editTheater(theaterDto);
		redirectAttributes.addAttribute("theaterNo", theaterDto.getTheaterNo());
		redirectAttributes.addFlashAttribute("editResult","editSuccess");
		return "redirect:/theater/detail";	
	}
	
	@PostMapping("/admin/delete")
	public String delete(@RequestParam int theaterNo, RedirectAttributes redirectAttributes) {
		boolean success = theaterService.deleteTheater(theaterNo);
		log.debug("폐점 성공? = {}",success);
		if(success) {
			redirectAttributes.addFlashAttribute("deleteResult",success);
			return "redirect:/admin/theater";//성공하면 목록으로
		}
		else {
			redirectAttributes.addAttribute("theaterNo", theaterNo);
			return "redirect:/theater/admin/edit";
		}
	}
}
