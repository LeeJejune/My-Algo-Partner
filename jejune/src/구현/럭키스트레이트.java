package jejune.src.구현;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class 럭키스트레이트 {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        int leftSum = 0;
        int rightSum = 0;

        String str = br.readLine();
        int length = str.length() / 2;

        for (int i = 0; i < length; i++) {
            leftSum += str.charAt(i) - '0';
        }
        for (int i = length; i < str.length(); i++) {
            rightSum += str.charAt(i) - '0';
        }

        if (leftSum == rightSum){
            System.out.println("LUCKY");
        } else {
            System.out.println("READY");
        }
    }
}
