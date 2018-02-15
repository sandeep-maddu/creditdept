package classpackage;

import java.util.Date;

public class Decline {

	private int did,decline_authority,pid;
	private String decline_letter_ref,reasons,report_higher;
	private Date decline_date;
	
	public Decline() {
	    super();
	}
	
	public Decline(int did,Date decline_date,int decline_authority,String decline_letter_ref,String reasons,String report_higher,int pid) {
		this.did=did;
		this.decline_date=decline_date;
		this.decline_authority=decline_authority;
		this.decline_letter_ref=decline_letter_ref;
		this.reasons=reasons;
		this.report_higher=report_higher;
		this.pid=pid;
		
		}

	public int getDid() {
		return did;
	}

	public void setDid(int did) {
		this.did = did;
	}

	public int getDecline_authority() {
		return decline_authority;
	}

	public void setDecline_authority(int decline_authority) {
		this.decline_authority = decline_authority;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public String getDecline_letter_ref() {
		return decline_letter_ref;
	}

	public void setDecline_letter_ref(String decline_letter_ref) {
		this.decline_letter_ref = decline_letter_ref;
	}

	public String getReasons() {
		return reasons;
	}

	public void setReasons(String reasons) {
		this.reasons = reasons;
	}

	public String getReport_higher() {
		return report_higher;
	}

	public void setReport_higher(String report_higher) {
		this.report_higher = report_higher;
	}

	public Date getDecline_date() {
		return decline_date;
	}

	public void setDecline_date(Date decline_date) {
		this.decline_date = decline_date;
	}


}
