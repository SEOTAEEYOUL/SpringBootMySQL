package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.batch.BatchProperties.Jdbc;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.dto.JdbcDTO;
import com.example.demo.service.JdbcService;

@RestController
public class Jdbcontroller {
    @Autowired
    JdbcService jdbcService;

    @GetMapping("/jdbc-details.do")
    public ModelAndView jdbcDetail( ) throws Exception {
        JdbcDTO jdbcDto = jdbcService.getJdbcDetail( );
        
        return (new ModelAndView("JdbcDetail", "jdbcDetail", jdbcDto));
    }
}

