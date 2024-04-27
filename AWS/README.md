# AWS  

> [AWS Developer Tools Blog - Category: Java](https://aws.amazon.com/ko/blogs/developer/category/programing-language/java/)  
> [Introducing a new client in the AWS SDK for Java 2.x for retrieving EC2 Instance Metadata](https://aws.amazon.com/ko/blogs/developer/introducing-a-new-client-in-the-aws-sdk-for-java-2-x-for-retrieving-ec2-instance-metadata/)  
> [Get started with the AWS SDK for Java 2.x](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/get-started.html)  
> [Developer Guide - AWS SDK for Java 2.x](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/home.html)  
> [AWS SDK를 사용한 Amazon EKS용 코드 예제](https://docs.aws.amazon.com/ko_kr/code-library/latest/ug/eks_code_examples.html)  
> [AWS SDK Code Examples](https://github.com/awsdocs/aws-doc-sdk-examples?tab=readme-ov-file)  
> [EKS Pod Identity 작동 방식](https://docs.aws.amazon.com/ko_kr/eks/latest/userguide/pod-id-how-it-works.html)  
> [Amazon EKS에서 관리형 서비스를 활용하여 Spring Boot 애플리케이션 관찰 가능성(Observability) 구성하기](https://aws.amazon.com/ko/blogs/tech/springboot-application-observability-using-amazon-eks/)  
> [OpenTelemetry Instrumentation for Java](https://github.com/open-telemetry/opentelemetry-java-instrumentation)  

## 0. Maven Depedency
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~ Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
  ~
  ~ Licensed under the Apache License, Version 2.0 (the "License").
  ~ You may not use this file except in compliance with the License.
  ~ A copy of the License is located at
  ~
  ~  http://aws.amazon.com/apache2.0
  ~
  ~ or in the "license" file accompanying this file. This file is distributed
  ~ on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
  ~ express or implied. See the License for the specific language governing
  ~ permissions and limitations under the License.
  -->

<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <parent>
        <artifactId>core</artifactId>
        <groupId>software.amazon.awssdk</groupId>
        <version>2.20.15</version>
    </parent>
    <modelVersion>4.0.0</modelVersion>
    <artifactId>imds</artifactId>
    <name>AWS Java SDK :: Core :: Imds</name>
    <url>https://aws.amazon.com/sdkforjava</url>

    <dependencies>
        <dependency>
            <groupId>software.amazon.awssdk</groupId>
            <artifactId>annotations</artifactId>
            <version>${awsjavasdk.version}</version>
        </dependency>
        <dependency>
            <groupId>software.amazon.awssdk</groupId>
            <artifactId>http-client-spi</artifactId>
            <version>${awsjavasdk.version}</version>
            <scope>compile</scope>
        </dependency>
        <dependency>
            <groupId>software.amazon.awssdk</groupId>
            <artifactId>utils</artifactId>
            <version>${awsjavasdk.version}</version>
            <scope>compile</scope>
        </dependency>
        <dependency>
            <groupId>software.amazon.awssdk</groupId>
            <artifactId>json-utils</artifactId>
            <version>${awsjavasdk.version}</version>
            <scope>compile</scope>
        </dependency>
        <dependency>
            <groupId>software.amazon.awssdk</groupId>
            <artifactId>third-party-jackson-core</artifactId>
            <version>${awsjavasdk.version}</version>
            <scope>compile</scope>
        </dependency>
        <dependency>
            <groupId>software.amazon.awssdk</groupId>
            <artifactId>profiles</artifactId>
            <version>${awsjavasdk.version}</version>
            <scope>compile</scope>
        </dependency>
        <dependency>
            <groupId>org.assertj</groupId>
            <artifactId>assertj-core</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.mockito</groupId>
            <artifactId>mockito-core</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>software.amazon.awssdk</groupId>
            <artifactId>url-connection-client</artifactId>
            <version>${awsjavasdk.version}</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>nl.jqno.equalsverifier</groupId>
            <artifactId>equalsverifier</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>software.amazon.awssdk</groupId>
            <artifactId>sdk-core</artifactId>
            <version>${awsjavasdk.version}</version>
            <scope>compile</scope>
        </dependency>
        <dependency>
            <groupId>com.github.tomakehurst</groupId>
            <artifactId>wiremock-jre8</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>software.amazon.awssdk</groupId>
            <artifactId>test-utils</artifactId>
            <version>${awsjavasdk.version}</version>
            <scope>test</scope>
            <exclusions>
                <exclusion>
                    <groupId>junit</groupId>
                    <artifactId>junit</artifactId>
                </exclusion>
                <exclusion>
                    <groupId>org.junit.vintage</groupId>
                    <artifactId>junit-vintage-engine</artifactId>
                </exclusion>
            </exclusions>
        </dependency>
        <dependency>
            <groupId>software.amazon.awssdk</groupId>
            <artifactId>netty-nio-client</artifactId>
            <version>${awsjavasdk.version}</version>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-jar-plugin</artifactId>
                <configuration>
                    <archive>
                        <manifestEntries>
                            <Automatic-Module-Name>software.amazon.awssdk.imds</Automatic-Module-Name>
                        </manifestEntries>
                    </archive>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
```

## 1. Pod 이름

```java
String podName = System.getenv("HOSTNAME");
```

## 2. EC2 인스턴스 이름 
```java
String ec2InstanceName = System.getenv("MY_POD_NAME");
```

## 3. Subnet, Node Group, 클러스터명, 가용 영역 (AZ), Region, 버전 등
```java
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PodController {

    @GetMapping("/pod-details")
    public String getPodDetails() {
        // Get the pod name from the environment variable HOSTNAME
        String podName = System.getenv("HOSTNAME");

        // You can also get other details like EC2 instance name, subnet, node group, cluster name, etc.
        // by querying the Kubernetes API or using other environment variables

        // For example, to get the EC2 instance name, you can use:
        // String ec2InstanceName = System.getenv("MY_POD_NAME");

        // Return the pod details as a JSON response
        return "{\"podName\": \"" + podName + "\"}";
    }
}
```

#### application.properties
```
aws.region_name="ap-northeast2-a"
aws.eks.cluster_name="sksh-argos-d-oss-ui-01"
```

```java
import com.amazonaws.auth.DefaultAWSCredentialsProviderChain;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.eks.AmazonEKS;
import com.amazonaws.services.eks.AmazonEKSClientBuilder;
import com.amazonaws.services.eks.model.Cluster;
import com.amazonaws.services.eks.model.DescribeClusterRequest;
import com.amazonaws.services.eks.model.DescribeClusterResult;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class EksController {

    @GetMapping("/eks-details")
    public String getEksDetails() {
        // Initialize Amazon EKS client
        AmazonEKS eksClient = AmazonEKSClientBuilder.standard()
                .withRegion(Regions.YOUR_REGION) // 귀하의 원하는 리전으로 변경하세요
                .withCredentials(new DefaultAWSCredentialsProviderChain())
                .build();

        // Describe the EKS cluster
        DescribeClusterRequest describeClusterRequest = new DescribeClusterRequest()
                .withName("your-cluster-name"); // 귀하의 클러스터 이름으로 변경하세요
        DescribeClusterResult describeClusterResult = eksClient.describeCluster(describeClusterRequest);
        Cluster cluster = describeClusterResult.getCluster();

        // Extract relevant information
        String region = cluster.getRegion();
        String availabilityZone = cluster.getAvailabilityZones().get(0);
        String clusterName = cluster.getName();
        String nodeGroupName = cluster.getNodeGroups().get(0).getNodegroupName();
        String autoScalingGroup = cluster.getNodeGroups().get(0).getAutoScalingGroups().get(0);
        String ec2InstanceName = System.getenv("HOSTNAME"); // 현재 Pod의 이름을 가져옵니다.

        // Create a JSON response
        return String.format("{\"region\": \"%s\", \"availabilityZone\": \"%s\", \"clusterName\": \"%s\", " +
                "\"nodeGroupName\": \"%s\", \"autoScalingGroup\": \"%s\", \"ec2InstanceName\": \"%s\"}",
                region, availabilityZone, clusterName, nodeGroupName, autoScalingGroup, ec2InstanceName);
    }
}
```

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "eks:DescribeCluster",
                "eks:ListClusters",
                "ec2:DescribeInstances"
            ],
            "Resource": "*"
        }
        # 다른 권한이 필요한 경우 여기에 추가하세요
    ]
}
```