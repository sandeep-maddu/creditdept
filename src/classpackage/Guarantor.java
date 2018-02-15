package classpackage;
import java.util.Date;

public class Guarantor {
	
	private int gid,aid;
	private float networth;
	private String guarantor_name,designation,networth_basis;
	private Date networth_date;
	
	public Guarantor() {
	    super();
	}

	public Guarantor(int gid, int aid,  String guarantor_name, String designation, float networth, String networth_basis,Date networth_date) {
		this.gid = gid;
		this.aid = aid;
		this.guarantor_name = guarantor_name;
		this.designation = designation;
		this.networth = networth;
		this.networth_basis = networth_basis;
		this.networth_date = networth_date;
	}

	public int getGid() {
		return gid;
	}

	public void setGid(int gid) {
		this.gid = gid;
	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public float getNetworth() {
		return networth;
	}

	public void setNetworth(float networth) {
		this.networth = networth;
	}

	public String getGuarantor_name() {
		return guarantor_name;
	}

	public void setGuarantor_name(String guarantor_name) {
		this.guarantor_name = guarantor_name;
	}

	public String getDesignation() {
		return designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}

	public String getNetworth_basis() {
		return networth_basis;
	}

	public void setNetworth_basis(String networth_basis) {
		this.networth_basis = networth_basis;
	}

	public Date getNetworth_date() {
		return networth_date;
	}

	public void setNetworth_date(Date networth_date) {
		this.networth_date = networth_date;
	}

	
}
