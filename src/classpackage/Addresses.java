package classpackage;

public class Addresses {

	private int addid,aid;
	private String sub_name,address;
	
	public Addresses() {
	    super();
	}
	
	public Addresses(int addid,String sub_name, String address,int aid) {
		this.addid=addid;
		this.sub_name=sub_name;
		this.address=address;
		this.aid=aid;
		}

	public int getAddid() {
		return addid;
	}

	public void setAddid(int addid) {
		this.addid = addid;
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

		}
