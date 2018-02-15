<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ page import="java.util.List" %>
     <%@ page import="classpackage.AccountDao" %>
    <%@ page import="classpackage.Account" %>
    <%@ page import="classpackage.MisDao" %>
    <%@ page import="classpackage.Mis" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Mis</title>
</head>
<body>
<link href="style.css" rel="stylesheet" type="text/css">
<h2><center>MIS</center></h2>
<form action="mis_details.jsp" method="post">

<%AccountDao dao1=new AccountDao();
List<Account> accountlist=dao1.get_all_accounts();
MisDao dao2=new MisDao();
List<Mis> mislist=dao2.get_all_mis();
%>

<b> New entry : </b> <br><br>

Enter account name : <select name="aid">
<%for (int i=0;i<accountlist.size();i++) { %>
<option value="<%=accountlist.get(i).getAid() %>"> <%=accountlist.get(i).getAccount_name()%></option>
<%} %>
</select><br>

Takeover : <select name="takeover">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

Restructured account : <select name="restructured">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

CGTMSE : <select name="cgtmse">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

PMEGP : <select name="pmegp">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

Corporate loan : <select name="corporate_loan">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

Foreign currency loan : <select name="foreign_currency_loan">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

Export credit limit : <select name="export_credit_limit">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

Whether pledge of shares offered as security : <select name="pledge_shares">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

MSME category : <select name="msme_category">
<option>Micro</option>
<option>Small</option>
<option>Medium</option>
<option selected="selected">Not applicable</option>
</select><br>

Composite loan : <select name="composite_loan">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

Forward contract : <select name="forward_contract">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

Buyers credit : <select name="buyers_credit">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

Food processing : <select name="food_processing">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

Sick unit : <select name="sick_unit">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

Is it a RBI divergent account : <select name="rbi_divergent">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

Is it a critical account : <select name="critical_account">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

Trader : <select name="trader">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

Retail credit : <select name="retail_credit_category">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

SOD category : <select name="sod_category">
<option>against real estate to traders</option>
<option>against real estate to contractors</option>
<option>against real estate to builders</option>
<option selected="selected">Not applicable</option>
</select><br>

LC devolvements : <select name="lc_devolvements">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

BG invocations : <select name="bg_invocations">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

Rent receivables : <select name="rent_receivables">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

Rice mill : <select name="rice_mill">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

Is it exposure to commercial real estate : <select name="commercial_real_estate">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

Hotel : <select name="hotel">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

Educational institution : <select name="educational_institution">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

Public sector (PSU) : <select name="public_sector_psu">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

Advance against credit card receivables: <select name="credit_card_receivables">
<option>Yes</option>
<option selected="selected">No</option>
</select><br>

Important customer : <select name="imp_customer">
<option>Yes</option>
<option selected="selected">No</option>
</select><br><br>


<input type="submit" name="btn_mis_add" value="Add" /><br><br>

<b> Edit entry : </b> <br><br>
Select account to be edited : <select name="edit_mis">
<%for (int i=0;i<accountlist.size();i++) { %>
<option value="<%=accountlist.get(i).getAid() %>"> <%=accountlist.get(i).getAccount_name()%></option>
<%} %>
</select><br><br>


<input type="submit" name="btn_mis_edit" value="Edit"><br><br>

<b> Delete entry : </b> <br><br>
Select account to be deleted : <select name="delete_mis">
<%for (int i=0;i<accountlist.size();i++) { %>
<option value="<%=accountlist.get(i).getAid() %>"> <%=accountlist.get(i).getAccount_name()%></option>
<%} %>
</select><br><br>

<input type="submit" name="btn_mis_delete" value="Delete"><br><br>


<b> View all accounts : </b> <br><br>
<input type="submit" name="btn_mis_view" value="View all" /><br><br>
</form>



</body>
</html>