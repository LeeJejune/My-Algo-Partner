package jejune.src.DFS_BFS;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.PriorityQueue;
import java.util.Queue;
import java.util.StringTokenizer;

public class 경쟁적전염 {
    static class Point{
        int y, x, v;

        public Point(int y, int x, int v) {
            this.y = y;
            this.x = x;
            this.v = v;
        }
    }

    static int n, k;
    static int[] Y = {-1, 1, 0, 0}, X = {0, 0, -1, 1};
    static int[][] map = new int[201][201];
    static Queue<Point> pq = new PriorityQueue<>((a, b) -> a.v- b.v);

    static void BFS(){
        Queue<Point> tmpQ = new PriorityQueue<>((a, b) -> a.v - b.v);

        while(!pq.isEmpty()) {
            Point p = pq.poll();
            int y = p.y;
            int x = p.x;
            int v = p.v;

            for (int a = 0; a < 4; a++) {
                int ny = y + Y[a];
                int nx = x + X[a];

                if (ny < 1 || nx < 1 || ny > n || nx > n || map[ny][nx] != 0) continue;

                map[ny][nx] = v;
                tmpQ.add(new Point(ny, nx, v));
            }
        }
        pq = tmpQ;
    }

    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());

        n = Integer.parseInt(st.nextToken());
        k = Integer.parseInt(st.nextToken());

        for(int i=1; i<=n; i++){
            st = new StringTokenizer(br.readLine());

            for(int j=1; j<=n; j++){
                map[i][j] = Integer.parseInt(st.nextToken());

                if(map[i][j] != 0)
                    pq.add(new Point(i, j, map[i][j]));
            }
        }
        st = new StringTokenizer(br.readLine());
        int s = Integer.parseInt(st.nextToken());
        int endY = Integer.parseInt(st.nextToken());
        int endX = Integer.parseInt(st.nextToken());

        int time = 0;
        while(time++ != s)
            BFS();

        System.out.println(map[endY][endX]);
    }
}
