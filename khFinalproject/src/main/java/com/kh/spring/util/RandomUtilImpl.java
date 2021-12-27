package com.kh.spring.util;

import java.text.DecimalFormat;
import java.text.Format;
import java.util.Random;

import org.springframework.stereotype.Component;

@Component
public class RandomUtilImpl implements RandomUtil{
	private Random r = new Random();
	@Override
	public String generateRandomNumber(int size) {
		//size = 2 00~99 100
		//size = 3 000~999 1000
		//size = 4 0000~9999 10000개
		//size = n 10^n개
		int range= (int)Math.pow(10, size);
		int number = r.nextInt(range);
		StringBuffer buffer = new StringBuffer();
		for(int i =0; i<size ; i++) {
			buffer.append("0");
		}
		Format f = new DecimalFormat(buffer.toString());
		
		return f.format(number);
	}
	
	//임시비밀번호
	@Override
	public String generateRandomPassword(int size) {
		   char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 
				   'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 
				   'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 
				   'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 
				   'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 
				   'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x',
				   'y', 'z' }; 
	   StringBuffer sb = new StringBuffer(); 
	   int index = 0; 
	   int length = charSet.length; 
	   for (int i=0; i<size; i++) {
		   index = (int) (Math.random()*length); 
		   sb.append(charSet[index]);
		   }
	   
	   return sb.toString();
	}

}
