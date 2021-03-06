package com.sumware.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sumware.dto.BnameVO;
import com.sumware.dto.CommissionVO;
import com.sumware.dto.LoginVO;
import com.sumware.dto.MemberVO;
import com.sumware.dto.PayHistoryVO;
import com.sumware.dto.PayVO;
import com.sumware.dto.SignFormVO;

@Repository
public class AdminDao {

	@Autowired
	private SqlSessionTemplate st;
	
	// 관리자 로그인
	public MemberVO adminLogin(int memnum){
		return st.selectOne("admin.adminLogin", memnum);
	}

	// 관리자 - 새 사원 추가
	public void addMember(MemberVO vo){
		st.insert("admin.addMember",vo);
	}
	
	// 새 사원에 대한 정보 가져옴
	public MemberVO getNewMemInfo(MemberVO mvo){
		
		return st.selectOne("admin.getNewMemInfo",mvo);
		
	}
	
	// 사원 추가에서 선택한 부서에 따라 팀장 목록을 가져옴
	public List<MemberVO> getMemMgr(int memdept){
		return st.selectList("admin.getMemMgr",memdept);
	}
	
	// 이메일 발송 실패 시 디비에 저장했던 내용 다시삭제
	public void cancelAddMem(int memnum){
		st.delete("admin.cancelAddMem", memnum);
	}
	
	// 게시판 추가 하는 메서드
	public void addBoard(BnameVO bnvo){
		st.insert("admin.addBoard",bnvo);
	}
	
	// 사원의 정보를 불러오는 메서드
	public List<MemberVO> getMemInfoList(MemberVO mvo){
		return st.selectList("admin.getMemInfoList",mvo);
	}
	
	// 사원에 대한 연봉 입력
	public void insertPay(PayVO payvo){
		st.insert("admin.insertPay", payvo);
	}
	
	// 사원 퇴사 처리
	public void resignMem(int memnum){
		System.out.println("퇴사 처리할 사원: "+memnum);
		st.update("admin.resignMem", memnum);
	}
	
	// 멤버 정보 가져옴
	public MemberVO getMemInfo(MemberVO mvo){
		return st.selectOne("admin.getMemInfo", mvo);
	}
	
	// 멤버의 pay정보 가져옴
	public PayVO getPayInfo(int memnum){
		return st.selectOne("admin.getPayInfo", memnum);
	}
	
	// 멤버의 payhistory정보들 가져옴
	public List<PayHistoryVO> getPayHistory(PayHistoryVO phvo){
		return st.selectList("admin.getPayHistory", phvo);
	}
	
	// 사원 진급 처리(직급 변경)
	// 직급 변경 후 연봉도 변경해줘야 함(트랜잭션 처리)
	public void promoteMem(MemberVO mvo){
		System.out.println("변경할 직급: "+mvo.getMemjob());
		System.out.println("변경할 권한: "+mvo.getMemauth());
		System.out.println("사원 번호: "+mvo.getMemnum());
		st.update("admin.promoteMem",mvo);
	}
	
	// 사원 진급 처리(연봉 변경, 연차 0으로 변경)
	public void changeSalary(MemberVO mvo){
		st.update("admin.changeSalary", mvo);
	}
	
	// 사원 부서 이동
	public void moveDept(MemberVO mvo){
		st.update("admin.moveDept", mvo);
	}
	
	// 추가 급여 지급
	public void giveBonus(CommissionVO comvo){
		st.insert("admin.giveBonus", comvo);
	}
	
	// 해당 월의 commission 정보들 가져옴
	public List<CommissionVO> getComInfo(CommissionVO comvo){
		return st.selectList("admin.getComInfo", comvo);
	}
	
	// 월급 지급
	public void giveSalary(PayHistoryVO phvo){
		st.insert("admin.giveSalary", phvo);
	}
	
	// 지급 받은 이력의 년도들만 뽑아옴
	public List<PayHistoryVO> getMonths(int memnum){
		return st.selectList("admin.getMonths", memnum);
	}
	
	// 해당 부서의 게시판 목록 가져오기 
	public List<BnameVO> getDeptBoards(int bdeptno){
		return st.selectList("admin.getDeptBoards", bdeptno);
	}

	// 선택한 게시판 삭제
	public void deleteBoard(int bgnum){
		st.delete("admin.deleteBoard", bgnum);
	}
	
	// 전체 사원 수 카운트
	public int getMemCount(MemberVO mvo){
		return st.selectOne("admin.getMemCount",mvo);
	}
	
	// 제작한 양식 추가
	public void addSignForm(SignFormVO sfvo){
		st.insert("admin.addSignForm", sfvo);
	}
	
	// 결재 양식 목록 가져옴
	public List<SignFormVO> getSignFormList(SignFormVO sfvo){
		return st.selectList("admin.getSignFormList", sfvo);
	}
	
	//양식 삭제
	public void deleteSignForm(SignFormVO sfvo){
		st.delete("admin.deleteSignForm", sfvo);
	}
	
	// 전체 사원
	public List<MemberVO> getAllMemInfo(){
		return st.selectList("admin.getAllMem");
	}
	
	// 전월 추가급여 합(합 반환)
	public int getCommSum(CommissionVO comvo){
		return st.selectOne("admin.getCommSum", comvo);	
	}
	
	// 사원 로그인 히스토리
	public List<LoginVO> getLoginHistory(LoginVO lvo){
		return st.selectList("admin.getLoginHistory", lvo);
	}
	
	// 사원 히스토리 페이징 처리위한 카운트
	public int getLoginHistoryCount(LoginVO lvo){
		return st.selectOne("admin.getLoginHistoryCount", lvo);
	}

	// 하급자 리스트
	public List<MemberVO> getJuniors(int memnum){
		return st.selectList("admin.getJuniors", memnum);
	}
	
	// 지정할 상급자 리스트
	public List<MemberVO> getMgrs(MemberVO mvo){
		System.out.println("상급자 권한: "+mvo.getMemauth());
		return st.selectList("admin.getMgr", mvo);
	}
	
	// 상급자 변경
	public void changeMgr(MemberVO mvo){
		st.update("admin.changeMgr", mvo);
	}

}
