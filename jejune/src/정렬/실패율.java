package jejune.src.정렬;

import java.util.HashMap;

public class 실패율 {
    public int[] solution(int N, int[] stages) {
        HashMap<Integer, Double> map = new HashMap<>();
        int[] answer = new int[N];

        for (int i = 1; i <= N; i++) {
            int stage = i;
            int noClearCount = 0;
            int currentCount = 0;

            for (int j = 0; j < stages.length; j++) {
                int player = stages[j];
                if (player == stage) {
                    noClearCount++;
                }
                if (stage <= player) {
                    currentCount++;
                }
            }

            double failRate = 0;
            if (noClearCount != 0 && currentCount != 0) {
                failRate = (double) noClearCount / (double) currentCount;
            }
            map.put(stage, failRate);
        }

        for (int i = 0; i < N; i++) {
            double max = -1;
            int maxKey = 0;
            for (Integer key : map.keySet()) {
                if (max < map.get(key)) {
                    max = map.get(key);
                    maxKey = key;
                }
            }
            answer[i] = maxKey;
            map.remove(maxKey);
        }
        return answer;
    }
}
