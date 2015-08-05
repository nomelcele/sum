package com.sumware.mvc.socket;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
//spring에서의 websoket환경을 위하여
//@configuration,@EnableWebSocket를 달아준다.
@Configuration
@EnableWebSocket
@ServerEndpoint("/samsgSocket/{auth_key}")// 클라이언트에서 접속할 서버 주소 {}<--이렇게 하면 그뒤의 파라미터 값을 auth_key로 얻어옴. (추측)
public class MsgProcess {
	
	static Map<String, List<Session>> msgSessionMap = Collections.synchronizedMap(new HashMap<String, List<Session>>());
	//클라이언트에서 접속할떄의 처리
	@OnOpen
	public void join(@PathParam("auth_key") String sessionKey, Session session) {
		
		System.out.println(session.toString());
		System.out.println("sessionKey : "+sessionKey);
		if(!msgSessionMap.containsKey(sessionKey)) {
			msgSessionMap.put(sessionKey, new ArrayList<Session>());
		}
		msgSessionMap.get(sessionKey).add(session);
	}
	//메시지 처리
	@OnMessage
	public void message(@PathParam("auth_key") String sessionKey, String message, Session session) {
		
		System.out.println(session.toString());
		System.out.println(sessionKey);
		
		System.out.println("map size : "+msgSessionMap.size());
		
		List<Session> sessionList = msgSessionMap.get(sessionKey);
		if(sessionList == null || sessionList.size() == 0) {
			
		}
		Iterator<Session> iter = sessionList.iterator();
		while(iter.hasNext()) {
			
			Session nextSession = iter.next();
			System.out.println("message : "+message);
			System.out.println(nextSession.getBasicRemote());
			try {
				nextSession.getBasicRemote().sendText(message);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	//클라이언트와 접속이 끈어졌을떄의 처리
	@OnClose
	public void close(@PathParam("auth_key") String sessionKey, Session session, CloseReason close) {
		
		System.out.println(">>> close >>>");
		System.out.println(session.toString());
		System.out.println(sessionKey);
		
		List<Session> sessionList = msgSessionMap.get(sessionKey);
		if(sessionList != null && sessionList.size() > 0) {
			sessionList.remove(session);
		}
		
		if(msgSessionMap.get(sessionKey).size() == 0) {
			msgSessionMap.remove(sessionKey);
		}
	}
	//에러처리
	@OnError
	public void error(@PathParam("auth_key") String sessionKey, Session session, Throwable t) {
		
		System.out.println(">>> error >>>");
		System.out.println(session.toString());
		System.out.println(sessionKey);
		
		List<Session> sessionList = msgSessionMap.get(sessionKey);
		if(sessionList != null && sessionList.size() > 0) {
			sessionList.remove(session);
		}
	}
}
