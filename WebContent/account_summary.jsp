<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

<sql:query var="result1" dataSource="${dataSource}">
select * from accounts where aid=?
<sql:param value="${param.aid}" />
</sql:query>
<c:set var="account" value="${result1.rowsByIndex[0]}" />

<ul id="menu">
<li><a href="#I. General information">I. General information</a></li>
<li><a href="#II. Limits availed">II. Limits availed</a></li>
<li><a href="#III. Proposals submitted">III. Proposals submitted</a></li>
<li><a href="#IV. Monitoring">IV. Monitoring</a></li>
<li><a href="#V. MIS fields">V. MIS fields</a></li>
</ul><br><br>

<a name="I. General information"></a> 
<h2 id="summarymainheadings">I. General information</h2>

											<!-- 1. Brief details -->

<h3 id="summaryheadings">1. Brief details</h3>

<table id="t01" align="center">
            
            <tr>
                <th>Account ID</th>
                <td>${account[0]}</td>
            </tr>
            <tr>
                <th>Name of account</th>
                <td>${account[2]}</td>
            </tr>
            <tr>
                <th>CBS customer ID</th>
                <td>${account[1]}</td>
            </tr>
            <tr>
                <th>Sub-department</th>

<sql:query var="result2" dataSource="${dataSource}">
select dept_name from sub_department where dept_id=?
<sql:param value="${account[3]}" />
</sql:query>
<c:set var="subdept" value="${result2.rowsByIndex[0][0]}" />

                <td>${subdept}</td>
            </tr>
            <tr>
                <th>File number</th>
                <td>${account[4]}</td>
            </tr>
            <tr>
                <th>Powers</th>
                
<sql:query var="result3" dataSource="${dataSource}">
select emp_name from employees where eid=?
<sql:param value="${account[5]}" />
</sql:query>
<c:set var="powers" value="${result3.rowsByIndex[0][0]}" />
                
            <td>${powers}</td>
            </tr>
            <tr>
                <th>Asset classification</th>
                <td>${account[6]}</td>
            </tr>
            <tr>
                <th>Constitution</th>
                <td>${account[7]}</td>
            </tr>
            <tr>
                <th>Chief Executive</th>
                <td>${account[8]}</td>
            </tr>
            <tr>
                <th>Concerned officer</th>
                
<sql:query var="result4" dataSource="${dataSource}">
select emp_name from employees where eid=?
<sql:param value="${account[9]}" />
</sql:query>
<c:set var="concerned_officer" value="${result4.rowsByIndex[0][0]}" />

                <td>${concerned_officer}</td>
            </tr>
            <tr>
                <th>Account status</th>
                <td>${account[10]}</td>
            </tr>
            <tr>
                <th>Activity</th>
                <td>${account[11]}</td>
            </tr>
            <tr>
                <th>Date of incorporation</th>
                
       <fmt:formatDate var="formattedIncorpDate" value="${account[12]}" dateStyle="medium"/>
      
                <td>${formattedIncorpDate}</td>
            </tr>
            <tr>
                <th>Dealing with bank since</th>
                
                <fmt:formatDate var="formattedDealingSice" value="${account[13]}" dateStyle="medium"/>
                
                <td>${formattedDealingSice}</td>
            </tr>
            
            
        </table><br>
        
        <form action="account.jsp" method="post">
        <input type="submit" name="btn_account_summary_account" value="Add / Edit/ Delete" style="float: right;"/><br><br>
        </form>

											<!-- 2. Security -->

<h3 id="summaryheadings">2. Security</h3>

<sql:query var="result5" dataSource="${dataSource}">
select * from security where aid=?
<sql:param value="${param.aid}" />
</sql:query>
<c:set var="security" value="${result5.rows}" />

<table id="t01">
   <tr>
    
    <th>Security ID</th>
    <th>Primary/ Collateral</th> 
    <th>Location</th>
    <th>Description</th>
    <th>Owners</th>
    <th>Value</th>
    <th>Date of valuation</th>
    </tr>
   
   <c:forEach items="${security}" var="temp_security">

   <tr>      
       
       <td><c:out value="${temp_security.scid}"/> </td>
       <td><c:out value="${temp_security.type}"/> </td>
       <td><c:out value="${temp_security.location}"/> </td>
       <td><c:out value="${temp_security.description}"/> </td>
       <td><c:out value="${temp_security.owner}"/> </td>
       <td><c:out value="${temp_security.value}"/> </td>
       <fmt:formatDate var="formattedValuationDate" value="${temp_security.valuation_date}" dateStyle="medium"/>
       <td><c:out value="${formattedValuationDate}"/> </td>
</tr>
</c:forEach>
</table><br>

