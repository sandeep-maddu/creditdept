package classpackage;

public class Directors {

	private int dirid,aid;
	private String director_name,designation;
	
	public Directors() {
	    super();
	}
	
	public Directors(int dirid,String director_name, String designation,int aid) {
		this.dirid=dirid;
		this.director_name=director_name;
		this.designation=designation;
		this.aid=aid;
		}

	public int getDirid() {
		return dirid;
	}

	public void setDirid(int dirid) {
		this.dirid = dirid;
	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public String getDirector_name() {
		return director_name;
	}

	public void setDirector_name(String director_name) {
		this.director_name = director_name;
	}

	public String getDesignation() {
		return designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}
	
}
