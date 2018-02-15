<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>

<sql:setDataSource var="dataSource" driver="oracle.jdbc.driver.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:xe" user="bankloans" password="bankloans"
scope="session" />

<c:if test="${param.mis_submit=='View'}">


<c:if test="${param.mis_select=='takeover'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.takeover='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>



<c:if test="${param.mis_select=='restructured'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.restructured='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>



<c:if test="${param.mis_select=='cgtmse'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.cgtmse='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>


<c:if test="${param.mis_select=='pmegp'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.pmegp='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>


<c:if test="${param.mis_select=='corporateloan'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.corporate_loan='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>


<c:if test="${param.mis_select=='foreigncurrencyloan'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.foreign_currency_loan='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>



<c:if test="${param.mis_select=='exportcreditlimit'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.export_credit_limit='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>



<c:if test="${param.mis_select=='pledgeofshares'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.pledge_shares='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>


<c:if test="${param.mis_select=='msmecategory'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.msme_category=?
<sql:param value="${param.msme}" />
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>


<c:if test="${param.mis_select=='compositeloan'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.composite_loan='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>



<c:if test="${param.mis_select=='forwardcontract'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.forward_contract='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>


<c:if test="${param.mis_select=='buyerscredit'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.buyers_credit='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>



<c:if test="${param.mis_select=='foodprocessing'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.food_processing='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>


<c:if test="${param.mis_select=='sickunit'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.sick_unit='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>


<c:if test="${param.mis_select=='rbidivergent'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.rbi_divergent='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>


<c:if test="${param.mis_select=='critical'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.critical_account='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>


<c:if test="${param.mis_select=='trader'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.trader='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>


<c:if test="${param.mis_select=='retailcreditcategory'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.retail_credit_category='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>


<c:if test="${param.mis_select=='sodcategory'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.sod_category=?
<sql:param value="${param.sod}" />
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>

<c:if test="${param.mis_select=='lcdevolvements'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.lc_devolvements='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>



<c:if test="${param.mis_select=='bginvocations'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.bg_invocations='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>



<c:if test="${param.mis_select=='rentreceivables'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.rent_receivables='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>


<c:if test="${param.mis_select=='ricemill'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.rice_mill='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>


<c:if test="${param.mis_select=='commercialrealestate'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.commercial_real_estate='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>



<c:if test="${param.mis_select=='hotel'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.hotel='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>


<c:if test="${param.mis_select=='educationalinstitution'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.educational_institution='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>



<c:if test="${param.mis_select=='publicsectorpsu'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.public_sector_psu='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>



<c:if test="${param.mis_select=='creditcardreceivables'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.credit_card_receivables='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>



<c:if test="${param.mis_select=='impcustomer'}">
<sql:query var="result" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where m.imp_customer='Yes'
</sql:query>
<c:set var="rows" value="${result.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 					<c:forEach items="${rows}" var="temp_row">
					<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  					</tr>
  					</c:forEach>
  		</table>
</c:if>


































<%-- 
<sql:query var="result1" dataSource="${dataSource}">
select a.account_name from accounts a inner join mis m on a.aid=m.aid where takeover=? and restructured=? and cgtmse=? and pmegp=? and corporate_loan=? and foreign_currency_loan=? and export_credit_limit=? and pledge_shares=? and msme_category=? and composite_loan=? and forward_contract=? and buyers_credit=? and food_processing=? and sick_unit=? and rbi_divergent=? and critical_account=? and trader=? and retail_credit_category=? and sod_category=? and lc_devolvements=? and bg_invocations=? and rent_receivables=? and rice_mill=? and commercial_real_estate=? and hotel=? and educational_institution=? and public_sector_psu=? and credit_card_receivables=? and imp_customer=?
<sql:param value="${param.takeover}" />
<sql:param value="${param.restructured}" />
<sql:param value="${param.cgtmse}" />
<sql:param value="${param.pmegp}" />
<sql:param value="${param.corporate_loan}" />
<sql:param value="${param.foreign_currency_loan}" />
<sql:param value="${param.export_credit_limit}" />
<sql:param value="${param.pledge_shares}" />
<sql:param value="${param.msme_category}" />
<sql:param value="${param.composite_loan}" />
<sql:param value="${param.forward_contract}" />
<sql:param value="${param.buyers_credit}" />
<sql:param value="${param.food_processing}" />
<sql:param value="${param.sick_unit}" />
<sql:param value="${param.rbi_divergent}" />
<sql:param value="${param.critical_account}" />
<sql:param value="${param.trader}" />
<sql:param value="${param.retail_credit_category}" />
<sql:param value="${param.sod_category}" />
<sql:param value="${param.lc_devolvements}" />
<sql:param value="${param.bg_invocations}" />
<sql:param value="${param.rent_receivables}" />
<sql:param value="${param.rice_mill}" />
<sql:param value="${param.commercial_real_estate}" />
<sql:param value="${param.hotel}" />
<sql:param value="${param.educational_institution}" />
<sql:param value="${param.public_sector_psu}" />
<sql:param value="${param.credit_card_receivables}" />
<sql:param value="${param.imp_customer}" />
</sql:query>
<c:set var="rows" value="${result1.rows}" />

	 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 	<c:forEach items="${rows}" var="temp_row">
			<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
			 </tr>
 	</c:forEach>
   		</table>
--%>


</c:if> 
</body>
</html>