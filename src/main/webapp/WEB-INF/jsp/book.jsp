<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>MAIN PAGE</title>
<!-- link rel="icon" type="image/x-icon" href="/favicon.ico" -->
<link rel="icon" type="image/x-icon" href="/ico/favicon.ico">
</head>
<body>
    <img src="/img/apache_tomcat_logo.png" width="200"/><img src="/img/springboot-logo.png" width="200"/>
    <h2>Books(SpringBoot + MariaDB, MyBatis) <a href="/index.html" style="text-decoration:none">Home</a></h2>
    <H1> <font color="#00cccc">Books Schema</font></H1>
    <H2> <font color="#00cccc"><a href="/books.do" style="text-decoration:none">Books</a></font></H2>

    <table>
    <tr>
    <th>Name</th>
    <th>Property</th>
    <th>Length</th>
    </tr>
    <tr> <td> seqNo </td><td> int </td><td>4 Byte, -2,147,483,648 ~ 2,147,483,647</td> </tr>
    <tr> <td> title </td><td> string </td><td>80</td> </tr>
    <tr> <td> author </td><td> string </td><td>40</td> </tr>
    <tr> <td> published_date </td><td> Date </td><td>yyyy-MM-dd</td></tr>
    <tr> <td> price </td><td> double </td><td>8 byte, (+/-)4.9E-324 ~ (+/-)1.7976931348623157E308</td></tr>
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