package classpackage;
import java.util.Date;

public class Rating {
	
	private int rid,aid;
	private String agency,facility_name,rating,rating_model,description,basedon_audited;
	private Date basedon_financials,due_date;
	
	public Rating() {
	    super();
	}

	public Rating(int rid,String agency,String facility_name,String rating,String rating_model,String description,Date basedon_financials,String basedon_audited,Date due_date,int aid) {
		this.rid=rid;
		this.aid=aid;
		this.agency=agency;
		this.facility_name=facility_name;
		this.rating=rating;
		this.rating_model=rating_model;
		this.description=description;
		this.basedon_audited=basedon_audited;
		this.basedon_financials=basedon_financials;
		this.due_date=due_date;
		}

	public int getRid() {
		return rid;
	}

	public void setRid(int rid) {
		this.rid = rid;
	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public String getAgency() {
		return agency;
	}

	public void setAgency(String agency) {
		this.agency = agency;
	}

	public String getFacility_name() {
		return facility_name;
	}

	public void setFacility_name(String facility_name) {
		this.facility_name = facility_name;
	}

	public String getRating() {
		return rating;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public String getRating_model() {
		return rating_model;
	}

	public void setRating_model(String rating_model) {
		this.rating_model = rating_model;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getBasedon_audited() {
		return basedon_audited;
	}

	public void setBasedon_audited(String basedon_audited) {
		this.basedon_audited = basedon_audited;
	}

	public Date getBasedon_financials() {
		return basedon_financials;
	}

	public void setBasedon_financials(Date basedon_financials) {
		this.basedon_financials = basedon_financials;
	}

	public Date getDue_date() {
		return due_date;
	}

	public void setDue_date(Date due_date) {
		this.due_date = due_date;
	}

	}
