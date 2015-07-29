// require: 모듈을 로딩하는 함수
var fs = require('fs'), 
	// 파일 처리와 관련된 모듈
    express = require('express'), 
    // 서버 사이드 웹 프레임워크. 자바스크립트로 서버 사이드 작성 가능
    http = require('http');
	// http 서버 생성 시 필요한 모듈

var app = express();
// express 어플리케이션 생성

app.use(express.static(__dirname));
// express 어플리케이션 환경 설정

http.createServer(app).listen(8001);
// createServer: 웹 서버 객체를 반환하는 함수
// listen: 인자로 들어간 포트로 접속을 대기, 사용자가 종료하기 전까지는 끝나지 않음 

console.log('http://localhost:8001');