<form action="security.jsp" method="post">
        <input type="submit" name="btn_account_summary_security" value="Add / Edit/ Delete" style="float: right;"/><br><br>
        </form>
											<!-- 3. Guarantors -->

<h3 id="summaryheadings">3. Guarantors</h3>

<sql:query var="result6" dataSource="${dataSource}">
select * from guarantors where aid=?
<sql:param value="${param.aid}" />
</sql:query>
<c:set var="guarantors" value="${result6.rows}" />

<table id="t01">
   <tr>
    
    <th>Guarantor ID</th> 
    <th>Name</th> 
    <th>Designation</th>
    <th>Networth</th>
    <th>Basis document</th>
    <th>Date of networth</th>
    </tr>
   
   <c:forEach items="${guarantors}" var="temp_guarantor">

   <tr>      
       
       <td><c:out value="${temp_guarantor.gid}"/> </td>
       <td><c:out value="${temp_guarantor.guarantor_name}"/> </td>
       <td><c:out value="${temp_guarantor.designation}"/> </td>
       <td><c:out value="${temp_guarantor.networth}"/> </td>
       <td><c:out value="${temp_guarantor.networth_basis}"/> </td>
       <fmt:formatDate var="formattedNetworthDate" value="${temp_guarantor.networth_date}" dateStyle="medium"/>
       <td><c:out value="${formattedNetworthDate}"/> </td>
</tr>
</c:forEach>
</table><br>

<form action="guarantor.jsp" method="post">
        <input type="submit" name="btn_account_summary_guarantor" value="Add / Edit/ Delete" style="float: right;"/><br><br>
        </form>



											<!-- 4. Credit rating -->

<h3 id="summaryheadings">4. Credit rating</h3>

<sql:query var="result7" dataSource="${dataSource}">
select * from rating where aid=?
<sql:param value="${param.aid}" />
</sql:query>
<c:set var="rating" value="${result7.rows}" />

<table id="t01">
   <tr>
    <th>Rating ID</th>
    <th>Facility</th>
    <th>Rating</th> 
    <th>based on financials dated</th>
    <th>Audited/Provisional</th>
    <th>Valid till</th>
    <th>Rating model</th>
    <th>Agency</th>
    <th>Description</th>
    </tr>
   
   <c:forEach items="${rating}" var="temp_rating">

   <tr>      
       <td><c:out value="${temp_rating.rid}"/> </td>
       <td><c:out value="${temp_rating.facility_name}"/> </td>
       <td><c:out value="${temp_rating.rating}"/> </td>
       <fmt:formatDate var="formattedBasedOnFinancials" value="${temp_rating.basedon_financials}" dateStyle="medium"/>
       <td><c:out value="${formattedBasedOnFinancials}"/> </td>
       <td><c:out value="${temp_rating.basedon_audited}"/> </td>
       <fmt:formatDate var="formattedDueDate" value="${temp_rating.due_date}" dateStyle="medium"/>
       <td><c:out value="${formattedDueDate}"/> </td>
       <td><c:out value="${temp_rating.rating_model}"/> </td>
       <td><c:out value="${temp_rating.agency}"/> </td>
       <td><c:out value="${temp_rating.description}"/> </td>
       
</tr>
</c:forEach>
</table><br>

<form action="rating.jsp" method="post">
        <input type="submit" name="btn_account_summary_rating" value="Add / Edit/ Delete" style="float: right;"/><br><br>
        </form>




											<!-- 5. Insurance -->

<h3 id="summaryheadings">5. Insurance</h3>

<sql:query var="result8" dataSource="${dataSource}">
select * from insurance where aid=?
<sql:param value="${param.aid}" />
</sql:query>
<c:set var="insurance" value="${result8.rows}" />

<table id="t01">
   <tr>
    <th>Policy ID</th>
    <th>Agency</th> 
    <th>Sum assured</th>
    <th>Valid till</th>
    </tr>
   
   <c:forEach items="${insurance}" var="temp_insurance">

   <tr>      
       <td><c:out value="${temp_insurance.policyid}"/> </td>
       <td><c:out value="${temp_insurance.agency}"/> </td>
       <td><c:out value="${temp_insurance.sum_assured}"/> </td>
       <fmt:formatDate var="formattedPolicyDueDate" value="${temp_insurance.policy_duedate}" dateStyle="medium"/>
       <td><c:out value="${formattedPolicyDueDate}"/> </td>
       
</tr>
</c:forEach>
</table><br>

<form action="insurance.jsp" method="post">
        <input type="submit" name="btn_account_summary_insurance" value="Add / Edit/ Delete" style="float: right;"/><br><br>
        </form>


								<!-- 6. Management -->

<h3 id="summaryheadings">6. Management</h3>

