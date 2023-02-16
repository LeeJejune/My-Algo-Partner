package jejune.src.정렬;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.PriorityQueue;

public class 카드정렬하기 {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        int n = Integer.parseInt(br.readLine());

        PriorityQueue<Long> pq = new PriorityQueue<>();

        for (int i = 0; i < n; i++) {
            pq.add(Long.parseLong(br.readLine()));
        }

        long sum = 0;

        while (pq.size() > 1){
            Long pollA = pq.poll();
            Long pollB = pq.poll();

            sum += pollA + pollB;
            pq.add(pollA + pollB);
        }
        
        System.out.println(sum);
    }
}
