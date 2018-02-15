<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
      <%@ page import="classpackage.SubDepartmentDao" %>
    <%@ page import="classpackage.SubDepartment" %>
    <%@ page import="java.util.List" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Details of sub-departments</title>


</head>
<link href="style.css" rel="stylesheet" type="text/css">

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />


<jsp:useBean id="subdept" class="classpackage.SubDepartment" scope="request">

<jsp:setProperty property="dept_name" name="subdept" value="${param.add_dept_name}" />
<jsp:setProperty property="hod" name="subdept" value="${param.add_hod}" />
</jsp:useBean>

<c:if test="${param.btn_subdept_add=='Add'}">
<c:if test="${pageContext.request.method=='POST'}">

<%SubDepartmentDao dao1=new SubDepartmentDao();
dao1.add_subdept(subdept); %>

<h3>Insertion of new record successful</h3>
<form action="/creditdept/sub_dept.jsp">
<input type="submit" value="Back" />
</form>
</c:if>
</c:if>


<c:if test="${param.btn_subdept_delete=='Delete'}">
<c:if test="${pageContext.request.method=='POST'}">

<%
String delemp1 = (String) request.getParameter("delete_subdept");
int delemp2=Integer.parseInt(delemp1);
SubDepartmentDao dao2 = new SubDepartmentDao();
dao2.delete_subdept(delemp2);
    %>

<h3>Deletion of record successful</h3>
<form action="/creditdept/sub_dept.jsp">
<input type="submit" value="Back">
</form>
</c:if>
</c:if>



<c:if test="${param.btn_subdept_view=='View all'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao3" class="classpackage.SubDepartmentDao" scope="request">
</jsp:useBean>



<table id="t01">
   <tr>
    <th>Department ID</th>
    <th>Department name</th> 
    <th>Department in-charge</th>
    </tr>
   


   <c:forEach items="${dao3._all_subdepts}" var="tempdept">

<sql:query var="result1" dataSource="${dataSource}">
select emp_name from employees where eid=?
<sql:param value="${tempdept.hod}" />
</sql:query>
<c:set var="hod_name" value="${result1.rowsByIndex[0][0]}" />

   <tr>      
       <td><c:out value="${tempdept.dept_id}"/> </td>
       <td><c:out value="${tempdept.dept_name}"/> </td>
       <td><c:out value="${hod_name}"/> </td>

   </tr>
       
</c:forEach>
   
</table>
<br><br>
<form action="/creditdept/sub_dept.jsp">
<input type="submit" value="Back" />
</form>


</c:if>
</c:if>



<c:if test="${param.btn_subdept_edit=='Edit'}">
<c:if test="${pageContext.request.method=='POST'}">

<jsp:useBean id="dao4" class="classpackage.EmployeesDao" scope="request">
</jsp:useBean>


<sql:query var="result2" dataSource="${dataSource}">
select * from sub_department where dept_id=?
<sql:param value="${param.edit_subdept}" />
</sql:query>
<c:set var="returned_row" value="${result2.rowsByIndex[0]}" />

<form action="edit_subdept.jsp" method="post">

<b> Edit entry : </b> <br><br>

ID of sub-department : <input type="text" readonly name="dept_id" value="${returned_row[0]}"/> (system generated and cannot be edited)<br>
Enter name of sub-department : <input type="text" name="dept_name" value="<c:out value="${returned_row[1]}"/>" /><br>
Enter in-charge of department : <select name="hod">
		<c:forEach items="${dao4._all_employees}" var="tempemp">

        	 <c:if test="${returned_row[2]==tempemp.eid}">
         	 <option value="${tempemp.eid}" selected="selected"> ${tempemp.emp_name} (employee code : ${tempemp.eid}) </option>
         	 </c:if>
          
          	 <c:if test="${returned_row[2]!=tempemp.eid}">
         	 <option value="${tempemp.eid}"> ${tempemp.emp_name} (employee code : ${tempemp.eid})</option>
         	 </c:if>

            </c:forEach>

</select>

<br><br>
<input type="submit" name="edit_submit_button" value="Edit"><br><br>

</form>

</c:if>
</c:if>










</body>
</html>