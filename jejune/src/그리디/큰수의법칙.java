package jejune.src.그리디;// p92 큰 수의 법칙

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.StringTokenizer;

public class 큰수의법칙 {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());

        int n = Integer.parseInt(st.nextToken());
        int m = Integer.parseInt(st.nextToken());
        int k = Integer.parseInt(st.nextToken());

        st = new StringTokenizer(br.readLine());
        int[] numbers = new int[n];

        for (int i = 0; i < n; i++) {
            numbers[i] = Integer.parseInt(st.nextToken());
        }

        Arrays.sort(numbers);

        int count = 0;
        int sum = 0;
        for (int i = 0; i < m; i++) {
            if (count != k) {
                sum += numbers[numbers.length - 1];
                count++;
            } else {
                sum += numbers[numbers.length - 2];
                count = 0;
            }
        }

        System.out.println(sum);

    }
}