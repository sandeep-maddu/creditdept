package classpackage;

import java.util.Date;

public class Sanction {

	private int sid,sanction_authority,reviewing_authority,pid;
	private String sanction_letter_ref,admin_clearance,confirmation;
	private Date sanction_date,control_form_sent_on,cmrd_queries_received_on,cmrd_reply_sent_on;
	
	public Sanction() {
	    super();
	}
	
	public Sanction(int sid,Date sanction_date,int sanction_authority,String sanction_letter_ref,int reviewing_authority,Date control_form_sent_on,Date cmrd_queries_received_on,Date cmrd_reply_sent_on,String admin_clearance,String confirmation,int pid) {
		this.sid=sid;
		this.sanction_date=sanction_date;
		this.sanction_authority=sanction_authority;
		this.sanction_letter_ref=sanction_letter_ref;
		this.reviewing_authority=reviewing_authority;
		this.control_form_sent_on=control_form_sent_on;
		this.cmrd_queries_received_on=cmrd_queries_received_on;
		this.cmrd_reply_sent_on=cmrd_reply_sent_on;
		this.admin_clearance=admin_clearance;
		this.confirmation=confirmation;
		this.pid=pid;
		
		}

	public int getSid() {
		return sid;
	}

	public void setSid(int sid) {
		this.sid = sid;
	}

	public int getSanction_authority() {
		return sanction_authority;
	}

	public void setSanction_authority(int sanction_authority) {
		this.sanction_authority = sanction_authority;
	}

	public int getReviewing_authority() {
		return reviewing_authority;
	}

	public void setReviewing_authority(int reviewing_authority) {
		this.reviewing_authority = reviewing_authority;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public String getSanction_letter_ref() {
		return sanction_letter_ref;
	}

	public void setSanction_letter_ref(String sanction_letter_ref) {
		this.sanction_letter_ref = sanction_letter_ref;
	}

	public String getAdmin_clearance() {
		return admin_clearance;
	}

	public void setAdmin_clearance(String admin_clearance) {
		this.admin_clearance = admin_clearance;
	}

	public String getConfirmation() {
		return confirmation;
	}

	public void setConfirmation(String confirmation) {
		this.confirmation = confirmation;
	}

	public Date getSanction_date() {
		return sanction_date;
	}

	public void setSanction_date(Date sanction_date) {
		this.sanction_date = sanction_date;
	}

	public Date getControl_form_sent_on() {
		return control_form_sent_on;
	}

	public void setControl_form_sent_on(Date control_form_sent_on) {
		this.control_form_sent_on = control_form_sent_on;
	}

	public Date getCmrd_queries_received_on() {
		return cmrd_queries_received_on;
	}

	public void setCmrd_queries_received_on(Date cmrd_queries_received_on) {
		this.cmrd_queries_received_on = cmrd_queries_received_on;
	}

	public Date getCmrd_reply_sent_on() {
		return cmrd_reply_sent_on;
	}

	public void setCmrd_reply_sent_on(Date cmrd_reply_sent_on) {
		this.cmrd_reply_sent_on = cmrd_reply_sent_on;
	}
	
	
}
