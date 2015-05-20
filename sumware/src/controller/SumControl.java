package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ModelInter;

@WebServlet("/sumware")
public class SumControl extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request, response);
	}
	protected void doService(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 클라이언트 요청에 대한 encoding 처리
		request.setCharacterEncoding("utf-8");
		// 클라이언트 요청을 받는것 부터 시작
		String mod = request.getParameter("mod");
		System.out.println("controll mod:"+mod);
		ModelInter model = ModelFactory.getMf().getModel(mod);
		ModelForward mf = model.exe(request, response);
		// true 일때는 forward, false 일때는 sendRedirect
		if(mf.isMethod()){
			RequestDispatcher rd = request.getRequestDispatcher(mf.getUrl());
			rd.forward(request, response);
		}else{
			response.sendRedirect(mf.getUrl());
		}
			
	}
}
