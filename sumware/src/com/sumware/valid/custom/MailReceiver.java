package com.sumware.valid.custom;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

import org.hibernate.validator.constraints.CompositionType;
import org.hibernate.validator.constraints.ConstraintComposition;

// 유효성 검사에 이용할 custom constraint(제약 조건) 정의

// @ConstraintComposition: 제약 조건들의 type 지정
// => AND: 모든 제약 조건들이 true를 반환해야 유효성 검사 통과
// @Target: 제약 조건을 정의 가능한 영역 지정
// => METHOD,FIELD: 메서드와 필드에 대해 정의 가능
// @Retention: 제약 조건이 적용될 시점 정의
// => RUNTIME: 런타임 시에 적용
// @Constraint: 유효성 검사를 실시할 클래스 정의
@ConstraintComposition(CompositionType.AND)
@Target({ElementType.METHOD,ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = MailReceiverValidator.class)
public @interface MailReceiver {
	 // 1. message: 유효성 검사에서 오류가 발생했을 경우 보여질 메시지 정의
     // msg.properties 파일에 정의되어 있다(유니코드).
	 // msg.properties 파일은 bean으로 등록되어 있다.
	 public abstract String message() default "{MailReceiver.message}";
	 // 2. groups: 제약 조건의 그룹 정보를 정의하는 데에 사용
	 // 일부 제약 조건에 대해 동일한 그룹을 부여할 경우, 특정 그룹에 대해서만 유효성 검사를 실시할 수 있다.
     public abstract Class<?>[] groups() default { };
     // 3. payload: 유효성 검사의 제약 조건과 관련된 메타 정보 정의
     public abstract Class<? extends Payload>[] payload() default { };
}
