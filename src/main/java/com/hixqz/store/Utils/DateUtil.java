package com.hixqz.store.Utils;

import java.sql.Timestamp;
import java.util.Date;

public class DateUtil {
	public static Timestamp DateTurnTimestamp(Date date) {
		return new Timestamp(date.getTime());
	}
	public static Date TimestampTurnDate(Timestamp timestamp) {
		return new Date(timestamp.getTime());
	}
}
