<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DdTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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

<c:if test="${param.reportselect=='accounts_alpha'}">
	<sql:query var="result1" dataSource="${dataSource}">
	select account_name from accounts order by account_name
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
</c:if>
 
 <c:if test="${param.reportselect=='accounts_dept'}">
 
	<sql:query var="result2" dataSource="${dataSource}">
	select subdept,account_name from accounts order by subdept
	</sql:query>
	
	<c:set var="rows" value="${result2.rows}" />
		 <table id="t01">
			<tr>
				<th>Department</th>
				<th>Account</th>
 			</tr>
 	<c:forEach items="${rows}" var="temp_row">
 	
		 	<sql:query var="result3" dataSource="${dataSource}">
			select dept_name from sub_department where dept_id=?
			<sql:param value="${temp_row.subdept}" />
			</sql:query>
			<c:set var="subdept" value="${result3.rowsByIndex[0][0]}"/>
	
			<tr>
  				<td id="center"><c:out value="${subdept}"/> </td>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
			 </tr>
 	</c:forEach>
   		</table> 
</c:if>


 <c:if test="${param.reportselect=='accounts_officer'}">
 
	<sql:query var="result4" dataSource="${dataSource}">
	select concerned_officer,account_name from accounts order by concerned_officer
	</sql:query>
	
	<c:set var="rows" value="${result4.rows}" />
		 <table id="t01">
			<tr>
				<th>Officer</th>
				<th>Account</th>
 			</tr>
 	<c:forEach items="${rows}" var="temp_row">
 	
		 	<sql:query var="result5" dataSource="${dataSource}">
			select emp_name from employees where eid=?
			<sql:param value="${temp_row.concerned_officer}" />
			</sql:query>
			<c:set var="officer" value="${result5.rowsByIndex[0][0]}"/>
	
			<tr>
  				<td id="center"><c:out value="${officer}"/> </td>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
			 </tr>
 	</c:forEach>
   		</table> 
</c:if>

<c:if test="${param.reportselect=='accounts_branch'}">
	<sql:query var="result6" dataSource="${dataSource}">
	select l.branch,a.account_name from accounts a full outer join limits l on a.aid=l.aid order by l.branch
	</sql:query>
	<c:set var="rows" value="${result6.rows}" />
		 <table id="t01">
			<tr>
				<th>Branch</th>
				<th>Account</th>
 			</tr>
 	<c:forEach items="${rows}" var="temp_row">
			<tr>
  				<td><c:out value="${temp_row.branch}"/> </td>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
			 </tr>
 	</c:forEach>
   		</table> 
</c:if>


<c:if test="${param.reportselect=='facilities'}">
	<sql:query var="result7" dataSource="${dataSource}">
	select a.account_name,l.facility_name,l.limit from accounts a inner join limits l on a.aid=l.aid order by a.account_name
	</sql:query>
	<c:set var="rows" value="${result7.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
				<th>Facility</th>
				<th>Limit</th>
 			</tr>
 	<c:forEach items="${rows}" var="temp_row">
			<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  				<td id="center"><c:out value="${temp_row.facility_name}"/> </td>
  				<td id="center"><fmt:formatNumber value="${temp_row.limit}" minFractionDigits="2"/></td>
  				
			 </tr>
 	</c:forEach>
   		</table> 
</c:if>


<c:if test="${param.reportselect=='renewaldue'}">

