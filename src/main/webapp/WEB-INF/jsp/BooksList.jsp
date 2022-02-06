<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
 
<!-- %=request.getAttribute("list") % -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SpringBoot + MariaDB</title>
</head>
<body>
    <h1> <font color="#ccccc">Books(SpringBoot + MariaDB, MyBatis) <a href="/home.do">Main</a></font></h1>
    <H2> <font color="#00cccc">BOOKS</font></H2>
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