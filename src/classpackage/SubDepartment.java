package classpackage;

public class SubDepartment {
	
	private int dept_id,hod;
	private String dept_name;
	
	public SubDepartment() {
	    super();
	}
	
	public SubDepartment(int dept_id,String dept_name,int hod) {
	this.dept_id=dept_id;
	this.dept_name=dept_name;
	this.hod=hod;
	}


	public int getDept_id() {
		return dept_id;
	}


	public void setDept_id(int dept_id) {
		this.dept_id = dept_id;
	}


	public int getHod() {
		return hod;
	}


	public void setHod(int hod) {
		this.hod = hod;
	}


	public String getDept_name() {
		return dept_name;
	}


	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	
}
