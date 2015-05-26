package model;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.ModelForward;

public class IndexModel implements ModelInter{

	@Override
	public ModelForward exe(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String url = "index.jsp";
		boolean method = false;
		
		return new ModelForward(url, method);
	}

}
