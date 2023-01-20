package jejune.src.구현;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.LinkedList;
import java.util.Queue;
import java.util.StringTokenizer;

public class 뱀 {
    //동 남 서 북
    static int[] dx = {0, 1, 0, -1};
    static int[] dy = {1, 0, -1, 0};
    static int[][] map;

    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st;
        int n = Integer.parseInt(br.readLine());

        map = new int[n + 1][n + 1];

        int k = Integer.parseInt(br.readLine());

        for (int i = 0; i < k; i++) {
            String str = br.readLine();
            st = new StringTokenizer(str);

            int row = Integer.parseInt(st.nextToken());
            int col = Integer.parseInt(st.nextToken());

            map[row][col] = 1;
        }

        int l = Integer.parseInt(br.readLine());

        Queue<Spin> spin = new LinkedList<>();
        for (int i = 0; i < l; i++) {
            st = new StringTokenizer(br.readLine());

            int time = Integer.parseInt(st.nextToken());
            String dir = st.nextToken();

            spin.offer(new Spin(time, dir));
        }

        // 뱀 초기 위치
        int row = 1;
        int col = 1;
        int time = 0;
        int dir = 0;
        Queue<Node> snake = new LinkedList<>();
        snake.offer(new Node(row, col));
        map[row][col] = 2;

        while (true) {
            int dRow = row + dx[dir];
            int dCol = col + dy[dir];

            time++;

            if (dRow < 1 || dCol < 1 || dRow > n || dCol > n)
                break;
            if (map[dRow][dCol] == 2)
                break;

            if (map[dRow][dCol] == 0) {
                Node node = snake.poll();
                map[node.row][node.col] = 0;
            }
            if (!spin.isEmpty()) {
                if (time == spin.peek().time) {
                    Spin sp = spin.poll();

                    if (sp.dir.equals("L"))
                        dir = dir - 1 < 0 ? 3 : dir - 1;
                    if (sp.dir.equals("D"))
                        dir = dir + 1 > 3 ? 0 : dir + 1;
                }
            }

            map[dRow][dCol] = 2;
            snake.offer(new Node(dRow, dCol));
            row = dRow;
            col = dCol;
        }
        System.out.println(time);
    }
}

class Spin {
    int time;
    String dir;

    Spin(int time, String dir) {
        this.time = time;
        this.dir = dir;
    }
}

class Node {
    int row;
    int col;

    Node(int row, int col) {
        this.row = row;
        this.col = col;
    }
}