<sql:query var="result9" dataSource="${dataSource}">
select * from account_directors where aid=?
<sql:param value="${param.aid}" />
</sql:query>
<c:set var="directors" value="${result9.rows}" />

<table id="t01">
   <tr>
    <th>ID</th>
    <th>Name</th>
    <th>Designation</th> 
    </tr>
   
   <c:forEach items="${directors}" var="temp_director">

   <tr>      
       <td><c:out value="${temp_director.dirid}"/> </td>
       <td><c:out value="${temp_director.director_name}"/> </td>
       <td><c:out value="${temp_director.designation}"/> </td>
       
</tr>
</c:forEach>
</table><br>

<form action="directors.jsp" method="post">
        <input type="submit" name="btn_account_summary_directors" value="Add / Edit/ Delete" style="float: right;"/><br><br>
        </form>


								<!-- 7. Address -->

<h3 id="summaryheadings">7. Address</h3>

<sql:query var="result10" dataSource="${dataSource}">
select * from account_addresses where aid=?
<sql:param value="${param.aid}" />
</sql:query>
<c:set var="address" value="${result10.rows}" />

<table id="t01">
   <tr>
    <th>Address ID</th>
    <th>Description</th>
    <th>Address</th> 
    </tr>
   
   <c:forEach items="${address}" var="temp_address">

   <tr>      
       <td><c:out value="${temp_address.addid}"/> </td>
       <td><c:out value="${temp_address.sub_name}"/> </td>
       <td><c:out value="${temp_address.address}"/> </td>
       
</tr>
</c:forEach>
</table><br>

<form action="addresses.jsp" method="post">
        <input type="submit" name="btn_account_summary_addresses" value="Add / Edit/ Delete" style="float: right;"/><br><br>
        </form>


 								<!-- 8.Phone numbers -->

<h3 id="summaryheadings">8. Phone numbers</h3>

<sql:query var="result11" dataSource="${dataSource}">
select * from account_phones where aid=?
<sql:param value="${param.aid}" />
</sql:query>
<c:set var="phones" value="${result11.rows}" />

<table id="t01">
   <tr>
    <th>Phone ID</th>
    <th>Description</th>
    <th>Phone number</th> 
    </tr>
   
   <c:forEach items="${phones}" var="temp_phone">

   <tr>      
       <td><c:out value="${temp_phone.phid}"/> </td>
       <td><c:out value="${temp_phone.sub_name}"/> </td>
       <td><c:out value="${temp_phone.phone}"/> </td>
       
</tr>
</c:forEach>
</table><br>

<form action="phones.jsp" method="post">
        <input type="submit" name="btn_account_summary_phones" value="Add / Edit/ Delete" style="float: right;"/><br><br>
        </form>

<br><br><hr>

<a name="II. Limits availed"></a> 
<h2 id="summarymainheadings">II. Limits availed</h2>

											<!-- 1. Limits -->

<h3 id="summaryheadings">1. Limits</h3>

<sql:query var="result12" dataSource="${dataSource}">
select * from limits where aid=?
<sql:param value="${param.aid}" />
</sql:query>
<c:set var="limits" value="${result12.rows}" />

<table id="t01">
   <tr>
    <th>Limit ID</th>
    <th>Facility</th>
    <th>Sub-name of facility</th>
    <th>Limit</th>
    <th>CBS no:</th>
    <th>Sanction reference</th>
    <th>Date of sanction</th>
    <th>Due date</th>
    <th>Whether sub-limit</th>
    <th>Branch</th>
    <th>DP/OD</th>
    <th>Status of ROC</th>
    <th>Rate of interest (%) </th>
    <th>Basis</th>
    <th>Spread (%)</th>
    <th>Term premium (%)</th>
    <th>Whether finer rate of interest</th>
    <th>Fee % if non-fund</th>
    <th>Sight or Usance LC</th>
    <th>Period of LC/BG (days)</th>
    
    
     
    </tr>
   
   <c:forEach items="${limits}" var="temp_limit">

   <tr>      
       <td><c:out value="${temp_limit.lid}"/> </td>
       <td><c:out value="${temp_limit.facility_name}"/> </td>
       <td><c:out value="${temp_limit.sub_name}"/> </td>
       <td><c:out value="${temp_limit.limit}"/> </td>
       <td><c:out value="${temp_limit.cbs_no}"/> </td>
       <td><c:out value="${temp_limit.sanction_ref}"/> </td>
       <fmt:formatDate var="formattedSanctionDate" value="${temp_limit.sanction_date}" dateStyle="medium"/>
       <td><c:out value="${formattedSanctionDate}"/> </td>
       <fmt:formatDate var="formattedDueDate" value="${temp_limit.due_date}" dateStyle="medium"/>
       <td><c:out value="${formattedDueDate}"/> </td>
       <td><c:out value="${temp_limit.sub_limit}"/> </td>
       <td><c:out value="${temp_limit.branch}"/> </td>
       <td><c:out value="${temp_limit.dp}"/> </td>
       <td><c:out value="${temp_limit.roc_status}"/> </td>
       <td><c:out value="${temp_limit.fb_roi_pct}"/> </td>
       <td><c:out value="${temp_limit.basis}"/> </td>
       <td><c:out value="${temp_limit.spread_pct}"/> </td>
       <td><c:out value="${temp_limit.term_premium}"/> </td>
       <td><c:out value="${temp_limit.finer}"/> </td>
       <td><c:out value="${temp_limit.nfb_fee_pct}"/> </td>
       <td><c:out value="${temp_limit.sight_or_usance}"/> </td>
       <td><c:out value="${temp_limit.nfb_period}"/> </td>
              
