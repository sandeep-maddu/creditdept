package classpackage;

import java.util.Date;

public class Employees {
	private int eid,reports_to,sub_dept;
	private float discretionary_powers;
	private String scale,designation,emp_name;
	private Date hire_date;
	

	public Employees() {
	    super();
	}
	
	public Employees(int eid,int reports_to,float discretionary_powers,int sub_dept,String scale,String designation,String emp_name,Date hire_date) {
	this.eid=eid;
	this.reports_to=reports_to;
	this.discretionary_powers=discretionary_powers;
	this.sub_dept=sub_dept;
	this.scale=scale;
	this.designation=designation;
	this.emp_name=emp_name;
	this.hire_date=hire_date;
	}


	public int getEid() {
		return eid;
	}


	public void setEid(int eid) {
		this.eid = eid;
	}


	public int getReports_to() {
		return reports_to;
	}


	public void setReports_to(int reports_to) {
		this.reports_to = reports_to;
	}


	public float getDiscretionary_powers() {
		return discretionary_powers;
	}


	public void setDiscretionary_powers(float discretionary_powers) {
		this.discretionary_powers = discretionary_powers;
	}


	public int getSub_dept() {
		return sub_dept;
	}


	public void setSub_dept(int sub_dept) {
		this.sub_dept = sub_dept;
	}


	public String getScale() {
		return scale;
	}


	public void setScale(String scale) {
		this.scale = scale;
	}


	public String getDesignation() {
		return designation;
	}


	public void setDesignation(String designation) {
		this.designation = designation;
	}


	public String getEmp_name() {
		return emp_name;
	}


	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}


	public Date getHire_date() {
		return hire_date;
	}


	public void setHire_date(Date hire_date) {
		this.hire_date = hire_date;
	}

}
