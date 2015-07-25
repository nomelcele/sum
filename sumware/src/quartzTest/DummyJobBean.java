package quartzTest;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

public class DummyJobBean extends QuartzJobBean {

	private DummyTask dt;
	
	@Override
	protected void executeInternal(JobExecutionContext arg0)
			throws JobExecutionException {
		dt.print();
	}

	public void setDt(DummyTask dt) {
		this.dt = dt;
	}
	
	
	
}
