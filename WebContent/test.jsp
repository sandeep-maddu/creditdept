<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>


<sql:query var="result" dataSource="${dataSource}">
	
select a.account_name, l.due_date, (${parsedSelectDate} - l.due_date) as age from accounts a inner join limits l on a.aid=l.aid 
</sql:query>

<c:set var="rows" value="${result.rows}" />

		 <table id="t01">
			<tr>
				<th>Account</th>
				<th>Due date of renewal of account</th>
				<th>No: of days overdue for renewal</th>
 			</tr>

<c:forEach items="${rows}" var="temp_row">

	<tr>
	<td><c:out value="${temp_row.account_name}"/> </td>
	<td><fmt:formatDate value="${temp_row.due_date}" dateStyle="medium"/> </td>
	<td><c:out value="${temp_row.age}"/> </td>
 	</tr>	
		 
</c:forEach>
   		</table> 



</body>
</html>