<fmt:parseDate var="parsedSelectDate" parseLocale="en_US"  value="${param.month} ${param.day}, ${param.year}"/>

	<sql:query var="result8" dataSource="${dataSource}">
    
	select a.account_name,l.facility_name,l.limit,l.due_date,f.wc_or_tl from accounts a inner join limits l on a.aid=l.aid inner join facility f on l.facility_name=f.facility_name order by due_date 
	</sql:query>
	<c:set var="rows" value="${result8.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
				<th>Working capital facility</th>
				<th>Limit</th>
				<th>Due date of renewal</th>
				<th>No: of days for renewal</th>
 			</tr>
 	<c:forEach items="${rows}" var="temp_row">
 				<c:if test="${temp_row.wc_or_tl=='Working capital'}">
			<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  				<td id="center"><c:out value="${temp_row.facility_name}"/> </td>
  				<td id="center"><fmt:formatNumber value="${temp_row.limit}" minFractionDigits="2"/></td>
  				<td id="center"><fmt:formatDate value="${temp_row.due_date}" pattern="dd-MM-yyyy"/> </td>
  				
  				<c:set var="datediff" value="${temp_row.due_date.getTime()/86400000 - parsedSelectDate.getTime()/86400000}"></c:set>
  				
  				<td id="center"><fmt:formatNumber value="${datediff}" maxFractionDigits="0"></fmt:formatNumber> </td>
  			
  			</tr>	
  				</c:if>
			 
 	</c:forEach>
   		</table> 
</c:if>


<c:if test="${param.reportselect=='rocpending'}">

<sql:query var="result9" dataSource="${dataSource}">
select a.account_name,l.roc_status from accounts a inner join limits l on a.aid=l.aid order by a.account_name
</sql:query>

<c:set var="rows" value="${result9.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 	<c:forEach items="${rows}" var="temp_row">
 				<c:if test="${temp_row.roc_status=='Pending'}">
			<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  				</tr>	
  				</c:if>
 	</c:forEach>
   		</table>
</c:if>


<c:if test="${param.reportselect=='finer'}">

<sql:query var="result10" dataSource="${dataSource}">
select a.account_name,l.finer from accounts a inner join limits l on a.aid=l.aid order by a.account_name
</sql:query>

<c:set var="rows" value="${result10.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 	<c:forEach items="${rows}" var="temp_row">
 				<c:if test="${temp_row.finer=='Yes'}">
			<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  				</tr>	
  				</c:if>
 	</c:forEach>
   		</table>
</c:if>


<c:if test="${param.reportselect=='roi'}">

<sql:query var="result11" dataSource="${dataSource}">
select a.account_name,l.fb_roi_pct from accounts a inner join limits l on a.aid=l.aid order by a.account_name
</sql:query>

<c:set var="rows" value="${result11.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 	<c:forEach items="${rows}" var="temp_row">
 				<c:if test="${temp_row.fb_roi_pct<=param.highrange && temp_row.fb_roi_pct>=param.lowrange}">
			<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  				</tr>	
  				</c:if>
 	</c:forEach>
   		</table>
</c:if>


<c:if test="${param.reportselect=='excessadhoc'}">

<jsp:useBean id="now" class="java.util.Date" scope="request" />

<sql:query var="result12" dataSource="${dataSource}">
select a.account_name,ea.when_actually_adjusted from accounts a inner join excess_adhoc ea on a.aid=ea.aid order by ea.due_date
</sql:query>

<c:set var="rows" value="${result12.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
 			</tr>
 	<c:forEach items="${rows}" var="temp_row">
 				<c:if test="${temp_row.when_actually_adjusted<=temp_row.availed_on}">
				<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  				</tr>	
  				</c:if>
 	</c:forEach>
   		</table>
</c:if>


<c:if test="${param.reportselect=='pendingproposals'}">

<fmt:parseDate var="parsedSelectDate" parseLocale="en_US"  value="${param.month} ${param.day}, ${param.year}"/>

<sql:query var="result13" dataSource="${dataSource}">
select a.account_name,a.subdept,p.pid,al.facility_name,al.existing_limit,al.proposed_limit,p.receipt_date,p.handling_officer,s.sid from accounts a full outer join proposal  p on a.aid=p.aid full outer join applied_limits al on p.pid=al.pid full outer join sanctions s on p.pid=s.pid order by p.receipt_date
</sql:query>

