package classpackage;
import java.util.Date;

public class ExcessAdhoc {
	
	private int eid,aid,number_of_days,times_since_last_renewal ;
	private float limit,pct_over_regular_roi;
	private String type,roc_status;
	private Date availed_on,due_date,when_actually_adjusted;
	
	public ExcessAdhoc() {
	    super();
	}

	public ExcessAdhoc(int eid, int aid, String type, Date availed_on,float limit,int number_of_days,Date due_date,int times_since_last_renewal,Date when_actually_adjusted, float pct_over_regular_roi, String roc_status) {
		this.eid = eid;
		this.aid = aid;
		this.type=type;
		this.number_of_days = number_of_days;
		this.times_since_last_renewal = times_since_last_renewal;
		this.limit = limit;
		this.pct_over_regular_roi = pct_over_regular_roi;
		this.roc_status = roc_status;
		this.availed_on = availed_on;
		this.due_date = due_date;
		this.when_actually_adjusted = when_actually_adjusted;
	}

	public int getEid() {
		return eid;
	}

	public void setEid(int eid) {
		this.eid = eid;
	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
		
	public int getNumber_of_days() {
		return number_of_days;
	}

	public void setNumber_of_days(int number_of_days) {
		this.number_of_days = number_of_days;
	}

	public int getTimes_since_last_renewal() {
		return times_since_last_renewal;
	}

	public void setTimes_since_last_renewal(int times_since_last_renewal) {
		this.times_since_last_renewal = times_since_last_renewal;
	}

	public float getLimit() {
		return limit;
	}

	public void setLimit(float limit) {
		this.limit = limit;
	}

	public float getPct_over_regular_roi() {
		return pct_over_regular_roi;
	}

	public void setPct_over_regular_roi(float pct_over_regular_roi) {
		this.pct_over_regular_roi = pct_over_regular_roi;
	}

	public String getRoc_status() {
		return roc_status;
	}

	public void setRoc_status(String roc_status) {
		this.roc_status = roc_status;
	}

	public Date getAvailed_on() {
		return availed_on;
	}

	public void setAvailed_on(Date availed_on) {
		this.availed_on = availed_on;
	}

	public Date getDue_date() {
		return due_date;
	}

	public void setDue_date(Date due_date) {
		this.due_date = due_date;
	}

	public Date getWhen_actually_adjusted() {
		return when_actually_adjusted;
	}

	public void setWhen_actually_adjusted(Date when_actually_adjusted) {
		this.when_actually_adjusted = when_actually_adjusted;
	}

	}
