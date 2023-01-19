package jejune.src.구현;

public class 문자열압축 {
    public static void main(String[] args) {
        int answer = solution("abcabcabcabcdededededede");
        System.out.println(answer);

    }

//    class Solution {
        public static int solution(String s) {
            int answer = Integer.MAX_VALUE;

            int len = s.length();

            if (len == 1) return 1;

            for (int size = 1; size <= len / 2; size++) {
                int i = 0;
                int sum = len;

                for (; i + size <= len; ) {
                    String str = s.substring(i, i + size); // size 별 문자열 압축
                    i += size;

                    int cnt = 0;
                    for (; i + size <= len; ) {
                        String new_str = s.substring(i, i + size); // 비교할 다음 문자열 압축.
                        if (str.equals(new_str)){
                            cnt++;
                            i += size;
                        } else {
                            break;
                        }
                    }
                    String s_cnt = (cnt + 1) + ""; //자기 자신도 포함 되어야 하니까 +1
                    if (cnt > 0){
                        sum = sum - cnt * size + s_cnt.length(); // 사라진 문자의 길이 빼기, 길이 더하기.
                    }
                    answer = Math.min(answer, sum);
                }
            }
            return answer;
        }
//    }
}
