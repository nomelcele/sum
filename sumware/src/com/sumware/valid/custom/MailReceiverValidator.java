package com.sumware.valid.custom;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import org.springframework.stereotype.Component;
@Component
public class MailReceiverValidator implements ConstraintValidator<MailReceiver, String>{
	// 유효성 검사를 실시하는 Validator 클래스
	
	@Override
	public void initialize(MailReceiver constraintAnnotation) {
	}
	
	@Override
	public boolean isValid(String value, ConstraintValidatorContext context) {
		boolean result;
		if(value == null){ // 값이 비어있을 경우 false 리턴
			result = false;
		}
		
		value = value.replaceAll("<", "");
		value = value.replaceAll(">", "");
		value = value.replaceAll(" ", "");
		
		// 한글이 포함되어 있는지 판별
		Matcher matcher = Pattern.compile("[ㄱ-힣]+").matcher(value);
		// 조건을 만족하면 true 리턴
		boolean moon = matcher.find();
		// 메일 주소 형식으로 되어 있는지 판별
		matcher = Pattern.compile("(?:\\w+\\.?)*\\w+@(?:\\w+\\.)+\\w+$").matcher(value);
		boolean mail = matcher.find();
		if(moon && mail){ // 두 조건을 모두 만족시킬 경우에만 true 리턴
			result = true;
		}else{
			result = false;
		}
		return result;
	}

}
