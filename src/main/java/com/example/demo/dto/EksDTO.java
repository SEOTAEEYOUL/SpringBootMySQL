package com.example.demo.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

public class EksDTO {
    private String region;
    private String clusterName;
    private String version;
    private String endPoint;
    private String eksPlatform;
    private String status;
    private String info;
    private String podName;
	
    public EksDTO( ) {
    }

    public EksDTO(String region,
        String clusterName,
        String version,
        String endPoint,
        String eksPlatform,
        String status,
        String info,
        String podName) {
        super( );
        this.region      = region;
        this.clusterName = clusterName;
        this.version     = version;
        this.endPoint    = endPoint;
        this.eksPlatform = eksPlatform;
        this.status      = status;
        this.info        = info;
        this.podName     = podName;
    }

    public String getRegion( ) {
        return (this.region);
    }

    public String getClusterName( ) {
        return (this.clusterName);	
    }

    public String getVersion( ) {
        return (this.version);	
    }

    public String getEndPoint( ) {
        return (this.endPoint);
    }


    public String getEksPlatform( ) {
        return (this.eksPlatform);	
    }

    public String getStatus( ) {
        return (this.status);	
    }

    public String getInfo( ) {
        return (this.info);	
    }

    public String getPodName( ) {		
        return (this.podName);	
    }

    @Override
    public String toString() {
        // TODO Auto-generated method stub
        return "region=" + getRegion( ) + 
            ", ClusterName="+ getClusterName( ) +
            ", version="+ getVersion( ) +
            ", endPoint="+ getEndPoint( ) +
            ", eksPlatform=" + getEksPlatform( ) +
            ", status=" + getStatus( ) +
            ", info=" + getInfo( ) +
            ", podName=" + getPodName( );
    }
}
