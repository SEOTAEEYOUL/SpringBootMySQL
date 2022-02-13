<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
 
<!-- %=request.getAttribute("list") % -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SpringBoot + MariaDB</title>
<link rel="icon" type="image/x-icon" href="/ico/favicon.ico">
</head>
<body>
    <img src="/img/apache_tomcat_logo.png" width="200"/><img src="/img/springboot-logo.png" width="200"/><img src="/img/mybatis-logo.jpg" width="120"/><img src="/img/mysql_logo.png" width="150"/>
    
    <h2> <font color="#ccccc">home</font></h2>    
    <h2> Books(SpringBoot + MariaDB, MyBatis) <a href="/index.html" style="text-decoration:none">Home</a></h2>
    <H2> <font color="#00cccc"><a href="/home.do" style="text-decoration:none">Books Schema</a></font></H2>
    <H1> <font color="#00cccc">BOOKS</font></H1>

    <table>
        <tr>
            <th>No</th>
            <th>Title</th>
            <th>Author</th>
            <th>Published Date</th>
            <th>Price</th>
        </tr>
 
    <!-- 
 	private String title;
	private String author;
	private Date published_date;
     -->
        <c:forEach var="book" items="${list}">
            <tr>
                <td><p>${book.seqNo}</p></td>
                <td><p>${book.title}</p></td>
                <td><p>${book.author}</p></td>
                <td><p>${book.published_Date}</p></td>
                <td><p>${book.price}</p></td>
            </tr>
        </c:forEach>
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