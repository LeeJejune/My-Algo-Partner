package jejune.src.정렬;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class 두배열의원소교체 {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());


        int n = Integer.parseInt(st.nextToken());
        int k = Integer.parseInt(st.nextToken());

        Integer[] arrA = new Integer[n];
        Integer[] arrB = new Integer[n];

        String str = br.readLine();
        st = new StringTokenizer(str);
        for (int i = 0; i < arrA.length; i++) {
            arrA[i] = Integer.parseInt(st.nextToken());
        }

        str = br.readLine();
        st = new StringTokenizer(str);
        for (int i = 0; i < arrB.length; i++) {
            arrB[i] = Integer.parseInt(st.nextToken());
        }

        Arrays.sort(arrA);
        Arrays.sort(arrB, Collections.reverseOrder());

        for (int i = 0; i < k; i++) {
            if (arrA[i] < arrB[i]){
                int temp = arrA[i];
                arrA[i] = arrB[i];
                arrB[i] = temp;
            }
        }

        var sum = 0;

        for (int i = 0; i < arrA.length; i++) {
            sum += arrA[i];
        }
        System.out.println(sum);
    }
}
