package com.rkawscertify.springbootsample1.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloWorldController {

	@RequestMapping("/")	
	public String hello() {
			return "Hello World With Live Reload!";
		}
}
