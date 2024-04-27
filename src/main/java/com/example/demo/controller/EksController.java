package com.example.demo.controller;

// import org.slf4j.Logger;
// import org.slf4j.LoggerFactory;

import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.eks.EksClient;
import software.amazon.awssdk.services.eks.model.Cluster;
import software.amazon.awssdk.services.eks.model.DescribeClusterRequest;
import software.amazon.awssdk.services.eks.model.DescribeClusterResponse;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

// import software.amazon.awssdk.services.eks.AmazonEKSClientBuilder;

// import software.amazon.awssdk.http.apache.ApacheHttpClient;
// import software.amazon.awssdk.services.s3.S3Client;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
		// List <EksDTO> list = new ArrayList<EksDTO> ( );
		// list = eksService.getList( );
        // return (new ModelAndView("EksDetail", "list", list));
        EksDTO eksDto = eksService.getEksDetail( );
		
		return (new ModelAndView("EksDetail", "eksDetail", eksDto));
	}	
}