<c:set var="rows" value="${result13.rows}" />
		 <table id="t01">
			<tr>
				<th>Proposal ID</th>
				<th>Account</th>
				<th>Department</th>
				<th>Handling officer</th>
				<th>Facility||Existing||Proposed</th>
				<th>Date of receipt</th>
				<th>Days pending</th>
				
 			</tr>
 	
 	<c:forEach items="${rows}" var="temp_row">
 	<c:if test="${empty temp_row.sid && not empty temp_row.pid}">
			<tr>
  				<td id="center"><c:out value="${temp_row.pid}"/> </td>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  				
  			<sql:query var="result14" dataSource="${dataSource}">
			select dept_name from sub_department where dept_id=?
			<sql:param value="${temp_row.subdept}" />
			</sql:query>
			<c:set var="subdept" value="${result14.rowsByIndex[0][0]}"/>
			
  				<td id="center"><c:out value="${subdept}"/> </td>
  				
  			<sql:query var="result15" dataSource="${dataSource}">
			select emp_name from employees where eid=?
			<sql:param value="${temp_row.handling_officer}" />
			</sql:query>
			<c:set var="handling_officer" value="${result15.rowsByIndex[0][0]}"/>
			<td id="center"><c:out value="${handling_officer}"/> </td>
			
			<td>
			<table  align="center">
			
			<sql:query var="result16" dataSource="${dataSource}">
			select al.facility_name,al.existing_limit,al.proposed_limit from accounts a inner join proposal  p on a.aid=p.aid inner join applied_limits al on p.pid=al.pid
			</sql:query>
			
				
				<c:forEach items="${result16.rows}" var="temp_facility">
				<tr>
				<td id="center"><c:out value="${temp_facility.facility_name}"/> </td>
				<td id="center"><fmt:formatNumber value="${temp_facility.existing_limit}" minFractionDigits="2"/></td>
				<td id="center"><fmt:formatNumber value="${temp_facility.proposed_limit}" minFractionDigits="2"/></td>
				</tr>
				</c:forEach>
			</table>
			</td>			
  				
  				<td id="center"><fmt:formatDate value="${temp_row.receipt_date}" pattern="dd-MM-yyyy"/> </td>
  				
  				<c:set var="datediff" value="${parsedSelectDate.getTime()/86400000 - temp_row.receipt_date.getTime()/86400000}"></c:set>
  				<td id="center"><fmt:formatNumber value="${datediff}" maxFractionDigits="0"></fmt:formatNumber> </td>
  				
  				</tr>	
  				</c:if>
  		</c:forEach>
  		
 	
   		</table>
</c:if>


<c:if test="${param.reportselect=='sanctions'}">

<fmt:parseDate var="parsedSanctionStartDate" parseLocale="en_US"  value="${param.month1} ${param.day1}, ${param.year1}"/>
<fmt:parseDate var="parsedSanctionEndDate" parseLocale="en_US"  value="${param.month2} ${param.day2}, ${param.year2}"/>

<sql:query var="result17" dataSource="${dataSource}">
select a.account_name,p.pid,al.facility_name,al.existing_limit,al.proposed_limit,al.sanctioned_limit,p.receipt_date,s.sid,s.sanction_date,s.sanction_letter_ref,s.sanction_authority from accounts a inner join proposal  p on a.aid=p.aid inner join applied_limits al on p.pid=al.pid inner join sanctions s on p.pid=s.pid order by p.receipt_date
</sql:query>

