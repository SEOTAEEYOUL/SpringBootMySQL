<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>MAIN PAGE</title>
</head>
<body>
    <h1>Books(SpringBoot + MariaDB, MyBatis) <a href="/books.do">List</a></h1>
    <H2> <font color="#00cccc">BOOKS</font></H2>
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