</tr>
</c:forEach>
</table><br>

<form action="limit.jsp" method="post">
        <input type="submit" name="btn_account_summary_limit" value="Add / Edit/ Delete" style="float: right;"/><br><br>
        </form>


								<!-- 2. Excess drawals/ Adhoc limits -->

<h3 id="summaryheadings">2. Excess drawals/ Adhoc limits</h3>

<sql:query var="result13" dataSource="${dataSource}">
select * from excess_adhoc where aid=?
<sql:param value="${param.aid}" />
</sql:query>
<c:set var="excessadhoc" value="${result13.rows}" />

<table id="t01">
   <tr>
    <th>ID</th>
    <th>Facility</th>
    <th>Limit</th>
    <th>Date of availment</th>
    <th>Number of days</th>
    <th>Due date</th>
    <th>Number of times since last renewal</th>
    <th>Date when actually adjusted</th>
    <th>% over regular rate of interest</th>
    <th>Status of ROC</th>
     
    </tr>
   
   <c:forEach items="${excessadhoc}" var="temp_excessadhoc">

   <tr>      
       <td><c:out value="${temp_excessadhoc.eid}"/> </td>
       <td><c:out value="${temp_excessadhoc.type}"/> </td>
       <td><c:out value="${temp_excessadhoc.limit}"/> </td>
       <fmt:formatDate var="formattedAvailedOn" value="${temp_excessadhoc.availed_on}" dateStyle="medium"/>
       <td><c:out value="${formattedAvailedOn}"/> </td>
       <td><c:out value="${temp_excessadhoc.number_of_days}"/> </td>
       <fmt:formatDate var="formattedDueDate" value="${temp_excessadhoc.due_date}" dateStyle="medium"/>
       <td><c:out value="${formattedDueDate}"/> </td>
       <td><c:out value="${temp_excessadhoc.times_since_last_renewal}"/> </td>
       <fmt:formatDate var="formattedWhenActuallyAdjusted" value="${temp_excessadhoc.when_actually_adjusted}" dateStyle="medium"/>
       <td><c:out value="${formattedWhenActuallyAdjusted}"/> </td>
       <td><c:out value="${temp_excessadhoc.pct_over_regular_roi}"/> </td>
       <td><c:out value="${temp_excessadhoc.roc_status}"/> </td>
       
</tr>
</c:forEach>
</table><br>

<form action="excessadhoc.jsp" method="post">
        <input type="submit" name="btn_account_summary_excessadhoc" value="Add / Edit/ Delete" style="float: right;"/><br><br>
        </form>



								<!-- 3. Banking arrangement -->

<h3 id="summaryheadings">3. Banking arrangement</h3>

<sql:query var="result14" dataSource="${dataSource}">
select * from banking_arrangement where aid=?
<sql:param value="${param.aid}" />
</sql:query>
<c:set var="bankingarrangement" value="${result14.rows}" />

<sql:query var="result15" dataSource="${dataSource}">
select * from banking_arrangement b inner join sharing_pattern s on b.bid=s.bid where aid=?
<sql:param value="${param.aid}" />
</sql:query>
<c:set var="sharing" value="${result15.rows}" />

