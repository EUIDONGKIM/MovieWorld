package com.kh.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.spring.entity.actor.RoleDto;
import com.kh.spring.entity.actor.TotalRoleViewDto;
import com.kh.spring.entity.movie.VideoDto;
import com.kh.spring.entity.reservation.LastInfoViewDto;
import com.kh.spring.repository.actor.RoleDao;
import com.kh.spring.repository.actor.TotalRoleViewDao;
import com.kh.spring.repository.movie.VideoDao;
import com.kh.spring.repository.reservation.LastInfoViewDao;


@RestController
@RequestMapping("/admin")
public class AdminDataController {
	@Autowired
	private LastInfoViewDao lastInfoViewDao;
	@Autowired
	private VideoDao videoDao;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private TotalRoleViewDao totalRoleViewDao;
	
	@GetMapping("/checkSameTime")
	public String checkSameTime(
			@RequestParam int scheduleNo,
			@RequestParam int hallNo,
			@RequestParam String scheduleTimefirst
			) {
		List<LastInfoViewDto> checkList = lastInfoViewDao.checkTime(scheduleNo,hallNo,scheduleTimefirst);
		String check;
		if(!checkList.isEmpty()) {
			check="NNNNN";
			return check;
		}
		else check="NNNNO";
		
		return check;
	}
	@DeleteMapping("/deleteVideo")
	public boolean deleteVideo(@RequestParam int videoNo) {
		return videoDao.delete(videoNo);
	}
	@DeleteMapping("/deleteStaff")
	public boolean deleteStaff(@RequestParam int actorNo) {
		return roleDao.delete(actorNo);
	}
	@DeleteMapping("/deleteActor")
	public boolean deleteActor(@RequestParam int actorNo) {
		return roleDao.delete(actorNo);
	}
	@DeleteMapping("/deleteDirector")
	public boolean deleteDirector(@RequestParam int actorNo) {
		return roleDao.delete(actorNo);
	}
	@GetMapping("/getVideo")
	public List<VideoDto> getVideo(@RequestParam int movieNo) {
		return videoDao.listByMovie(movieNo);
	}
	@GetMapping("/getStaff")
	public List<TotalRoleViewDto> getStaff(@RequestParam int movieNo) {
		return totalRoleViewDao.listByJob(movieNo,"staff");
	}
	@GetMapping("/getActor")
	public List<TotalRoleViewDto> getActor(@RequestParam int movieNo) {
		return totalRoleViewDao.listByJob(movieNo,"actor");
	}
	@GetMapping("/getDirector")
	public List<TotalRoleViewDto> getDirector(@RequestParam int movieNo) {
		return totalRoleViewDao.listByJob(movieNo,"director");
	}
	@PostMapping("/addRole")
	public void addRole(
			@RequestParam int movieNo,
			@RequestParam int actorNo
			) {
		RoleDto roleDto = new RoleDto();
		roleDto.setActorNo(actorNo);
		roleDto.setMovieNo(movieNo);
		roleDao.insert(roleDto);
	}
	@PostMapping("/addVideo")
	public void addVideo(
			@RequestParam int movieNo,
			@RequestParam String videoTitle,
			@RequestParam String videoRoot
			) {
		
		VideoDto videoDto = new VideoDto();
		videoDto.setMovieNo(movieNo);
		videoDto.setVideoTitle(videoTitle);
		videoDto.setVideoRoot(videoRoot);
		
		videoDao.insert(videoDto);
	}
}
