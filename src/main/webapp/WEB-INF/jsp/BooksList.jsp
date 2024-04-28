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
    <img src="/img/Amazon_Web_Services-Logo.wine.png" width="200"/><img src="/img/Amazon_EKS.png" width="200"/><img src="/img/pod-256.png" width="150"/><img src="/img/springboot-logo.png" width="200"/>
    <!-- <img src="/img/apache_tomcat_logo.png" width="200"/> -->
    <h2>Books(SpringBoot + MariaDB, MyBatis) <a href="/index.html" style="text-decoration:none">Home</a></h2>
    
    <h2> <font color="#ccccc">home</font></h2>    
    <h2> Books(SpringBoot + MariaDB, MyBatis) <a href="/index.html" style="text-decoration:none">Home</a></h2>
    <H2> <font color="#232F3E"><a href="/eks-details.do" style="text-decoration:none">EKS Details</a></font></H2>
    <H2> <font color="#00cccc"><a href="/home.do" style="text-decoration:none">Books Schema</a></font></H2>
    <H2> <font color="#00cccc"><a href="/books.do" style="text-decoration:none">Books</a></font></H2>

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