<table id="t01">
   <tr>
    <th>ID</th>
    <th>Facility</th>
    <th>Category</th>
    <th>Number of banks</th>
    <th>Leader bank</th>
    <th>Sharing pattern</th>
    <th>Latest consortium meeting date</th>
    <th>Status of diligence report</th>
    <th>Status of credit information exchange</th>
    </tr>
   
   <c:forEach items="${bankingarrangement}" var="temp_bankingarrangement">

   <tr>      
       <td><c:out value="${temp_bankingarrangement.bid}"/> </td>
       <td><c:out value="${temp_bankingarrangement.facility_name}"/> </td>
       <td><c:out value="${temp_bankingarrangement.type}"/> </td>
       <td><c:out value="${temp_bankingarrangement.number_banks}"/> </td>
      <td><c:out value="${temp_bankingarrangement.leader_bank}"/> </td>
      			<td>
      				<table id="inner">
      					 <tr>
      					 <th>ID</th>
      					 <th>Bank</th>
      					 <th>Limit</th>
      					 <th>Share (%)</th>
      					 </tr>
      					 <c:forEach items="${sharing}" var="temp_sharing">
      					 <tr>
      					 <td><c:out value="${temp_sharing.spid}"/> </td>
      					 <td><c:out value="${temp_sharing.bank}"/> </td>
      					 <td><c:out value="${temp_sharing.limit}"/> </td>
      					 <td><c:out value="${temp_sharing.share_pct}"/> </td>
      					 </tr>
      					 </c:forEach>
      				</table>
      			</td>
       <fmt:formatDate var="formattedConsortiumDate" value="${temp_bankingarrangement.latest_consortium_meeting}" dateStyle="medium"/>
       <td><c:out value="${formattedConsortiumDate}"/> </td>
       <td><c:out value="${temp_bankingarrangement.diligence_report}"/> </td>
       <td><c:out value="${temp_bankingarrangement.credit_information_exchange}"/> </td>
       
</tr>
</c:forEach>
</table><br>

<form action="bankingarrangement.jsp" method="post">
        <input type="submit" name="btn_account_summary_bankingarrangement" value="Banking arrangement : Add / Edit/ Delete" style="float: right;"/><br><br>
        </form>
        
 <form action="sharingpattern.jsp" method="post">
         <input type="submit" name="btn_account_summary_sharingpattern" value="Sharingpattern : Add / Edit/ Delete" style="float: right;"/><br><br>
        </form>

<br><br><hr>

<a name="III. Proposals submitted"></a> 
<h2 id="summarymainheadings">III. Proposals submitted</h2>

											<!-- 1. Proposals -->

<h3 id="summaryheadings">1. Proposals</h3>

<sql:query var="result16" dataSource="${dataSource}">
select * from proposal where aid=?
<sql:param value="${param.aid}" />
</sql:query>
<c:set var="proposal" value="${result16.rows}" />

<sql:query var="result17" dataSource="${dataSource}">
select * from proposal p inner join applied_limits a on p.pid=a.pid where aid=?
<sql:param value="${param.aid}" />
</sql:query>
<c:set var="appliedlimits" value="${result17.rows}" />

<sql:query var="result18" dataSource="${dataSource}">
select * from proposal p inner join sanctions s on p.pid=s.pid where aid=?
<sql:param value="${param.aid}" />
</sql:query>
<c:set var="sanctions" value="${result18.rows}" />

