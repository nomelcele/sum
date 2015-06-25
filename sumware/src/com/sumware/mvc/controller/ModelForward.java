package com.sumware.mvc.controller;

public class ModelForward {
	private String url;
	private boolean method;
	public ModelForward(String url, boolean method) {
		this.url = url;
		this.method = method;
	}
	public String getUrl() {
		return url;
	}
	public boolean isMethod() {
		return method;
	}
	
	
}
