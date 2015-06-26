package com.sumware.mvc.model;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sumware.mvc.controller.ModelForward;

public interface ModelInter {
	public ModelForward exe(HttpServletRequest request,
			HttpServletResponse response) throws IOException;
}
