package classpackage;

public class Appliedlimits {

	private int alid,pid;
	private float existing_limit,proposed_limit,sanctioned_limit;
	private String facility_name;
	
	public Appliedlimits() {
	    super();
	}
	
	public Appliedlimits(int alid,String facility_name,float existing_limit,float proposed_limit,float sanctioned_limit,int pid) {
		this.alid=alid;
		this.facility_name=facility_name;
		this.existing_limit=existing_limit;
		this.proposed_limit=proposed_limit;
		this.sanctioned_limit=sanctioned_limit;
		this.pid=pid;
		}

	public int getAlid() {
		return alid;
	}

	public void setAlid(int alid) {
		this.alid = alid;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public float getExisting_limit() {
		return existing_limit;
	}

	public void setExisting_limit(float existing_limit) {
		this.existing_limit = existing_limit;
	}

	public float getProposed_limit() {
		return proposed_limit;
	}

	public void setProposed_limit(float proposed_limit) {
		this.proposed_limit = proposed_limit;
	}

	public float getSanctioned_limit() {
		return sanctioned_limit;
	}

	public void setSanctioned_limit(float sanctioned_limit) {
		this.sanctioned_limit = sanctioned_limit;
	}

	public String getFacility_name() {
		return facility_name;
	}

	public void setFacility_name(String facility_name) {
		this.facility_name = facility_name;
	}

	
}