<c:set var="rows" value="${result17.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
				<th>Date of receipt of proposal</th>
				<th>Sanction date</th>
				<th>Sanction letter reference</th>
				<th>Sanction authority</th>
				<th>Facility||Existing||Proposed||Sanctioned</th>
				<th>Days for sanction</th>
				
 			</tr>
 	
 	<c:forEach items="${rows}" var="temp_row">
 	<c:if test="${parsedSanctionStartDate<=temp_row.sanction_date && parsedSanctionEndDate>=temp_row.sanction_date}">
			<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  				<td id="center"><fmt:formatDate value="${temp_row.receipt_date}" pattern="dd-MM-yyyy"/> </td>
  				<td id="center"><fmt:formatDate value="${temp_row.sanction_date}" pattern="dd-MM-yyyy"/> </td>
  				<td id="left"><c:out value="${temp_row.sanction_letter_ref}"/> </td>
  				
  			<sql:query var="result18" dataSource="${dataSource}">
			select emp_name from employees where eid=?
			<sql:param value="${temp_row.sanction_authority}" />
			</sql:query>
			<c:set var="sanction_authority" value="${result18.rowsByIndex[0][0]}"/>
			<td id="center"><c:out value="${sanction_authority}"/> </td>
			
			<td>
			<table  align="center">
			
			<sql:query var="result19" dataSource="${dataSource}">
			select al.facility_name,al.existing_limit,al.proposed_limit,al.sanctioned_limit from accounts a inner join proposal  p on a.aid=p.aid inner join applied_limits al on p.pid=al.pid
			</sql:query>
				
				<c:forEach items="${result19.rows}" var="temp_limits">
				<tr>
				<td id="center"><c:out value="${temp_limits.facility_name}"/> </td>
				<td id="center"><fmt:formatNumber value="${temp_limits.existing_limit}" minFractionDigits="2"/></td>
				<td id="center"><fmt:formatNumber value="${temp_limits.proposed_limit}" minFractionDigits="2"/></td>
				<td id="center"><fmt:formatNumber value="${temp_limits.sanctioned_limit}" minFractionDigits="2"/></td>
				</tr>
				</c:forEach>
			</table>
			</td>
			
			<c:set var="datediff" value="${temp_row.sanction_date.getTime()/86400000 - temp_row.receipt_date.getTime()/86400000}"></c:set>
  			<td id="center"><fmt:formatNumber value="${datediff}" maxFractionDigits="0"></fmt:formatNumber> </td>
				
  				</tr>	
  				</c:if>
  		</c:forEach>
  		
 	
   		</table>
</c:if>



<c:if test="${param.reportselect=='consortium_mba'}">

<sql:query var="result20" dataSource="${dataSource}">
select a.aid aid1,a.account_name,b.facility_name, b.type,b.number_banks,b.leader_bank,b.latest_consortium_meeting,b.diligence_report,b.credit_information_exchange from accounts a inner join banking_arrangement b on a.aid=b.aid order by a.account_name
</sql:query>

<c:set var="rows" value="${result20.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
				<th>Banking arrangement</th>
				<th>Leader bank</th>
				<th>Facility</th>
				<th>Bank||Limit||Share(%)</th>
				<th>Latest date of consortium meeting</th>
				<th>Status of diligence report</th>
				<th>Status of information exchange</th>
				
 			</tr>
 	
 	<c:forEach items="${rows}" var="temp_row">
 	<c:if test="${temp_row.type!='Sole banking'}">
			<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  				<td id="center"><c:out value="${temp_row.type}"/> </td>
  				<td id="center"><c:out value="${temp_row.leader_bank}"/> </td>
  				<td id="center"><c:out value="${temp_row.facility_name}"/> </td>
  			
  			<td>
			<table  align="center">
			
			<sql:query var="result21" dataSource="${dataSource}">
			select b.facility_name,s.bank,s.limit,s.share_pct from banking_arrangement b inner join sharing_pattern s on b.bid=s.bid where b.aid=? and b.facility_name=?
			<sql:param value="${temp_row.aid1}" />
			<sql:param value="${temp_row.facility_name}" />
			</sql:query>
				
				<c:forEach items="${result21.rows}" var="temp_ba">
				<tr>
				<td id="center"><c:out value="${temp_ba.bank}"/> </td>
				<td id="center"><fmt:formatNumber value="${temp_ba.limit}" minFractionDigits="2"/></td>
				<td id="center"><fmt:formatNumber value="${temp_ba.share_pct}" minFractionDigits="2"/></td>
				</tr>
				</c:forEach>
			</table>
			</td>
			
  			<td id="center"><fmt:formatDate value="${temp_row.latest_consortium_meeting}" pattern="dd-MM-yyyy"/> </td>
  			<td id="center"><c:out value="${temp_row.diligence_report}"/> </td>
  			<td id="center"><c:out value="${temp_row.credit_information_exchange}"/> </td>
  			
  				</tr>	
  				</c:if>
  		</c:forEach>
  		
 	
   		</table>
</c:if>




