package com.example.demo.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

public class EksDTO {
	private String region;
	private String clusterName;
	private String endPoint;
	private String eksPlatform;
	private String podName;
	
	public EksDTO() {		
	}
	
	public EksDTO(String region,
	    String clusterName,
		String endPoint,
		String eksPlatform,
        String podName) {
		super( );
		this.region = region;
		this.clusterName = clusterName;
		this.endPoint = endPoint;
		this.eksPlatform = eksPlatform;
		this.podName = podName;
	}

	public String getRegion( ) {
		return (this.region);
	}

	public String getClusterName( ) {
		return (this.clusterName);	
	}
	

	public String getEndPoint( ) {
		return (this.endPoint);
	}


	public String getEksPlatform( ) {
		return (this.eksPlatform);	
	}

	public String getPodName( ) {		
		return (this.podName);	
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "region=" + getRegion( ) + 
		       ", ClusterName="+ getClusterName( ) +
					 ", endPoint="+ getEndPoint( ) +
					 ", eksPlatform=" + getEksPlatform( ) +
					 ", podName=" + getPodName( );
	}
}
