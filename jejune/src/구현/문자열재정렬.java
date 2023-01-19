package jejune.src.구현;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collections;

public class 문자열재정렬 {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        String str = br.readLine();
        ArrayList<Character> alphas = new ArrayList<>();
        int sum = 0;

        String answer = "";

        for (int i = 0; i < str.length(); i++) {
            if (Character.isLetter(str.charAt(i))) {
                alphas.add(str.charAt(i));
            } else {
                sum += str.charAt(i) - '0';
            }
        }

        Collections.sort(alphas);

        for (int i = 0; i < alphas.size(); i++) {
            answer += alphas.get(i);
        }

        System.out.println(answer + sum);
    }
}
