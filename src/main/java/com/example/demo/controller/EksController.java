package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.dto.EksDTO;
import com.example.demo.service.EksService;

@RestController
public class EksController {
	@Autowired
	EksService eksService;

	@GetMapping("/eks-details.do")
	public ModelAndView eksDetail( ) throws Exception {
        EksDTO eksDto = eksService.getEksDetail( );
		
		return (new ModelAndView("EksDetail", "eksDetail", eksDto));
	}	
}

