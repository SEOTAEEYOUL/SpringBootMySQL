package com.example.demo.controller;

// import java.util.ArrayList;
// import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
// import org.springframework.web.servlet.ModelAndView;

// import com.example.demo.dto.BooksDTO;
import com.example.demo.service.DbService;

@Controller
public class CommonController {
	@Autowired
	DbService dbService;

	@RequestMapping("/2")
	public String root_test( ) throws Exception {  // @Controller 일 경우 @ResponseBody 를 사용하지 않으면 오류가 발생함
		return ("Hello Root(/2) in Controller");
	}
	
	@RequestMapping("/demo2")
	public @ResponseBody String demo_test( ) throws Exception {
		return ("Hello demo(/demo2) in Controller");
	}
	
	/*
	@RequestMapping("/")
	public String main( ) {
		return ("main");	
	}
	
	@RequestMapping("/dbTest")
	public ModelAndView dbTest( ) throws Exception {
		List <BooksDTO> list = new ArrayList<BooksDTO> ( );
		list = dbService.getList( );
		
		return (new ModelAndView("dbTest", "list", list));
	}
	 */
}
