package classpackage;

public class Phones {

	private int phid,aid;
	private String sub_name,phone;
	
	public Phones() {
	    super();
	}
	
	public Phones(int phid,String sub_name, String phone,int aid) {
		this.phid=phid;
		this.sub_name=sub_name;
		this.phone=phone;
		this.aid=aid;
		}

	public int getPhid() {
		return phid;
	}

	public void setPhid(int phid) {
		this.phid = phid;
	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public String getSub_name() {
		return sub_name;
	}

	public void setSub_name(String sub_name) {
		this.sub_name = sub_name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	}
