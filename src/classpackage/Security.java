package classpackage;
import java.util.Date;

public class Security {
	
	private int scid,aid;
	private float value;
	private String type,location,description,owner;
	private Date valuation_date;
	
	public Security() {
	    super();
	}

	public Security(int scid, int aid, String type, String location, String description, String owner, float value, Date valuation_date) {
		
		this.scid = scid;
		this.aid = aid;
		this.type = type;
		this.location = location;
		this.description = description;
		this.owner = owner;
		this.value = value;
		this.valuation_date = valuation_date;
	}

	public int getScid() {
		return scid;
	}

	public void setScid(int scid) {
		this.scid = scid;
	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public float getValue() {
		return value;
	}

	public void setValue(float value) {
		this.value = value;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public Date getValuation_date() {
		return valuation_date;
	}

	public void setValuation_date(Date valuation_date) {
		this.valuation_date = valuation_date;
	}

	}