<table id="t01">
   <tr>
    <th>Proposal ID</th>
    <th>Internal number</th>
    <th>Date of receipt</th>
    <th>Handling officer</th>
    <th>Applied limits</th>
    <th>Sanction</th>
     </tr>
   
   <c:forEach items="${proposal}" var="temp_proposal">

   <tr>      
       <td><c:out value="${temp_proposal.pid}"/> </td>
       <td><c:out value="${temp_proposal.internal_number}"/> </td>
       <fmt:formatDate var="formattedReceiptDate" value="${temp_proposal.receipt_date}" dateStyle="medium"/>
       <td><c:out value="${formattedReceiptDate}"/> </td>
		                
		<sql:query var="result17" dataSource="${dataSource}">
		select emp_name from employees where eid=?
		<sql:param value="${temp_proposal.handling_officer}" />
		</sql:query>
		<c:set var="handling_officer" value="${result17.rowsByIndex[0][0]}" />

                <td>${handling_officer}</td>
                <td>
      				<table id="inner">
      					 <tr>
      					 <th>ID</th>
      					 <th>Facility</th>
      					 <th>Existing limit</th>
      					 <th>Proposed limit</th>
      					 <th>Sanctioned limit</th>
      					 </tr>
      					 <c:forEach items="${appliedlimits}" var="temp_appliedlimit">
      					 <tr>
      					 <td><c:out value="${temp_appliedlimit.alid}"/> </td>
      					 <td><c:out value="${temp_appliedlimit.facility_name}"/> </td>
      					 <td><c:out value="${temp_appliedlimit.existing_limit}"/> </td>
      					 <td><c:out value="${temp_appliedlimit.proposed_limit}"/> </td>
      					 <td><c:out value="${temp_appliedlimit.sanctioned_limit}"/> </td>
      					 </tr>
      					 </c:forEach>
      				</table>
      			</td>
      			
      			<td>
      				<table id="inner">
      					 <tr>
      					 <th>ID</th>
      					 <th>Date of sanction</th>
      					 <th>Sanction reference</th>
      					 <th>Sanctioning authority</th>
      					 <th>Reviewing authority</th>
      					 <th>Control form sent on</th>
      					 <th>CMRD queries received on</th>
      					 <th>CMRD reply sent on</th>
      					 <th>Administrative clearance</th>
      					 <th>Confirmation for sanction</th>
      					 
      					 </tr>
      					 <c:forEach items="${sanctions}" var="temp_sanction">
      					 <tr>
      					 <td><c:out value="${temp_sanction.sid}"/> </td>
      					 <fmt:formatDate var="formattedSanctionDate" value="${temp_sanction.sanction_date}" dateStyle="medium"/>
      					 <td><c:out value="${formattedSanctionDate}"/> </td>
      					 <td><c:out value="${temp_sanction.sanction_letter_ref}"/> </td>
      					 
      					 <sql:query var="result18" dataSource="${dataSource}">
						select emp_name from employees where eid=?
						<sql:param value="${temp_sanction.sanction_authority}" />
						</sql:query>
						<c:set var="sanction_authority" value="${result18.rowsByIndex[0][0]}" />

      					 <td><c:out value="${sanction_authority}"/> </td>
      					 
      					 <sql:query var="result19" dataSource="${dataSource}">
						select emp_name from employees where eid=?
						<sql:param value="${temp_sanction.reviewing_authority}" />
						</sql:query>
						<c:set var="review_authority" value="${result19.rowsByIndex[0][0]}" />
						
      					 <td><c:out value="${review_authority}"/> </td>
      					 
      					 <fmt:formatDate var="formattedControlFormSentOn" value="${temp_sanction.control_form_sent_on}" dateStyle="medium"/>
      					 <td><c:out value="${formattedControlFormSentOn}"/> </td>
      					 <fmt:formatDate var="formattedCmrdQueriesReceivedOn" value="${temp_sanction.cmrd_queries_received_on}" dateStyle="medium"/>
      					 <td><c:out value="${formattedCmrdQueriesReceivedOn}"/> </td>
      					 <fmt:formatDate var="formattedCmrdReplySentOn" value="${temp_sanction.cmrd_reply_sent_on}" dateStyle="medium"/>
      					 <td><c:out value="${formattedCmrdReplySentOn}"/> </td>
      					 <td><c:out value="${temp_sanction.admin_clearance}"/> </td>
      					 <td><c:out value="${temp_sanction.confirmation}"/> </td>
      					 </tr>
      					 </c:forEach>
      				</table>
      			</td>              
</tr>
</c:forEach>
</table><br>

<form action="proposal.jsp" method="post">
        <input type="submit" name="btn_account_summary_proposal" value="Proposal : Add / Edit/ Delete" style="float: right;"/><br><br>
        </form>

<form action="appliedlimits.jsp" method="post">
        <input type="submit" name="btn_account_summary_appliedlimits" value="Applied limits : Add / Edit/ Delete" style="float: right;"/><br><br>
        </form>
        
<form action="sanction.jsp" method="post">
        <input type="submit" name="btn_account_summary_sanction" value="Sanction : Add / Edit/ Delete" style="float: right;"/><br><br>
        </form>

											<!-- 2. Decisions -->

<h3 id="summaryheadings">2. Decisions</h3>

<sql:query var="result20" dataSource="${dataSource}">
select * from decisions where aid=?
<sql:param value="${param.aid}" />
</sql:query>
<c:set var="decisions" value="${result20.rows}" />

<table id="t01">
   <tr>
    <th>Decision ID</th>
    <th>Date of receipt</th>
    <th>Date of decision</th>
    <th>Decision letter reference</th>
    <th>Approving authority</th>
    <th>Reviewing authority</th>
    
     </tr>
   
   <c:forEach items="${decisions}" var="temp_decision">

   <tr>      
       <td><c:out value="${temp_decision.did}"/> </td>
       <fmt:formatDate var="formattedDecisionReceivedOn" value="${temp_decision.received_on}" dateStyle="medium"/>
       <td><c:out value="${formattedDecisionReceivedOn}"/> </td>
       <fmt:formatDate var="formattedDecisionDate" value="${temp_decision.decision_date}" dateStyle="medium"/>
       <td><c:out value="${formattedDecisionDate}"/> </td>
       <td><c:out value="${temp_decision.letter_ref}"/> </td>
       
       <sql:query var="result21" dataSource="${dataSource}">
		select emp_name from employees where eid=?
		<sql:param value="${temp_decision.approving_authority}" />
		</sql:query>
		<c:set var="approving_authority" value="${result21.rowsByIndex[0][0]}" />
						
       <td><c:out value="${approving_authority}"/> </td>
       
         <sql:query var="result22" dataSource="${dataSource}">
		select emp_name from employees where eid=?
		<sql:param value="${temp_decision.review_authority}" />
		</sql:query>
		<c:set var="review_authority" value="${result22.rowsByIndex[0][0]}" />
						
       <td><c:out value="${review_authority}"/> </td>
      
	</tr>
	
