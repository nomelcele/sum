package com.sumware.dto;

public class PayVO {
/*create table pay(
		 pmem NUMBER(5), -- member 테이블의 사번을 참조 하고, pk 이다.
		 pyearly NUMBER(2), -- 년차
		 pcomm NUMBER(9), -- 보너스
		 psalary NUMBER(10), -- 연봉
 CONSTRAINT pay_pmem_pk PRIMARY KEY(pmem),
 CONSTRAINT pay_pmem_fk FOREIGN KEY(pmem) REFERENCES member(memnum) ON DELETE CASCADE
);*/

	private int pmem,pyearly,pcomm,psalary;

	public int getPmem() {
		return pmem;
	}

	public void setPmem(int pmem) {
		this.pmem = pmem;
	}

	public int getPyearly() {
		return pyearly;
	}

	public void setPyearly(int pyearly) {
		this.pyearly = pyearly;
	}

	public int getPcomm() {
		return pcomm;
	}

	public void setPcomm(int pcomm) {
		this.pcomm = pcomm;
	}

	public int getPsalary() {
		return psalary;
	}

	public void setPsalary(int psalary) {
		this.psalary = psalary;
	} 
}