<c:if test="${param.reportselect=='insurance_due'}">

<sql:query var="result22" dataSource="${dataSource}">
select a.aid aid1,a.account_name,i.policyid,i.agency,i.sum_assured,i.policy_duedate from accounts a inner join insurance i on a.aid=i.aid order by i.policy_duedate
</sql:query>

<c:set var="rows" value="${result22.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
				<th>Policy ID</th>
				<th>Agency</th>
				<th>Sum assured</th>
				<th>Due date</th>
				<th>Days overdue</th>
 			</tr>
 	
 	<jsp:useBean id="now2" class="java.util.Date" scope="request" />
 	
 	<c:forEach items="${rows}" var="temp_row">
 	<c:if test="${temp_row.policy_duedate<=now2}">
			<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  				<td id="center"><c:out value="${temp_row.policyid}"/> </td>
  				<td id="center"><c:out value="${temp_row.agency}"/> </td>
  				<td id="center"><fmt:formatNumber value="${temp_row.sum_assured}" minFractionDigits="2"/></td>
  				<td id="center"><fmt:formatDate value="${temp_row.policy_duedate}" pattern="dd-MM-yyyy"/> </td>
  				
  			<c:set var="datediff" value="${now2.getTime()/86400000 - temp_row.policy_duedate.getTime()/86400000}"></c:set>
  			<td id="center"><fmt:formatNumber value="${datediff}" maxFractionDigits="0"></fmt:formatNumber> </td>
  				</tr>	
  				</c:if>
  		</c:forEach>
  		
 	
   		</table>
</c:if>



<c:if test="${param.reportselect=='rating_due'}">

<sql:query var="result23" dataSource="${dataSource}">
select a.aid aid1,a.account_name,r.agency,r.facility_name,r.rating,r.basedon_financials,r.basedon_audited,r.due_date from accounts a inner join rating r on a.aid=r.aid order by r.due_date
</sql:query>

<c:set var="rows" value="${result23.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
				<th>Agency</th>
				<th>Facility</th>
				<th>Rating</th>
				<th>based on financials of</th>
				<th>Audited/ Provisional</th>
				<th>Due date</th>
				<th>Days overdue</th>
 			</tr>
 	
 	<jsp:useBean id="now3" class="java.util.Date" scope="request" />
 	
 	<c:forEach items="${rows}" var="temp_row">
 	<c:if test="${temp_row.due_date<=now3}">
			<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  				<td id="center"><c:out value="${temp_row.agency}"/> </td>
  				<td id="center"><c:out value="${temp_row.facility_name}"/> </td>
  				<td id="center"><c:out value="${temp_row.rating}"/> </td>
  				<td id="center"><fmt:formatDate value="${temp_row.basedon_financials}" pattern="dd-MM-yyyy"/> </td>
  				<td id="center"><c:out value="${temp_row.basedon_audited}"/> </td>
  				<td id="center"><fmt:formatDate value="${temp_row.due_date}" pattern="dd-MM-yyyy"/> </td>
  				
  				<c:set var="datediff" value="${now3.getTime()/86400000 - temp_row.due_date.getTime()/86400000}"></c:set>
  				<td id="center"><fmt:formatNumber value="${datediff}" maxFractionDigits="0"></fmt:formatNumber> </td>
  				</tr>	
  				</c:if>
  		</c:forEach>
  		
 	
   		</table>
</c:if>



<c:if test="${param.reportselect=='attendance'}">

<sql:query var="result24" dataSource="${dataSource}">
select a.aid aid1,a.account_name,at.period,at.report_name,at.received_date,at.reviewed_date from accounts a inner join attendance at on a.aid=at.aid order by a.account_name
</sql:query>
<c:set var="rows" value="${result24.rows}" />

<sql:query var="result25" dataSource="${dataSource}">
select aid,account_name from accounts order by account_name
</sql:query>
<c:set var="rows1" value="${result25.rows}" />

<table id="t01">
<tr>
				<th>Account</th>
				<th>Attendance</th>
				</tr>
<c:forEach items="${rows1}" var="temp_account">

