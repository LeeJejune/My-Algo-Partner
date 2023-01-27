package jejune.src.그리디;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.StringTokenizer;

public class 볼링공고르기 {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        ArrayList<Integer> ballList = new ArrayList<>();
        int sum = 0;

        int n = Integer.parseInt(st.nextToken());
        int m = Integer.parseInt(st.nextToken());


        st = new StringTokenizer(br.readLine());
        for (int i = 0; i < n; i++) {
            ballList.add(Integer.parseInt(st.nextToken()));
        }

        Collections.sort(ballList);

        for (int i = 0; i < n; i++) {
            int ball = ballList.get(i);

            for (int j = i; j < n; j++) {
                if (ball == ballList.get(i)){
                    continue;
                }
                sum += (n - j);
                break;
            }
        }
        System.out.println(sum);
    }
}
