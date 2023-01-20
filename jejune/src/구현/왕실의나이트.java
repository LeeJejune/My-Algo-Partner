package jejune.src.구현;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class 왕실의나이트 {
    static int[] movesX = {-2, -1, 1, 2, 2, 1, -1, -2};
    static int[] movesY = {-1, -2, -2, -1, 1, 2, 2, 1};

    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        String str = br.readLine();
        char[] arr = str.toCharArray();

        int answer = 0;

        int col = arr[0] - 97;
        int row = arr[1] - 49;

        for (int i = 0; i < 8; i++) {
            int nx = row + movesX[i];
            int ny = col + movesY[i];

            if (nx > 7 && ny > 7 && nx < 0 && ny < 0) {
                continue;
            }
            answer++;
        }
        System.out.println(answer);

    }
}
