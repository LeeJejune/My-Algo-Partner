package jejune.src.구현;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.StringTokenizer;

public class 상하좌우 {
    static int[] dx = {-1, 1, 0, 0};
    static int[] dy = {0, 0, -1, 1};
    static String[] direction = {"U", "D", "L", "R"};

    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        int t = Integer.parseInt(br.readLine());
        int x = 1;
        int y = 1;

        String str = br.readLine();
        StringTokenizer st = new StringTokenizer(str);

        while (st.hasMoreTokens()){
            String s = st.nextToken();

            int nx = 0, ny = 0;

            for (int j = 0; j < 4; j++) {
                if (s.equals(direction[j])) { // 문자열 비교는 == 말고 equals() 사용
                    nx = x + dx[j];
                    ny = y + dy[j];
                }
            }

            if (nx < 1 || ny < 1 || nx > t || ny > t) {
                continue;
            }
            x = nx;
            y = ny;
        }
        System.out.println(x + " " + y);

    }
}
