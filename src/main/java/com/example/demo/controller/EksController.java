import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.eks.EksClient;
import software.amazon.awssdk.services.eks.model.Cluster;
import software.amazon.awssdk.services.eks.model.DescribeClusterRequest;
import software.amazon.awssdk.services.eks.model.DescribeClusterResponse;

// import software.amazon.awssdk.services.eks.AmazonEKSClientBuilder;

// import software.amazon.awssdk.http.apache.ApacheHttpClient;
// import software.amazon.awssdk.services.s3.S3Client;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class EksController {

    @GetMapping("/eks-details")
    public String getEksDetails() {
        String aws_region  = System.getenv("REGION");
        String clusterName = System.getenv("CLUSTER_NAME");
        // Initialize EKS client
        EksClient eksClient = EksClient.builder()
                .region(Region.of(aws_region)) // 환경 변수에서 리전 가져오기
                .build();

        // Describe the EKS cluster
        DescribeClusterRequest describeClusterRequest = DescribeClusterRequest.builder()
                .name(clusterName) // 환경 변수에서 클러스터 이름 가져오기
                .build();
        DescribeClusterResponse describeClusterResponse = eksClient.describeCluster(describeClusterRequest);
        Cluster cluster = describeClusterResponse.cluster();

        // Extract relevant information
        // String region = cluster.region();        
        // String availabilityZone = cluster.availabilityZones().get(0);
        String availabilityZone = "";
        clusterName = cluster.name();
        String endpoint    = cluster.endpoint( );
        String platformVersion = cluster.platformVersion();
        // String nodeGroupName = cluster.nodeGroups().get(0).nodegroupName();
        // String autoScalingGroup = cluster.nodeGroups().get(0).autoScalingGroups().get(0);
        String ec2InstanceName = System.getenv("HOSTNAME"); // 현재 Pod의 이름 가져오기

        // Create a JSON response
        return String.format("{\"region\": \"%s\", \"availabilityZone\": \"%s\", \"clusterName\": \"%s\", " +
                "\"nodeGroupName\": \"%s\", \"autoScalingGroup\": \"%s\", \"ec2InstanceName\": \"%s\"}",
                aws_region, availabilityZone, clusterName, endpoint, platformVersion, ec2InstanceName);
    }
}