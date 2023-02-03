package jejune.src.DFS_BFS;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.StringTokenizer;

public class 음료수얼려먹기 {

    static char[][] map;
    static int[] dx = {-1, 0, 1, 0};
    static int[] dy = {0, 1, 0, -1};

    static int N;
    static int M;

    public static void dfs(int x, int y) {

        // 현 위치 set 0
        map[x][y] = '1';

        // 4방 탐색
        for (int i = 0; i < 4; i++) {
            int nx = x + dx[i];
            int ny = y + dy[i];

            // 범위 벗어나면 continue
            if (nx < 0 || nx >= N || ny < 0 || ny >= M) {
                continue;
            }

            // 주변 칸 역시 0일 경우 dfs 재귀호출
            if (map[nx][ny] == '0') {
                dfs(nx, ny);
            }
        }


    }

    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        StringTokenizer st = new StringTokenizer(br.readLine());
        N = Integer.parseInt(st.nextToken());
        M = Integer.parseInt(st.nextToken());

        map = new char[N][M];

        for (int i = 0; i < N; i++) {
            map[i] = br.readLine().toCharArray();
        }

        int count = 0;
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < M; j++) {

                // 0을 처음 보았을 때 dfs 실시
                // 이 과정으로 인접한 0은 모두 1로 바뀜
                if (map[i][j] == '0') {
                    dfs(i, j);
                    count++;
                }
            }
        }

        System.out.println(count);


    }
}