package jejune.src.그리디;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class 곱하기혹은더하기 {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        String str = br.readLine();

        long result = str.charAt(0) - '0';

        for (int i = 1; i < str.length(); i++) {
            long value= str.charAt(i) - '0';

            if (value <= 1 || result <= 1){
                result += value;
            } else {
                result *= value;
            }
        }
        System.out.println(result);
    }
}