</c:forEach>
</table><br>

<form action="decision.jsp" method="post">
        <input type="submit" name="btn_account_summary_decision" value="Add / Edit/ Delete" style="float: right;"/><br><br>
        </form>

<br><br><hr>

<a name="IV. Monitoring"></a> 
<h2 id="summarymainheadings">IV. Monitoring</h2>

											<!-- 1. Reports attendance -->

<h3 id="summaryheadings">1. Reports attendance</h3>

<sql:query var="result23" dataSource="${dataSource}">
select * from attendance where aid=?
<sql:param value="${param.aid}" />
</sql:query>
<c:set var="attendance" value="${result23.rows}" />

<table id="t01">
   <tr>
    <th>ID</th>
    <th>Report</th>
    <th>for the period ended</th>
    <th>Date of receipt</th>
    <th>Date of review</th>
    <th>Officer responsible</th>
     </tr>
   
   <c:forEach items="${attendance}" var="temp_attendance">

   <tr>      
       <td><c:out value="${temp_attendance.attdid}"/> </td>
       <td><c:out value="${temp_attendance.report_name}"/> </td>
       <fmt:formatDate var="formattedPeriod" value="${temp_attendance.period}" dateStyle="medium"/>
       <td><c:out value="${formattedPeriod}"/> </td>
       <fmt:formatDate var="formattedAttendanceReceivedOn" value="${temp_attendance.received_date}" dateStyle="medium"/>
       <td><c:out value="${formattedAttendanceReceivedOn}"/> </td>
       <fmt:formatDate var="formattedAttendanceReviewedOn" value="${temp_attendance.reviewed_date}" dateStyle="medium"/>
       <td><c:out value="${formattedAttendanceReviewedOn}"/> </td>
       
       <sql:query var="result24" dataSource="${dataSource}">
		select emp_name from employees where eid=?
		<sql:param value="${temp_attendance.responsible_officer}" />
		</sql:query>
		<c:set var="responsible_officer" value="${result24.rowsByIndex[0][0]}" />
		
		<td><c:out value="${responsible_officer}"/> </td>
		
</tr>
</c:forEach>
</table><br>

<form action="reports.jsp" method="post">
        <input type="submit" name="btn_account_summary_reports" value="Add / Edit/ Delete" style="float: right;"/><br><br>
        </form>


											<!-- 2. Pending issues -->

<h3 id="summaryheadings">2. Pending issues</h3>

<sql:query var="result24" dataSource="${dataSource}">
select * from pending_issues where aid=?
<sql:param value="${param.aid}" />
</sql:query>
<c:set var="pending" value="${result24.rows}" />

<table id="t01">
   <tr>
    <th>Issue no:</th>
    <th>Issue</th>
    </tr>
   
   <c:forEach items="${pending}" var="temp_pending">

   <tr>      
       <td><c:out value="${temp_pending.pi_id}"/> </td>
       <td><c:out value="${temp_pending.pending_issue}"/> </td>
   </tr>
</c:forEach>
</table><br>

<form action="pending.jsp" method="post">
        <input type="submit" name="btn_account_summary_pending" value="Add / Edit/ Delete" style="float: right;"/><br><br>
        </form>



											<!-- 3. Sanction special conditions -->

<h3 id="summaryheadings">3. Sanction special conditions</h3>

<sql:query var="result25" dataSource="${dataSource}">
select * from proposal p inner join sanctions s on p.pid=s.pid inner join special_conditions sc on s.sid=sc.sid where aid=?
<sql:param value="${param.aid}" />
</sql:query>
<c:set var="conditions" value="${result25.rows}" />

<table id="t01">
   <tr>
    
    <th>Special condition no:</th>
    <th>Condition</th>
    </tr>
   
   <c:forEach items="${conditions}" var="temp_condition">

   <tr>      
       <td><c:out value="${temp_condition.cid}"/> </td>
       <td><c:out value="${temp_condition.condition}"/> </td>
   </tr>
</c:forEach>
</table><br>

<form action="specialconditions.jsp" method="post">
        <input type="submit" name="btn_account_summary_specialconditions" value="Add / Edit/ Delete" style="float: right;"/><br><br>
        </form>


				<!-- 4. Projects under implementation -->

<h3 id="summaryheadings">4. Projects under implementation</h3>

