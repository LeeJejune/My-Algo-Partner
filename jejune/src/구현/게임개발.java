package jejune.src.구현;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.StringTokenizer;

public class 게임개발 {

    static int[] dx = {-1, 0, 1, 0};
    static int[] dy = {0, 1, 0, -1};

    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());

        int n = Integer.parseInt(st.nextToken());
        int m = Integer.parseInt(st.nextToken());

        int answer = 1;

        int[][] map = new int[n][m];

        StringTokenizer st2 = new StringTokenizer(br.readLine());
        int x = Integer.parseInt(st2.nextToken());
        int y = Integer.parseInt(st2.nextToken());
        int direction = Integer.parseInt(st2.nextToken());

        boolean[][] visited = new boolean[n][m]; // 방문 여부 체크
        visited[x][y] = true;

        for (int i = 0; i < n; i++) {
            String str = br.readLine();
            for (int j = 0; j < m; j++) {
                map[i][j] = str.charAt(j) - '0';
            }
        }

        while (true){
            int turn = 0;

            while (turn < 4){
                direction = turnLeft(direction);
                int nx = x + dx[direction];
                int ny = y + dy[direction];
                if (map[nx][ny] != 1 && visited[nx][ny] == false){
                    x = nx;
                    y = ny;
                    visited[nx][ny] = true;
                    answer++;
                    break;
                }
                turn++;
            }
            if (turn == 4){
                int nx = x - dx[direction];
                int ny = y - dy[direction];
                if (map[nx][ny] != 1){
                    x = nx;
                    y = ny;

                } else {
                    break;
                }
            }
        }
        System.out.println(answer);
    }

    private static int turnLeft(int direction) {
        if (direction == 0){
            return 3;
        }
        return --direction;
    }
}
