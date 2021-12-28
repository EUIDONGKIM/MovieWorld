package com.kh.spring.entity.schedule;

import lombok.Data;

@Data
public class ScheduleTimeDto {
	private int scheduleTimeNo;
	private int scheduleNo;
	private String scheduleTimeDateTime;
	private String scheduleTimeDiscountType;
	private int scheduleTimeDiscountPrice;
	private int hallNo;
	private int scheduleTimeCount; // 관람객 수 : 해당 예약 시 update
	private int scheduleTimeSum; // 매출 : count와 동일 => 현재는 int로 하나 총 매출 합산에서는 Long으로 해줄 계획
}
