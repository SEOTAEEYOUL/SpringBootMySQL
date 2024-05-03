<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
 
<!-- %=request.getAttribute("list") % -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
<title>SpringBoot + AWS EKS + AuroraMyDB</title>
<link rel="icon" type="image/x-icon" href="/ico/favicon.ico">
<style>
    table {
        /* width: 50%; */
        border-collapse: collapse;
    }

    th, td {
        padding: 8px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    th {
        background-color: #f2f2f2;
    }
</style>
</head>
<body>
    <img src="/img/Amazon_Web_Services-Logo.wine.png" width="200"/><img src="/img/kubernetes.512x499.png" width="150"/><img src="/img/pod-256.png" width="150"/><img src="/img/springboot-logo.png" width="200"/>
    <!-- <img src="/img/apache_tomcat_logo.png" width="200"/> -->
    
    <h2> <font color="#ccccc">home</font></h2>
    <h2> Books(SpringBoot + MariaDB, MyBatis) <a href="/index.html" style="text-decoration:none">Home</a></h2>
    <H1> <font color="#00cccc">EKS Details</font></H1>
    <H2> <font color="#00cccc"><a href="/home.do" style="text-decoration:none">Books Schema</a></font></H2>
    <H2> <font color="#00cccc"><a href="/books.do" style="text-decoration:none">Books</a></font></H2>

    <table>
        <tr>
            <th>사용자 IP 주소</th>
            <td>
                <div style="font-weight: bold; font-size: larger; border: 1px solid black; padding: 5px;">
                    ${metaData.remoteAddr}
                </div>
            </td>
        </tr>
        <tr>
            <th>EC2 인스턴스 ID</th>
            <td>
                <div style="font-weight: bold; font-size: larger; border: 1px solid black; padding: 5px;">
                    ${metaData.instanceId}
                </div>
            </td>
        </tr>
        <tr>
            <th>가용 영역</th>
            <td>
                <div style="font-weight: bold; font-size: larger; border: 1px solid black; padding: 5px;">
                    ${metaData.zone}
                </div>                    
            </td>
        </tr>
    </table>

    <H2> <font color="#cccc00">Information</font></H2>
    <table>
        <tr>
            <th><font color="#cccccc">springframework boot version</font></th>
            <td><font color="#cccccc"><% String version = org.springframework.core.SpringVersion.getVersion( ); %><%=version%></font></td>
        </tr>
    </table>
</body>
</html>