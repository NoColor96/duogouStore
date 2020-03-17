package com.hixqz.store.Utils;

import java.util.Random;

public class RandomUtil {
	/**
	 * 生成随机不重复的数组
	 * @param size 数组长度
	 * @param maxSize 最大值
	 * @return
	 */
	public static int[] RandomArray(int size,int maxValue) {
		Random random = new Random();
		int[] randoms = new int[size];
		for(int i = 0;i < size;i++) {
			boolean isRepetition = false;
			int randomEach = random.nextInt(maxValue+1);
			for(int j = 0;j < randoms.length;j++) {
				if(randomEach==randoms[j]) {
					i--;
					isRepetition = true;
					break;
				}
			}
			if(isRepetition==false)
				randoms[i] = randomEach;
		}
		return randoms;
	}
}
