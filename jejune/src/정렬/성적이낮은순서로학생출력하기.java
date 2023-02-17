package jejune.src.정렬;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.StringTokenizer;

public class 성적이낮은순서로학생출력하기 {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        List<Student> students = new ArrayList<>();

        int n = Integer.parseInt(br.readLine());

        StringTokenizer st;
        for (int i = 0; i < 2; i++) {
            st = new StringTokenizer(br.readLine());
            students.add(new Student(st.nextToken(), Integer.parseInt(st.nextToken())));
        }

        List<Student> lists = students.stream()
                .sorted(Comparator.comparing(Student::getScore))
                .toList();

        for (Student student : lists) {
            System.out.print(student.getName() + " ");
        }


    }

    static class Student {
        String name;
        int score;

        public Student(final String name, final int score) {
            this.name = name;
            this.score = score;
        }

        public String getName() {
            return name;
        }

        public int getScore() {
            return score;
        }
    }
}
