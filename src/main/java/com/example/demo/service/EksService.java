package com.example.demo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dto.EksDTO;

import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.eks.EksClient;
import software.amazon.awssdk.services.eks.model.Cluster;
import software.amazon.awssdk.services.eks.model.DescribeClusterRequest;
import software.amazon.awssdk.services.eks.model.DescribeClusterResponse;

@Service
public class EksService {	
    public EksDTO getEksDetail( ) throws Exception {

        String aws_region  = System.getenv("REGION");
        String clusterName = System.getenv("CLUSTER_NAME");

        System.out.println("aws_region[" + aws_region + "]");
        System.out.println("clusterName[" + clusterName + "]");
        // Initialize EKS client
        EksClient eksClient = EksClient.builder( )
                .region(Region.of(aws_region)) // 환경 변수에서 리전 가져오기
                .build();

        // Describe the EKS cluster
        DescribeClusterRequest describeClusterRequest = DescribeClusterRequest.builder( )
                .name(clusterName) // 환경 변수에서 클러스터 이름 가져오기
                .build();
        DescribeClusterResponse describeClusterResponse = eksClient.describeCluster(describeClusterRequest);
        Cluster cluster = describeClusterResponse.cluster();

        // Extract relevant information
        // String region = cluster.region();        
        // String availabilityZone = cluster.availabilityZones().get(0);
        clusterName            = cluster.name ();
        String version         = cluster.version( );
        String endpoint        = cluster.endpoint( );
        String platformVersion = cluster.platformVersion( );
        String status          = cluster.statusAsString( );
        // String nodeGroupName = cluster.nodeGroups().get(0).nodegroupName();
        // String autoScalingGroup = cluster.nodeGroups().get(0).autoScalingGroups().get(0);
        String podName = System.getenv("HOSTNAME"); // 현재 Pod의 이름 가져오기


	    EksDTO eksDto = new EksDTO(aws_region, clusterName, version, endpoint, platformVersion, status, podName);

        return (eksDto);
	}
}