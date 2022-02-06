package com.example.demo.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DemoApiController {

	@GetMapping("/demoapistring")
	public String demoapistirng( ) {
		return ("데모 스트링 타입 리턴");
	}

	@GetMapping("/demoapi")
	public Map<String, Object> demoapi( ) {
		Map<String, Object> map = new HashMap<>( );
		map.put("name", "홍길동");
		map.put("birthday", "홍길동");
		return (map);
	}
	
	/*
	@RequestMapping("/")
	public String root_test( ) throws Exception {
		return ("Hello, Spring Boot!");
	}
	 */
	
	@RequestMapping("/demo")
	public String demo_test( ) throws Exception {
		return ("Hello demo(/demo) in RestController");
	}

}