<sql:query var="result26" dataSource="${dataSource}">
select * from projects where aid=?
<sql:param value="${param.aid}" />
</sql:query>
<c:set var="projects" value="${result26.rows}" />

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
   
   <c:forEach items="${projects}" var="temp_project">

   <tr>      
       <td><c:out value="${temp_project.project_id}"/> </td>
       <td><c:out value="${temp_project.description}"/> </td>
       <td><c:out value="${temp_project.project_cost}"/> </td>
       <fmt:formatDate var="formattedEnvisagedCod" value="${temp_project.envisaged_cod}" dateStyle="medium"/>
       <td><c:out value="${formattedEnvisagedCod}"/> </td>
       <fmt:formatDate var="formattedNpaTriggerDate" value="${temp_project.npa_trigger_date}" dateStyle="medium"/>
       <td><c:out value="${formattedNpaTriggerDate}"/> </td>
       <td><c:out value="${temp_project.status}"/> </td>
       <td><c:out value="${temp_project.remarks}"/> </td>
       
   </tr>
</c:forEach>
</table><br>

<form action="project.jsp" method="post">
        <input type="submit" name="btn_account_summary_project" value="Add / Edit/ Delete" style="float: right;"/><br><br>
        </form>



<br><br><hr>
<a name="V. MIS fields"></a> 
<h2 id="summarymainheadings">V. MIS fields</h2>

											<!-- 1. MIS fields -->

<h3 id="summaryheadings">1. MIS fields</h3>

<sql:query var="result27" dataSource="${dataSource}">
select * from mis where aid=?
<sql:param value="${param.aid}" />
</sql:query>
<c:set var="mis" value="${result27.rowsByIndex[0]}" />

<table id="t01">
   
            <tr>
                <th>Takeover</th>
                <td>${mis[1]}</td>
            </tr>
            <tr>
                <th>Restructured</th>
                <td>${mis[2]}</td>
            </tr>
            <tr>
                <th>CGTMSE</th>
                <td>${mis[3]}</td>
            </tr>
            <tr>
                <th>PMEGP</th>
                <td>${mis[4]}</td>
            </tr>
            <tr>
                <th>Corporate loan</th>
                <td>${mis[5]}</td>
            </tr>
            <tr>
                <th>Foreign currency loan</th>
                <td>${mis[6]}</td>
            </tr>
            <tr>
                <th>Export credit limit</th>
                <td>${mis[7]}</td>
            </tr>
            <tr>
                <th>Pledge of shares</th>
                <td>${mis[8]}</td>
            </tr>
            <tr>
                <th>MSME category</th>
                <td>${mis[9]}</td>
            </tr>
            <tr>
                <th>Composite loan</th>
                <td>${mis[10]}</td>
            </tr>
            <tr>
                <th>Forward contract</th>
                <td>${mis[11]}</td>
            </tr>
            <tr>
                <th>Buyers credit</th>
                <td>${mis[12]}</td>
            </tr>
            <tr>
                <th>Food processing</th>
                <td>${mis[13]}</td>
            </tr>
            <tr>
                <th>Sick unit</th>
                <td>${mis[14]}</td>
            </tr>
            <tr>
                <th>RBI divergent account</th>
                <td>${mis[15]}</td>
            </tr>
            <tr>
                <th>Critical account</th>
                <td>${mis[16]}</td>
            </tr>
            <tr>
                <th>Trader</th>
                <td>${mis[17]}</td>
            </tr>
            <tr>
                <th>Retail credit</th>
                <td>${mis[18]}</td>
            </tr>
            <tr>
                <th>SOD category</th>
                <td>${mis[19]}</td>
            </tr>
            <tr>
                <th>LC devolvements</th>
                <td>${mis[20]}</td>
            </tr>
            <tr>
                <th>BG invocations</th>
                <td>${mis[21]}</td>
            </tr>
            <tr>
                <th>Loan against rent receivables</th>
                <td>${mis[22]}</td>
            </tr>
            <tr>
                <th>Rice mill</th>
                <td>${mis[23]}</td>
            </tr>
            <tr>
                <th>Commercial real estate</th>
                <td>${mis[24]}</td>
            </tr>
            <tr>
                <th>Hotel</th>
                <td>${mis[25]}</td>
            </tr>
            <tr>
                <th>Educational institution</th>
                <td>${mis[26]}</td>
            </tr>
            <tr>
                <th>Public sector (PSU)</th>
                <td>${mis[27]}</td>
            </tr>
            <tr>
                <th>Loan against credit card receivables</th>
                <td>${mis[28]}</td>
            </tr>
            <tr>
                <th>Important customer</th>
                <td>${mis[29]}</td>
            </tr>
            
</table><br>

<form action="mis.jsp" method="post">
        <input type="submit" name="btn_account_summary_mis" value="Add / Edit/ Delete" style="float: right;"/><br><br>
        </form>



</body>
</html>

