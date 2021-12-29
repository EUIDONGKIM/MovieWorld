package com.kh.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/store")

public class StoreController {
	@GetMapping("/store")
	public String store() {
		return "store/storeMain";
	}
}
