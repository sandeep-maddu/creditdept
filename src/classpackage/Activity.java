
package classpackage;

public class Activity {

	private String activity_name,description,industry;

	public Activity() {
	    super();
	}
	
	public Activity(String activity_name,String description,String industry) {
	this.activity_name=activity_name;
	this.description=description;
	this.industry=industry;
	
	}

	public String getActivity_name() {
		return activity_name;
	}

	public void setActivity_name(String activity_name) {
		this.activity_name = activity_name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getIndustry() {
		return industry;
	}

	public void setIndustry(String industry) {
		this.industry = industry;
	}
	
	}

