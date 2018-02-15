package classpackage;

public class Reports {

	private String report_name,periodicity;

public Reports() {
    super();
}

public Reports(String report_name, String periodicity) {
	this.report_name=report_name;
	this.periodicity=periodicity;
	}

public String getReport_name() {
	return report_name;
}

public void setReport_name(String report_name) {
	this.report_name = report_name;
}

public String getPeriodicity() {
	return periodicity;
}

public void setPeriodicity(String periodicity) {
	this.periodicity = periodicity;
}

}
