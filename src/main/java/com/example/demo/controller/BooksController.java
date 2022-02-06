package com.example.demo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.dto.BooksDTO;
import com.example.demo.service.DbService;

@Controller
public class BooksController {
	
	@Autowired
	DbService dbService;
	
	@RequestMapping("/home.do")
	public String main( ) {
		return ("book");	
	}
	
	@RequestMapping("/books.do")
	public ModelAndView dbTest( ) throws Exception {
		List <BooksDTO> list = new ArrayList<BooksDTO> ( );
		list = dbService.getList( );
		
		return (new ModelAndView("BooksList", "list", list));
	}
	
}
