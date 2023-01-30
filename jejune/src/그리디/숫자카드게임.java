package jejune.src.그리디;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.StringTokenizer;

public class 숫자카드게임 {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int n = Integer.parseInt(st.nextToken());
        int m = Integer.parseInt(st.nextToken());

        int[][] arr = new int[n][m];

        int[] value = new int[n];

        StringTokenizer st2;
        for (int i = 0; i < n; i++) {
            st2 =  new StringTokenizer(br.readLine());
            for (int j = 0; j < m; j++) {
                arr[i][j] = Integer.parseInt(st2.nextToken());
            }
        }

        for (int i = 0; i < n; i++) {
            int max = arr[i][0];
            for (int j = 1; j < m; j++) {
                if (max >= arr[i][j]) {
                    value[i] = arr[i][j];
                }
                max = value[i];
            }
        }
        Arrays.sort(value);
        System.out.println(value[value.length-1]);
    }
}
