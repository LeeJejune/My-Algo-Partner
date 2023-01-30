package jejune.src.그리디;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class 문자열뒤집기 {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        String str = br.readLine();

        int count1 = 0;
        int count0 = 0;

        if (str.charAt(0) == 1){
            count1++;
        } else {
            count0++;
        }

        for (int i = 1; i < str.length() - 1; i++) {
            if (str.charAt(i) != str.charAt(i + 1)){
                if (str.charAt(i + 1) == 1){
                    count0++;
                } else {
                    count1++;
                }
            }
        }
        System.out.println(Math.min(count0, count1));
    }
}