<sql:query var="result26" dataSource="${dataSource}">
				select distinct report_name from accounts a inner join attendance at on a.aid=at.aid where at.aid=? order by report_name
				<sql:param value="${temp_account.aid}" />
				</sql:query>
				<c:set var="rows2" value="${result26.rows}" />

	<c:if test="${result26.rowCount>0}">		
			<tr>
			<td id="left"><c:out value="${temp_account.account_name}"/> </td>
			<td>
			
				
					<c:forEach items="${rows2}" var="temp_report">
						<br><c:out value="${temp_report.report_name}"/><br><br>
						<table id="t01">
								<tr>
								<th>for period ended</th>
								<th>Received on</th>
								<th>Reviewed on</th>
								</tr>
								
								<sql:query var="result27" dataSource="${dataSource}">
								select at.period,at.received_date,at.reviewed_date from accounts a inner join attendance at on a.aid=at.aid where at.report_name=? and a.aid=? order by period
								<sql:param value="${temp_report.report_name}" />
								<sql:param value="${temp_account.aid}" />
								</sql:query>
								<c:set var="rows3" value="${result27.rows}" />
								<c:if test="${temp_attd.period>=now3 && temp_attd.period<=now4}">
								<c:forEach items="${rows3}" var="temp_attd">
								<tr>
								<td id="center"><fmt:formatDate value="${temp_attd.period}" pattern="dd-MM-yyyy"/> </td>
								<td id="center"><fmt:formatDate value="${temp_attd.received_date}" pattern="dd-MM-yyyy"/> </td>
								<td id="center"><fmt:formatDate value="${temp_attd.reviewed_date}" pattern="dd-MM-yyyy"/> </td>
								</tr>
								</c:forEach>
								</c:if>
						</table>
					
					<br><br></c:forEach>
				</td>
			</tr>
			</c:if>
</c:forEach>
</table>
</c:if>


<c:if test="${param.reportselect=='pending_issues'}">
	<sql:query var="result28" dataSource="${dataSource}">
	select distinct a.account_name,a.aid from accounts a inner join pending_issues p on a.aid=p.aid order by account_name
	</sql:query>
	<c:set var="rows" value="${result28.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
				<th>Pending issues</th>
 			</tr>
 	<c:forEach items="${rows}" var="temp_row">
			<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  				
  					<td>
  				
  					<sql:query var="result29" dataSource="${dataSource}">
					select p.pending_issue from accounts a inner join pending_issues p on a.aid=p.aid where p.aid=?
					<sql:param value="${temp_row.aid}" />
					</sql:query>
					<c:set var="rows1" value="${result29.rows}" />
  				
  					<table id="t01">
  					<c:forEach items="${rows1}" var="temp_pending">
  					<tr>
  					<td id="left"><c:out value="${temp_pending.pending_issue}"/> </td>
  					</tr>
  					</c:forEach>
  					
  					</table>
  					</td>
  				
			 </tr>
 	</c:forEach>
   		</table> 
</c:if>


<c:if test="${param.reportselect=='decisions'}">

<fmt:parseDate var="parsedDecisionStartDate" parseLocale="en_US"  value="${param.month5} ${param.day5}, ${param.year5}"/>
<fmt:parseDate var="parsedDecisionEndDate" parseLocale="en_US"  value="${param.month6} ${param.day6}, ${param.year6}"/>

<sql:query var="result30" dataSource="${dataSource}">
select a.account_name,d.received_on,d.decision_date,d.letter_ref, d.approving_authority from accounts a inner join decisions d on a.aid=d.aid order by d.received_on
</sql:query>

