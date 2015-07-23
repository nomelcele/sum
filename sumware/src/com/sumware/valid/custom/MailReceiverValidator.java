package com.sumware.valid.custom;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import org.springframework.stereotype.Component;
@Component
public class MailReceiverValidator implements ConstraintValidator<MailReceiver, String>{

	@Override
	public void initialize(MailReceiver constraintAnnotation) {
	}
	
	@Override
	public boolean isValid(String value, ConstraintValidatorContext context) {
		boolean result;
		if(value == null){
			result = false;
		}
		value = value.replaceAll("<", "");
		value = value.replaceAll(">", "");
		value = value.replaceAll(" ", "");
		
		Matcher matcher = Pattern.compile("[ㄱ-힣]+").matcher(value);
		boolean moon = matcher.find();
		matcher = Pattern.compile("(?:\\w+\\.?)*\\w+@(?:\\w+\\.)+\\w+$").matcher(value);
		boolean mail = matcher.find();
		if(moon && mail){
			result = true;
		}else{
			result = false;
		}
		return result;
	}

}
