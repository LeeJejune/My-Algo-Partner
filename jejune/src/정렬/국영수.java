package jejune.src.정렬;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.Comparator;
import java.util.StringTokenizer;

public class 국영수 {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        int n = Integer.parseInt(br.readLine());

        Student[] students = new Student[n];

        for (int i = 0; i < n; i++) {
            StringTokenizer st = new StringTokenizer(br.readLine());
            students[i] = new Student(
                    st.nextToken(),
                    Integer.parseInt(st.nextToken()),
                    Integer.parseInt(st.nextToken()),
                    Integer.parseInt(st.nextToken())
            );
        }


        Arrays.sort(students, new Comparator<Student>() {
            @Override
            public int compare(Student o1, Student o2) {
                if (o1.korean < o2.korean) {
                    return 1;
                } else if (o1.korean == o2.korean) {
                    if (o1.english > o2.english) {
                        return 1;
                    } else if (o1.english == o2.english) {
                        if (o1.math < o2.math) {
                            return 1;
                        } else if (o1.math == o2.math) {
                            return o1.name.compareTo(o2.name);
                        }
                    }
                }
                return -1;
            }
        });

        for (Student student : students) {
            System.out.println(student.name);
        }
    }
}

class Student {
    String name;
    int korean;
    int english;
    int math;

    Student(String name, int korean, int english, int math) {
        this.name = name;
        this.korean = korean;
        this.english = english;
        this.math = math;
    }
}