<c:set var="rows" value="${result30.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
				<th>Date of receipt of request</th>
				<th>Decision date</th>
				<th>Decision letter reference</th>
				<th>Decision authority</th>
				<th>Days for sanction</th>
				
 			</tr>
 	
 	<c:forEach items="${rows}" var="temp_row">
 	<c:if test="${parsedDecisionStartDate<=temp_row.decision_date && parsedDecisionEndDate>=temp_row.decision_date}">
			<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  				<td id="center"><fmt:formatDate value="${temp_row.received_on}" pattern="dd-MM-yyyy"/> </td>
  				<td id="center"><fmt:formatDate value="${temp_row.decision_date}" pattern="dd-MM-yyyy"/> </td>
  				<td id="left"><c:out value="${temp_row.letter_ref}"/> </td>
  				
  			<sql:query var="result31" dataSource="${dataSource}">
			select emp_name from employees where eid=?
			<sql:param value="${temp_row.approving_authority}" />
			</sql:query>
			<c:set var="decision_authority" value="${result31.rowsByIndex[0][0]}"/>
			<td id="center"><c:out value="${decision_authority}"/> </td>
			
			<c:set var="datediff" value="${temp_row.decision_date.getTime()/86400000 - temp_row.received_on.getTime()/86400000}"></c:set>
  			<td id="center"><fmt:formatNumber value="${datediff}" maxFractionDigits="0"></fmt:formatNumber> </td>
				
  				</tr>	
  				</c:if>
  		</c:forEach>
  		
 	
   		</table>
</c:if>


<c:if test="${param.reportselect=='projects'}">
	<sql:query var="result32" dataSource="${dataSource}">
	select distinct a.account_name,a.aid from accounts a inner join projects p on a.aid=p.aid order by account_name
	</sql:query>
	<c:set var="rows" value="${result32.rows}" />
		 <table id="t01">
			<tr>
				<th>Account</th>
				<th>Projects under implementation</th>
 			</tr>
 	<c:forEach items="${rows}" var="temp_row">
			<tr>
  				<td id="left"><c:out value="${temp_row.account_name}"/> </td>
  				
  					<td>
  				
  					<sql:query var="result33" dataSource="${dataSource}">
					select p.project_id,p.description,p.project_cost,p.envisaged_cod,p.npa_trigger_date,p.status,p.remarks from accounts a inner join projects p on a.aid=p.aid where p.aid=?
					<sql:param value="${temp_row.aid}" />
					</sql:query>
					<c:set var="rows1" value="${result33.rows}" />
  				
  					<table id="t01">
  					<tr>
  					<th>Project ID</th>
  					<th>Description</th>
  					<th>Project cost</th>
  					<th>Envisaged DCCO</th>
  					<th>NPA trigger date</th>
  					<th>Project status</th>
  					<th>Remarks</th>
  					</tr>
  					<c:forEach items="${rows1}" var="temp_project">
  					<tr>
  					<td id="left"><c:out value="${temp_project.project_id}"/> </td>
  					<td id="left"><c:out value="${temp_project.description}"/> </td>
  					<td id="center"><fmt:formatNumber value="${temp_project.project_cost}" maxFractionDigits="0"></fmt:formatNumber> </td>
  					<td id="center"><fmt:formatDate value="${temp_project.envisaged_cod}" pattern="dd-MM-yyyy"/> </td>
  					<td id="center"><fmt:formatDate value="${temp_project.npa_trigger_date}" pattern="dd-MM-yyyy"/> </td>
  					<td id="left"><c:out value="${temp_project.status}"/> </td>
  					<td id="left"><c:out value="${temp_project.remarks}"/> </td>
  					</tr>
  					</c:forEach>
  					
  					</table>
  					</td>
  				
			 </tr>
 	</c:forEach>
   		</table> 
</c:if>


<c:if test="${param.reportselect=='mis'}">

<form action="misview.jsp" method="post">
<h3>Select one of the following :</h3>
<input type="radio" name="mis_select" value="takeover"> Takeover<br>
<input type="radio" name="mis_select" value="restructured">Restructured<br>
<input type="radio" name="mis_select" value="cgtmse"> CGTMSE<br>
<input type="radio" name="mis_select" value="pmegp"> PMEGP<br>
<input type="radio" name="mis_select" value="corporateloan"> Corporate loan<br>
<input type="radio" name="mis_select" value="foreigncurrencyloan">Foreign currency loan<br>
<input type="radio" name="mis_select" value="exportcreditlimit">Export credit limit<br>
<input type="radio" name="mis_select" value="pledgeofshares">Pledge of shares<br>
<input type="radio" name="mis_select" value="msmecategory">MSME category <select name="msme">
<option>Micro</option>
<option>Small</option>
<option>Medium</option>
<option selected="selected">Not applicable</option>
</select><br>
 
