package com.kh.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.entity.movie.MovieDto;
import com.kh.spring.entity.reservation.LastInfoViewDto;
import com.kh.spring.entity.reservation.StatisticsInfoViewDto;
import com.kh.spring.entity.schedule.ScheduleDto;
import com.kh.spring.entity.schedule.ScheduleTimeDto;
import com.kh.spring.entity.schedule.TotalInfoViewDto;
import com.kh.spring.entity.theater.TheaterDto;
import com.kh.spring.repository.movie.MovieDao;
import com.kh.spring.repository.reservation.LastInfoViewDao;
import com.kh.spring.repository.reservation.StatisticsInfoViewDao;
import com.kh.spring.repository.schedule.ScheduleDao;
import com.kh.spring.repository.schedule.ScheduleTimeDao;
import com.kh.spring.repository.schedule.ScheduleTimeDiscountDao;
import com.kh.spring.repository.schedule.TotalInfoViewDao;
import com.kh.spring.repository.theater.HallDao;
import com.kh.spring.repository.theater.TheaterDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/schedule")
public class ScheduleController {

	@Autowired
	private MovieDao movieDao;
	@Autowired
	private HallDao hallDao;
	@Autowired
	private ScheduleDao scheduleDao;
	@Autowired
	private ScheduleTimeDao scheduleTimeDao;
	@Autowired
	private ScheduleTimeDiscountDao scheduleTimeDiscountDao;
	@Autowired
	private TotalInfoViewDao totalInfoViewDao;
	@Autowired
	private TheaterDao theaterDao;
	@Autowired
	private LastInfoViewDao lastInfoViewDao;
	@Autowired
	private StatisticsInfoViewDao statisticsInfoViewDao;
	
	@GetMapping("/admin/create")
	public String create(Model model) {
		model.addAttribute("TheaterList", theaterDao.list());
		model.addAttribute("movieList", movieDao.list());
		return "schedule/create";
	}
	
	@PostMapping("/admin/create")
	public String create(@ModelAttribute ScheduleDto scheduleDto) {
		scheduleDao.insert(scheduleDto);
		
		return "redirect:list";
	}
	
	@GetMapping("/admin/create_total")
	public String createTotal(Model model) {
		List<Integer> movieNoList = movieDao.notHaveSchedule();
		List<MovieDto> movieList = movieDao.nowList(movieNoList);
		
		model.addAttribute("movieList", movieList);
		return "schedule/create_total";
	}
	
	@PostMapping("/admin/create_total")
	public String createTotal(@ModelAttribute ScheduleDto scheduleDto) {
		
		List<TheaterDto> theaterList = theaterDao.list();
		for(TheaterDto theaterDto : theaterList) {
			scheduleDto.setTheaterNo(theaterDto.getTheaterNo());
			scheduleDao.insert(scheduleDto);
		}
		
		
		return "redirect:/movie/admin/list";
	}
	
	//영화관 상세페이지에서 상영 영화 생성
	@GetMapping("/admin/create2")
	public String create2(@RequestParam int theaterNo, Model model) {
		model.addAttribute("theaterDto",theaterDao.get(theaterNo));
		model.addAttribute("movieList", movieDao.listWithoutDuplicate(theaterNo));
		return "schedule/create2";
	}
	@PostMapping("/admin/create2")
	public String create2(@ModelAttribute ScheduleDto scheduleDto) {
		scheduleDao.insert(scheduleDto);
		
		return "redirect:/theater/detail?theaterNo="+scheduleDto.getTheaterNo();
	}
	
	
	@RequestMapping("/admin/list")
	public String list(Model model) {
		model.addAttribute("totalInfoViewList", totalInfoViewDao.list());

		return "schedule/list";
	}
	
	@GetMapping("/time/admin/create")
	public String timeCreate(@RequestParam int scheduleNo,Model model) {
		
		TotalInfoViewDto totalInfoViewDto = totalInfoViewDao.get(scheduleNo);
		model.addAttribute("hallList", hallDao.list(totalInfoViewDto.getTheaterNo()));
		model.addAttribute("totalInfoViewDto",totalInfoViewDto);
		model.addAttribute("scheduleTimeDiscountList", scheduleTimeDiscountDao.list());
		
		return "schedule/time/create";
	}
	
	@PostMapping("/time/admin/create")
	public String timeCreate(@ModelAttribute ScheduleTimeDto scheduleTimeDto) {
		log.debug("디티오 ==== {}",scheduleTimeDto);
		scheduleTimeDao.insert(scheduleTimeDto);
		return "redirect:/movie/admin/list";
	}
	
	
	@GetMapping("/admin/edit")
	public String edit(@RequestParam int scheduleNo, Model model) {
		TotalInfoViewDto totalInfoViewDto = totalInfoViewDao.get(scheduleNo);
		MovieDto movieDto = movieDao.get(totalInfoViewDto.getMovieNo());
		
		model.addAttribute("totalInfoViewDto",totalInfoViewDto);
		model.addAttribute("movieDto",movieDto);
		
		return "schedule/edit";
	}
	@PostMapping("/admin/edit")
	public String edit(@ModelAttribute ScheduleDto scheduleDto) {
		scheduleDao.edit(scheduleDto);
		return "redirect:/movie/admin/list";
	}
	
	
	@GetMapping("/admin/delete")
	public String delete(@RequestParam int scheduleNo) {
		LastInfoViewDto checkDto = lastInfoViewDao.existScheduleNo(scheduleNo);
		log.debug("checkDto의 값은!?@@@@@@@={}",checkDto);
		if(checkDto==null) {
		boolean success = scheduleDao.delete(scheduleNo);
		if(success) {
			return "redirect:/movie/admin/list";
		}
		else {
			return "redirect:???"; //실패
		}
		}else {
			return "redirect:/movie/admin/list?errorSchedule";
		}
	}
	
	@GetMapping("/time/admin/edit")
	public String timeEdit(@RequestParam int scheduleTimeNo, Model model) {
		LastInfoViewDto lastInfoViewDto = lastInfoViewDao.get(scheduleTimeNo);
		model.addAttribute("lastInfoViewDto",lastInfoViewDto);
		model.addAttribute("hallList", hallDao.list(lastInfoViewDto.getTheaterNo()));
		model.addAttribute("scheduleTimeDiscountList", scheduleTimeDiscountDao.list());
		return "schedule/time/edit";
	}
	@PostMapping("/time/admin/edit")
	public String timeEdit(@ModelAttribute ScheduleTimeDto scheduleTimeDto) {
		boolean success = scheduleTimeDao.edit(scheduleTimeDto);
		if(success) {
			return "redirect:/movie/admin/list";
		}
		else {
			return "redirect:???"; //실패
		}
		
	}
	
	
	@GetMapping("/time/admin/delete")
	public String timeDelete(@RequestParam int scheduleTimeNo) {
		StatisticsInfoViewDto statisticsInfoViewDto = statisticsInfoViewDao.exist(scheduleTimeNo);
		if(statisticsInfoViewDto==null) {
			
		boolean success = scheduleTimeDao.delete(scheduleTimeNo);
		if(success) {
			return "redirect:/movie/admin/list";
		}
		else {
			return "redirect:???"; //실패
		}
		}else {
			return "redirect:/movie/admin/list?errorScheduleTimeNo";
		}
	}
	
}
