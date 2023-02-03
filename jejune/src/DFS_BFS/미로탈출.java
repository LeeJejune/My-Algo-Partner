package jejune.src.DFS_BFS;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.LinkedList;
import java.util.Queue;
import java.util.StringTokenizer;

public class 미로탈출 {
    static char[][] map;
    static int[] dx = {-1, 0, 1, 0};
    static int[] dy = {0, 1, 0, -1};

    static int N;
    static int M;
    static Queue<int[]> queue;

    public static void bfs() {

        while (!queue.isEmpty()) {

            int[] curNode = queue.poll();
            int x = curNode[0];
            int y = curNode[1];
            int count = curNode[2];

            if (x == N - 1 && y == M - 1) {
                System.out.println(count);
                break;
            }

            map[x][y] = '0';

            // 4방 탐색
            for (int i = 0; i < 4; i++) {
                int nx = x + dx[i];
                int ny = y + dy[i];

                // 범위 벗어나면 continue
                if (nx < 0 || nx >= N || ny < 0 || ny >= M) {
                    continue;
                }

                // 주변 칸이 괴물이 없을 경우 stack에 추가
                if (map[nx][ny] == '1') {
                    queue.offer(new int[]{nx, ny, count + 1});
                }
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

        queue = new LinkedList<>();
        queue.offer(new int[]{0, 0, 1});
        bfs();

    }
}