<input type="radio" name="mis_select" value="compositeloan">Composite loan<br>
<input type="radio" name="mis_select" value="forwardcontract">Forward contract<br>
<input type="radio" name="mis_select" value="buyerscredit">Buyers credit<br>
<input type="radio" name="mis_select" value="foodprocessing">Food processing<br>
<input type="radio" name="mis_select" value="sickunit">Sick unit<br>
<input type="radio" name="mis_select" value="rbidivergent">RBI divergent<br>
<input type="radio" name="mis_select" value="critical">Critical account<br>
<input type="radio" name="mis_select" value="trader">Trader<br>
<input type="radio" name="mis_select" value="retailcreditcategory">Retail credit category<br>
<input type="radio" name="mis_select" value="sodcategory">SOD category <select name="sod">
<option>against real estate to traders</option>
<option>against real estate to contractors</option>
<option>against real estate to builders</option>
<option selected="selected">Not applicable</option>
</select><br>
 
 <input type="radio" name="mis_select" value="lcdevolvements">LC devolvements<br>
 <input type="radio" name="mis_select" value="bginvocations">BG invocations<br>
 <input type="radio" name="mis_select" value="rentreceivables">Loan against rent receivables<br>
 <input type="radio" name="mis_select" value="ricemill">Rice mill<br>
 <input type="radio" name="mis_select" value="commercialrealestate">Commercial real estate<br>
 <input type="radio" name="mis_select" value="hotel">Hotel<br>
 <input type="radio" name="mis_select" value="educationalinstitution">Educational institution<br>
 <input type="radio" name="mis_select" value="publicsectorpsu">Public sector (PSU)<br>
 <input type="radio" name="mis_select" value="creditcardreceivables">Loan against credit card receivables<br>
 <input type="radio" name="mis_select" value="impcustomer">Important customer<br><br>
  
 <input type="submit" name="mis_submit" value="View"/>
</form>


</c:if>
 
<%--  
<sql:query var="result1" dataSource="${dataSource}">
select * from accounts a full outer join limits l on a.aid=l.aid full outer join facility f on l.facility_name=f.facility_name full outer join outstanding o on l.lid=o.lid full outer join excess_adhoc ea on a.aid=ea.aid full outer join banking_arrangement ba on a.aid=ba.aid full outer join sharing_pattern sh on ba.bid=sh.bid full outer join proposal p on a.aid=p.aid full outer join applied_limits al on p.pid=al.pid full outer join sanctions sc on p.pid=sc.pid full outer join declines dc on p.pid=dc.pid full outer join special_conditions sp on sc.sid=sp.sid full outer join security s on a.aid=s.aid full outer join guarantors g on a.aid=g.aid full outer join sub_department sd on a.subdept=sd.dept_id full outer join employees e on sd.dept_id=e.sub_dept full outer join activity act on a.activity_name=act.activity_name full outer join insurance ins on a.aid=ins.aid full outer join rating r on a.aid=r.aid full outer join decisions ds on a.aid=ds.aid full outer join projects pj on a.aid=pj.aid full outer join mis m on a.aid=m.aid full outer join attendance at on a.aid=at.aid full outer join reports rp on at.report_name =rp.report_name full outer join pending_issues pi on a.aid=pi.aid full outer join account_phones ph on a.aid=ph.aid full outer join account_directors dr on a.aid=dr.aid full outer join account_addresses addr on a.aid=addr.aid
</sql:query>
<c:set var="rows" value="${result1.rows}" />

<table id="t01">
<tr>
<th>lid</th>
 </tr>
 <c:forEach items="${rows}" var="temp_row">
<tr>
  <td><c:out value="${temp_row.lid}"/> </td>
 </tr>
 </c:forEach>
 
   </table> --%>
   
   
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

</c:if> --%>
   
   
</body>
</html>