package classpackage;
import java.util.Date;

public class Proposal {

	private int pid, aid, handling_officer;
	private String internal_number;
	private Date receipt_date;
	
	public Proposal() {
	    super();
	}
	
	public Proposal(int pid,String internal_number,Date receipt_date,int aid,int handling_officer) {
		this.pid=pid;
		this.internal_number=internal_number;
		this.receipt_date=receipt_date;
		this.aid=aid;
		this.handling_officer=handling_officer;
		}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public int getHandling_officer() {
		return handling_officer;
	}

	public void setHandling_officer(int handling_officer) {
		this.handling_officer = handling_officer;
	}

	public String getInternal_number() {
		return internal_number;
	}

	public void setInternal_number(String internal_number) {
		this.internal_number = internal_number;
	}

	public Date getReceipt_date() {
		return receipt_date;
	}

	public void setReceipt_date(Date receipt_date) {
		this.receipt_date = receipt_date;
	}

}

