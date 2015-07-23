package com.sumware.valid.custom;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

import org.hibernate.validator.constraints.CompositionType;
import org.hibernate.validator.constraints.ConstraintComposition;

@ConstraintComposition(CompositionType.AND)
@Target({ElementType.METHOD,ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = MailReceiverValidator.class)
public @interface MailReceiver {
	 public abstract String message() default "{MailReceiver.message}";
     public abstract Class<?>[] groups() default { };
     public abstract Class<? extends Payload>[] payload() default { };
}
