package classpackage;
import java.util.Date;

public class Project {
	
	private int project_id,aid;
	private float project_cost;
	private String description,status,remarks;
	private Date envisaged_cod,npa_trigger_date;
	
	public Project() {
	    super();
	}

	public Project(int project_id, int aid, String description, float project_cost, Date envisaged_cod, Date npa_trigger_date,String status, String remarks) {
		this.project_id = project_id;
		this.aid = aid;
		this.project_cost = project_cost;
		this.description = description;
		this.status = status;
		this.remarks = remarks;
		this.envisaged_cod = envisaged_cod;
		this.npa_trigger_date = npa_trigger_date;
	}

	public int getProject_id() {
		return project_id;
	}

	public void setProject_id(int project_id) {
		this.project_id = project_id;
	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public float getProject_cost() {
		return project_cost;
	}

	public void setProject_cost(float project_cost) {
		this.project_cost = project_cost;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Date getEnvisaged_cod() {
		return envisaged_cod;
	}

	public void setEnvisaged_cod(Date envisaged_cod) {
		this.envisaged_cod = envisaged_cod;
	}

	public Date getNpa_trigger_date() {
		return npa_trigger_date;
	}

	public void setNpa_trigger_date(Date npa_trigger_date) {
		this.npa_trigger_date = npa_trigger_date;
	}

	}
