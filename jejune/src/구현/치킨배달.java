package jejune.src.구현;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.StringTokenizer;

public class 치킨배달 {
    static int n;
    static int m;
    static int[][] map;
    static int min = Integer.MAX_VALUE;
    static ArrayList<Node> house = new ArrayList<>();
    static ArrayList<Node> chicken = new ArrayList<>();
    static boolean[] visited;

    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());

        n = Integer.parseInt(st.nextToken());
        m = Integer.parseInt(st.nextToken());

        map = new int[n][n];

        for (int i = 0; i < n; i++) {
            String str = br.readLine();
            st = new StringTokenizer(str);
            for (int j = 0; j < n; j++) {
                map[i][j] = Integer.parseInt(st.nextToken());
                if (map[i][j] == 1){
                    house.add(new Node(i,j));
                }
                if (map[i][j] == 2){
                    chicken.add(new Node(i,j));
                }
            }
        }

        visited = new boolean[chicken.size()];
        backtracking(0, 0);
        System.out.println(min);


    }

    private static void backtracking(int count, int index) {
        if (count == m){
            int total = 0;
            for (int i = 0; i < house.size(); i++) {
                int sum = Integer.MAX_VALUE;
                for (int j = 0; j < chicken.size(); j++) {
                    if (visited[j]){
                        int dist = Math.abs(house.get(i).x - chicken.get(j).x) + Math.abs(house.get(i).y - chicken.get(j).y);
                        sum = Math.min(dist, sum);
                    }
                }
                total += sum;
            }
            min = Math.min(total, min);
            return;
        }

        for (int i = index; i < chicken.size(); i++) {
            if (!visited[i]){
                visited[i] = true;
                backtracking(count + 1, i + 1);
                visited[i] = false;
            }
        }
    }

    public static class Node {
        int x;
        int y;

        public Node(int x, int y) {
            this.x = x;
            this.y = y;
        }
    }
}
