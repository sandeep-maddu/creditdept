package classpackage;
import java.util.Date;

public class Attendance {

	private int attdid,aid,responsible_officer;
	private String report_name;
	private Date period,received_date,reviewed_date;

	public Attendance() {
	    super();
	}
	
	public Attendance(int attdid,Date period,String report_name,int aid,Date received_date,Date reviewed_date,int responsible_officer) {
	this.attdid=attdid;
	this.period=period;
	this.report_name=report_name;
	this.aid=aid;
	this.received_date=received_date;
	this.reviewed_date=reviewed_date;
	this.responsible_officer=responsible_officer;
	
	}

	public int getAttdid() {
		return attdid;
	}

	public void setAttdid(int attdid) {
		this.attdid = attdid;
	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public int getResponsible_officer() {
		return responsible_officer;
	}

	public void setResponsible_officer(int responsible_officer) {
		this.responsible_officer = responsible_officer;
	}

	public String getReport_name() {
		return report_name;
	}

	public void setReport_name(String report_name) {
		this.report_name = report_name;
	}

	public Date getPeriod() {
		return period;
	}

	public void setPeriod(Date period) {
		this.period = period;
	}

	public Date getReceived_date() {
		return received_date;
	}

	public void setReceived_date(Date received_date) {
		this.received_date = received_date;
	}

	public Date getReviewed_date() {
		return reviewed_date;
	}

	public void setReviewed_date(Date reviewed_date) {
		this.reviewed_date = reviewed_date;
	}

		
}