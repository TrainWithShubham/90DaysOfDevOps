`script`
#!/bin/bash

# Check arguments
if [ $# -ne 1 ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

log_file="$1"

# Check if file exists
if [ ! -f "$log_file" ]; then
    echo "Error: File does not exist."
    exit 1
fi

# Get date
current_date=$(date +%Y-%m-%d)

# Report file name
report_file="log_report_${current_date}.txt"

# Generate report
{
echo "===== Log Summary Report ====="
echo "Date of Analysis: $current_date"
echo "Log File: $log_file"
echo "Total Lines Processed: $(wc -l < "$log_file")"
echo "Total Error Count: $(grep -c '\[error\]' "$log_file")"
echo
echo "--- Top 5 Error Messages ---"
grep '\[error\]' "$log_file" | cut -d']' -f3 | sort | uniq -c | sort -rn | head -5
echo "--- Critical Events (with line numbers) ---"
} > "$report_file:"

echo "Report generated: $report_file"                                        

`output`
ubuntu@ip-172-31-27-220:~$ cat log_report_2026-03-01.txt:
===== Log Summary Report =====
Date of Analysis: 2026-03-01
Log File: /home/ubuntu/day-20.log
Total Lines Processed: 2000
Total Error Count: 595

--- Top 5 Error Messages ---
    369  mod_jk child workerEnv in error state 6
    101  mod_jk child workerEnv in error state 7
     44  mod_jk child workerEnv in error state 8
     20  mod_jk child workerEnv in error state 9
     12  mod_jk child init 1 -2

--- Critical Events (with line numbers) ---
1:[Sun Dec 04 04:47:44 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
3:[Sun Dec 04 04:51:08 2005] [notice] jk2_init() Found child 6725 in scoreboard slot 10
4:[Sun Dec 04 04:51:09 2005] [notice] jk2_init() Found child 6726 in scoreboard slot 8
5:[Sun Dec 04 04:51:09 2005] [notice] jk2_init() Found child 6728 in scoreboard slot 6
6:[Sun Dec 04 04:51:14 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
7:[Sun Dec 04 04:51:14 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
8:[Sun Dec 04 04:51:14 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
12:[Sun Dec 04 04:51:37 2005] [notice] jk2_init() Found child 6736 in scoreboard slot 10
13:[Sun Dec 04 04:51:38 2005] [notice] jk2_init() Found child 6733 in scoreboard slot 7
14:[Sun Dec 04 04:51:38 2005] [notice] jk2_init() Found child 6734 in scoreboard slot 9
15:[Sun Dec 04 04:51:52 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
16:[Sun Dec 04 04:51:52 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
18:[Sun Dec 04 04:52:04 2005] [notice] jk2_init() Found child 6738 in scoreboard slot 6
19:[Sun Dec 04 04:52:04 2005] [notice] jk2_init() Found child 6741 in scoreboard slot 9
20:[Sun Dec 04 04:52:05 2005] [notice] jk2_init() Found child 6740 in scoreboard slot 7
21:[Sun Dec 04 04:52:05 2005] [notice] jk2_init() Found child 6737 in scoreboard slot 8
22:[Sun Dec 04 04:52:12 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
23:[Sun Dec 04 04:52:12 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
24:[Sun Dec 04 04:52:12 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
28:[Sun Dec 04 04:52:36 2005] [notice] jk2_init() Found child 6748 in scoreboard slot 6
29:[Sun Dec 04 04:52:36 2005] [notice] jk2_init() Found child 6744 in scoreboard slot 10
30:[Sun Dec 04 04:52:36 2005] [notice] jk2_init() Found child 6745 in scoreboard slot 8
31:[Sun Dec 04 04:52:49 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
32:[Sun Dec 04 04:52:49 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
35:[Sun Dec 04 04:53:05 2005] [notice] jk2_init() Found child 6750 in scoreboard slot 7
36:[Sun Dec 04 04:53:05 2005] [notice] jk2_init() Found child 6751 in scoreboard slot 9
37:[Sun Dec 04 04:53:05 2005] [notice] jk2_init() Found child 6752 in scoreboard slot 10
38:[Sun Dec 04 04:53:15 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
39:[Sun Dec 04 04:53:15 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
42:[Sun Dec 04 04:53:29 2005] [notice] jk2_init() Found child 6754 in scoreboard slot 8
43:[Sun Dec 04 04:53:29 2005] [notice] jk2_init() Found child 6755 in scoreboard slot 6
44:[Sun Dec 04 04:53:40 2005] [notice] jk2_init() Found child 6756 in scoreboard slot 7
45:[Sun Dec 04 04:53:51 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
47:[Sun Dec 04 04:54:15 2005] [notice] jk2_init() Found child 6763 in scoreboard slot 10
48:[Sun Dec 04 04:54:15 2005] [notice] jk2_init() Found child 6766 in scoreboard slot 6
49:[Sun Dec 04 04:54:15 2005] [notice] jk2_init() Found child 6767 in scoreboard slot 7
50:[Sun Dec 04 04:54:15 2005] [notice] jk2_init() Found child 6765 in scoreboard slot 8
51:[Sun Dec 04 04:54:18 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
52:[Sun Dec 04 04:54:18 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
53:[Sun Dec 04 04:54:18 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
54:[Sun Dec 04 04:54:18 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
59:[Sun Dec 04 04:54:20 2005] [notice] jk2_init() Found child 6768 in scoreboard slot 9
60:[Sun Dec 04 04:54:20 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
62:[Sun Dec 04 04:56:52 2005] [notice] jk2_init() Found child 8527 in scoreboard slot 10
63:[Sun Dec 04 04:56:52 2005] [notice] jk2_init() Found child 8533 in scoreboard slot 8
64:[Sun Dec 04 04:56:57 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
65:[Sun Dec 04 04:56:57 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
68:[Sun Dec 04 04:57:20 2005] [notice] jk2_init() Found child 8536 in scoreboard slot 6
69:[Sun Dec 04 04:57:20 2005] [notice] jk2_init() Found child 8539 in scoreboard slot 7
70:[Sun Dec 04 04:57:24 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
71:[Sun Dec 04 04:57:24 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
74:[Sun Dec 04 04:57:49 2005] [notice] jk2_init() Found child 8541 in scoreboard slot 9
75:[Sun Dec 04 04:58:11 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
77:[Sun Dec 04 04:58:45 2005] [notice] jk2_init() Found child 8547 in scoreboard slot 10
78:[Sun Dec 04 04:58:57 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
80:[Sun Dec 04 04:59:28 2005] [notice] jk2_init() Found child 8554 in scoreboard slot 6
81:[Sun Dec 04 04:59:27 2005] [notice] jk2_init() Found child 8553 in scoreboard slot 8
82:[Sun Dec 04 04:59:35 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
83:[Sun Dec 04 04:59:35 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
86:[Sun Dec 04 05:00:03 2005] [notice] jk2_init() Found child 8560 in scoreboard slot 7
87:[Sun Dec 04 05:00:09 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
89:[Sun Dec 04 05:00:13 2005] [notice] jk2_init() Found child 8565 in scoreboard slot 9
90:[Sun Dec 04 05:00:13 2005] [notice] jk2_init() Found child 8573 in scoreboard slot 10
91:[Sun Dec 04 05:00:15 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
93:[Sun Dec 04 05:00:15 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
95:[Sun Dec 04 05:01:20 2005] [notice] jk2_init() Found child 8584 in scoreboard slot 7
96:[Sun Dec 04 05:01:20 2005] [notice] jk2_init() Found child 8587 in scoreboard slot 9
97:[Sun Dec 04 05:02:14 2005] [notice] jk2_init() Found child 8603 in scoreboard slot 10
98:[Sun Dec 04 05:02:14 2005] [notice] jk2_init() Found child 8605 in scoreboard slot 8
99:[Sun Dec 04 05:04:03 2005] [notice] jk2_init() Found child 8764 in scoreboard slot 10
100:[Sun Dec 04 05:04:03 2005] [notice] jk2_init() Found child 8765 in scoreboard slot 11
101:[Sun Dec 04 05:04:03 2005] [notice] jk2_init() Found child 8763 in scoreboard slot 9
102:[Sun Dec 04 05:04:03 2005] [notice] jk2_init() Found child 8744 in scoreboard slot 8
103:[Sun Dec 04 05:04:03 2005] [notice] jk2_init() Found child 8743 in scoreboard slot 7
104:[Sun Dec 04 05:04:03 2005] [notice] jk2_init() Found child 8738 in scoreboard slot 6
105:[Sun Dec 04 05:04:03 2005] [notice] jk2_init() Found child 8766 in scoreboard slot 12
106:[Sun Dec 04 05:04:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
108:[Sun Dec 04 05:04:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
110:[Sun Dec 04 05:04:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
112:[Sun Dec 04 05:04:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
114:[Sun Dec 04 05:04:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
116:[Sun Dec 04 05:04:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
118:[Sun Dec 04 05:04:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
120:[Sun Dec 04 05:11:51 2005] [notice] jk2_init() Found child 25792 in scoreboard slot 6
121:[Sun Dec 04 05:12:07 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
123:[Sun Dec 04 05:12:26 2005] [notice] jk2_init() Found child 25798 in scoreboard slot 7
124:[Sun Dec 04 05:12:26 2005] [notice] jk2_init() Found child 25803 in scoreboard slot 8
125:[Sun Dec 04 05:12:28 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
127:[Sun Dec 04 05:12:28 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
129:[Sun Dec 04 05:12:30 2005] [notice] jk2_init() Found child 25805 in scoreboard slot 9
130:[Sun Dec 04 05:12:30 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
133:[Sun Dec 04 05:15:13 2005] [notice] jk2_init() Found child 1000 in scoreboard slot 10
134:[Sun Dec 04 05:15:16 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
136:[Sun Dec 04 06:01:00 2005] [notice] jk2_init() Found child 32347 in scoreboard slot 6
137:[Sun Dec 04 06:01:00 2005] [notice] jk2_init() Found child 32348 in scoreboard slot 7
138:[Sun Dec 04 06:01:21 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
139:[Sun Dec 04 06:01:21 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
141:[Sun Dec 04 06:01:42 2005] [notice] jk2_init() Found child 32352 in scoreboard slot 9
142:[Sun Dec 04 06:01:42 2005] [notice] jk2_init() Found child 32353 in scoreboard slot 10
143:[Sun Dec 04 06:01:42 2005] [notice] jk2_init() Found child 32354 in scoreboard slot 6
144:[Sun Dec 04 06:02:01 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
146:[Sun Dec 04 06:02:05 2005] [notice] jk2_init() Found child 32359 in scoreboard slot 9
147:[Sun Dec 04 06:02:05 2005] [notice] jk2_init() Found child 32360 in scoreboard slot 11
148:[Sun Dec 04 06:02:05 2005] [notice] jk2_init() Found child 32358 in scoreboard slot 8
149:[Sun Dec 04 06:02:05 2005] [notice] jk2_init() Found child 32355 in scoreboard slot 7
150:[Sun Dec 04 06:02:07 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
152:[Sun Dec 04 06:02:07 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
154:[Sun Dec 04 06:02:07 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
156:[Sun Dec 04 06:02:07 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
158:[Sun Dec 04 06:06:00 2005] [notice] jk2_init() Found child 32388 in scoreboard slot 8
159:[Sun Dec 04 06:06:00 2005] [notice] jk2_init() Found child 32387 in scoreboard slot 7
160:[Sun Dec 04 06:06:00 2005] [notice] jk2_init() Found child 32386 in scoreboard slot 6
161:[Sun Dec 04 06:06:10 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
162:[Sun Dec 04 06:06:11 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
165:[Sun Dec 04 06:06:20 2005] [notice] jk2_init() Found child 32389 in scoreboard slot 9
166:[Sun Dec 04 06:06:24 2005] [notice] jk2_init() Found child 32391 in scoreboard slot 10
167:[Sun Dec 04 06:06:24 2005] [notice] jk2_init() Found child 32390 in scoreboard slot 8
168:[Sun Dec 04 06:06:24 2005] [notice] jk2_init() Found child 32392 in scoreboard slot 6
169:[Sun Dec 04 06:06:26 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
171:[Sun Dec 04 06:06:26 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
173:[Sun Dec 04 06:06:26 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
175:[Sun Dec 04 06:06:26 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
177:[Sun Dec 04 06:11:11 2005] [notice] jk2_init() Found child 32410 in scoreboard slot 7
178:[Sun Dec 04 06:11:11 2005] [notice] jk2_init() Found child 32411 in scoreboard slot 9
179:[Sun Dec 04 06:12:31 2005] [notice] jk2_init() Found child 32423 in scoreboard slot 9
180:[Sun Dec 04 06:12:31 2005] [notice] jk2_init() Found child 32422 in scoreboard slot 8
181:[Sun Dec 04 06:12:31 2005] [notice] jk2_init() Found child 32419 in scoreboard slot 6
182:[Sun Dec 04 06:12:31 2005] [notice] jk2_init() Found child 32421 in scoreboard slot 11
183:[Sun Dec 04 06:12:31 2005] [notice] jk2_init() Found child 32420 in scoreboard slot 7
184:[Sun Dec 04 06:12:31 2005] [notice] jk2_init() Found child 32424 in scoreboard slot 10
185:[Sun Dec 04 06:12:37 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
186:[Sun Dec 04 06:12:37 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
187:[Sun Dec 04 06:12:37 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
188:[Sun Dec 04 06:12:37 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
189:[Sun Dec 04 06:12:37 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
195:[Sun Dec 04 06:12:59 2005] [notice] jk2_init() Found child 32425 in scoreboard slot 6
196:[Sun Dec 04 06:13:01 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
198:[Sun Dec 04 06:16:10 2005] [notice] jk2_init() Found child 32432 in scoreboard slot 7
199:[Sun Dec 04 06:16:10 2005] [notice] jk2_init() Found child 32434 in scoreboard slot 9
200:[Sun Dec 04 06:16:10 2005] [notice] jk2_init() Found child 32433 in scoreboard slot 8
201:[Sun Dec 04 06:16:21 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
202:[Sun Dec 04 06:16:21 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
205:[Sun Dec 04 06:16:21 2005] [notice] jk2_init() Found child 32435 in scoreboard slot 10
206:[Sun Dec 04 06:16:21 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
208:[Sun Dec 04 06:16:37 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
210:[Sun Dec 04 06:16:51 2005] [notice] jk2_init() Found child 32436 in scoreboard slot 6
211:[Sun Dec 04 06:16:51 2005] [notice] jk2_init() Found child 32437 in scoreboard slot 7
212:[Sun Dec 04 06:17:02 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
213:[Sun Dec 04 06:17:02 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
215:[Sun Dec 04 06:17:06 2005] [notice] jk2_init() Found child 32438 in scoreboard slot 8
216:[Sun Dec 04 06:17:18 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
218:[Sun Dec 04 06:17:23 2005] [notice] jk2_init() Found child 32440 in scoreboard slot 10
219:[Sun Dec 04 06:17:23 2005] [notice] jk2_init() Found child 32439 in scoreboard slot 9
220:[Sun Dec 04 06:17:23 2005] [notice] jk2_init() Found child 32441 in scoreboard slot 6
221:[Sun Dec 04 06:17:33 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
222:[Sun Dec 04 06:17:33 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
225:[Sun Dec 04 06:17:55 2005] [notice] jk2_init() Found child 32442 in scoreboard slot 7
226:[Sun Dec 04 06:17:55 2005] [notice] jk2_init() Found child 32443 in scoreboard slot 8
227:[Sun Dec 04 06:17:55 2005] [notice] jk2_init() Found child 32444 in scoreboard slot 9
228:[Sun Dec 04 06:18:08 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
229:[Sun Dec 04 06:18:08 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
232:[Sun Dec 04 06:18:12 2005] [notice] jk2_init() Found child 32445 in scoreboard slot 10
233:[Sun Dec 04 06:18:23 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
235:[Sun Dec 04 06:18:41 2005] [notice] jk2_init() Found child 32447 in scoreboard slot 7
236:[Sun Dec 04 06:18:39 2005] [notice] jk2_init() Found child 32446 in scoreboard slot 6
237:[Sun Dec 04 06:18:40 2005] [notice] jk2_init() Found child 32448 in scoreboard slot 8
238:[Sun Dec 04 06:18:53 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
239:[Sun Dec 04 06:18:53 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
242:[Sun Dec 04 06:19:05 2005] [notice] jk2_init() Found child 32449 in scoreboard slot 9
243:[Sun Dec 04 06:19:15 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
244:[Sun Dec 04 06:19:19 2005] [notice] jk2_init() Found child 32450 in scoreboard slot 10
246:[Sun Dec 04 06:19:19 2005] [notice] jk2_init() Found child 32452 in scoreboard slot 7
247:[Sun Dec 04 06:19:19 2005] [notice] jk2_init() Found child 32451 in scoreboard slot 6
248:[Sun Dec 04 06:19:31 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
249:[Sun Dec 04 06:19:31 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
252:[Sun Dec 04 06:19:56 2005] [notice] jk2_init() Found child 32454 in scoreboard slot 7
253:[Sun Dec 04 06:19:56 2005] [notice] jk2_init() Found child 32453 in scoreboard slot 8
254:[Sun Dec 04 06:19:56 2005] [notice] jk2_init() Found child 32455 in scoreboard slot 9
255:[Sun Dec 04 06:20:30 2005] [notice] jk2_init() Found child 32467 in scoreboard slot 9
256:[Sun Dec 04 06:20:30 2005] [notice] jk2_init() Found child 32464 in scoreboard slot 8
257:[Sun Dec 04 06:20:30 2005] [notice] jk2_init() Found child 32465 in scoreboard slot 7
258:[Sun Dec 04 06:20:30 2005] [notice] jk2_init() Found child 32466 in scoreboard slot 11
259:[Sun Dec 04 06:20:30 2005] [notice] jk2_init() Found child 32457 in scoreboard slot 6
260:[Sun Dec 04 06:20:44 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
261:[Sun Dec 04 06:20:44 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
262:[Sun Dec 04 06:20:44 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
266:[Sun Dec 04 06:22:18 2005] [notice] jk2_init() Found child 32475 in scoreboard slot 8
267:[Sun Dec 04 06:22:48 2005] [notice] jk2_init() Found child 32478 in scoreboard slot 11
268:[Sun Dec 04 06:22:48 2005] [notice] jk2_init() Found child 32477 in scoreboard slot 10
269:[Sun Dec 04 06:22:48 2005] [notice] jk2_init() Found child 32479 in scoreboard slot 6
270:[Sun Dec 04 06:22:48 2005] [notice] jk2_init() Found child 32480 in scoreboard slot 8
271:[Sun Dec 04 06:22:48 2005] [notice] jk2_init() Found child 32476 in scoreboard slot 7
272:[Sun Dec 04 06:22:53 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
273:[Sun Dec 04 06:22:53 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
274:[Sun Dec 04 06:22:53 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
275:[Sun Dec 04 06:22:53 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
276:[Sun Dec 04 06:22:53 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
282:[Sun Dec 04 06:23:12 2005] [notice] jk2_init() Found child 32483 in scoreboard slot 7
283:[Sun Dec 04 06:23:15 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
285:[Sun Dec 04 06:30:41 2005] [notice] jk2_init() Found child 32507 in scoreboard slot 9
286:[Sun Dec 04 06:30:43 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
288:[Sun Dec 04 06:36:07 2005] [notice] jk2_init() Found child 32529 in scoreboard slot 6
289:[Sun Dec 04 06:36:07 2005] [notice] jk2_init() Found child 32528 in scoreboard slot 10
290:[Sun Dec 04 06:36:10 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
292:[Sun Dec 04 06:36:10 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
294:[Sun Dec 04 06:40:54 2005] [notice] jk2_init() Found child 32548 in scoreboard slot 9
295:[Sun Dec 04 06:40:54 2005] [notice] jk2_init() Found child 32546 in scoreboard slot 8
296:[Sun Dec 04 06:40:55 2005] [notice] jk2_init() Found child 32547 in scoreboard slot 7
297:[Sun Dec 04 06:41:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
298:[Sun Dec 04 06:41:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
299:[Sun Dec 04 06:41:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
303:[Sun Dec 04 06:41:29 2005] [notice] jk2_init() Found child 32549 in scoreboard slot 10
304:[Sun Dec 04 06:41:29 2005] [notice] jk2_init() Found child 32550 in scoreboard slot 6
305:[Sun Dec 04 06:41:45 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
306:[Sun Dec 04 06:41:45 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
309:[Sun Dec 04 06:42:11 2005] [notice] jk2_init() Found child 32551 in scoreboard slot 8
310:[Sun Dec 04 06:42:11 2005] [notice] jk2_init() Found child 32552 in scoreboard slot 7
311:[Sun Dec 04 06:42:25 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
312:[Sun Dec 04 06:42:23 2005] [notice] jk2_init() Found child 32554 in scoreboard slot 10
313:[Sun Dec 04 06:42:25 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
314:[Sun Dec 04 06:42:23 2005] [notice] jk2_init() Found child 32553 in scoreboard slot 9
317:[Sun Dec 04 06:42:53 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
318:[Sun Dec 04 06:42:53 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
321:[Sun Dec 04 06:43:20 2005] [notice] jk2_init() Found child 32556 in scoreboard slot 8
322:[Sun Dec 04 06:43:20 2005] [notice] jk2_init() Found child 32555 in scoreboard slot 6
323:[Sun Dec 04 06:43:20 2005] [notice] jk2_init() Found child 32557 in scoreboard slot 7
324:[Sun Dec 04 06:43:34 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
325:[Sun Dec 04 06:43:34 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
326:[Sun Dec 04 06:43:34 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
329:[Sun Dec 04 06:43:56 2005] [notice] jk2_init() Found child 32558 in scoreboard slot 9
330:[Sun Dec 04 06:44:18 2005] [notice] jk2_init() Found child 32560 in scoreboard slot 6
331:[Sun Dec 04 06:44:18 2005] [notice] jk2_init() Found child 32561 in scoreboard slot 8
332:[Sun Dec 04 06:44:39 2005] [notice] jk2_init() Found child 32563 in scoreboard slot 9
333:[Sun Dec 04 06:44:39 2005] [notice] jk2_init() Found child 32564 in scoreboard slot 10
334:[Sun Dec 04 06:44:39 2005] [notice] jk2_init() Found child 32565 in scoreboard slot 11
335:[Sun Dec 04 06:45:32 2005] [notice] jk2_init() Found child 32575 in scoreboard slot 6
336:[Sun Dec 04 06:45:32 2005] [notice] jk2_init() Found child 32576 in scoreboard slot 7
337:[Sun Dec 04 06:45:32 2005] [notice] jk2_init() Found child 32569 in scoreboard slot 9
338:[Sun Dec 04 06:45:32 2005] [notice] jk2_init() Found child 32572 in scoreboard slot 10
339:[Sun Dec 04 06:45:32 2005] [notice] jk2_init() Found child 32577 in scoreboard slot 11
340:[Sun Dec 04 06:45:50 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
341:[Sun Dec 04 06:45:50 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
343:[Sun Dec 04 06:46:13 2005] [notice] jk2_init() Found child 32578 in scoreboard slot 8
344:[Sun Dec 04 06:46:13 2005] [notice] jk2_init() Found child 32580 in scoreboard slot 6
345:[Sun Dec 04 06:46:12 2005] [notice] jk2_init() Found child 32581 in scoreboard slot 7
346:[Sun Dec 04 06:46:13 2005] [notice] jk2_init() Found child 32579 in scoreboard slot 9
347:[Sun Dec 04 06:46:30 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
348:[Sun Dec 04 06:46:30 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
351:[Sun Dec 04 06:46:32 2005] [notice] jk2_init() Found child 32582 in scoreboard slot 10
352:[Sun Dec 04 06:46:32 2005] [notice] jk2_init() Found child 32584 in scoreboard slot 9
353:[Sun Dec 04 06:46:32 2005] [notice] jk2_init() Found child 32583 in scoreboard slot 8
354:[Sun Dec 04 06:46:33 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
356:[Sun Dec 04 06:46:34 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
358:[Sun Dec 04 06:46:34 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
360:[Sun Dec 04 06:47:19 2005] [notice] jk2_init() Found child 32585 in scoreboard slot 6
361:[Sun Dec 04 06:47:30 2005] [notice] jk2_init() Found child 32587 in scoreboard slot 10
362:[Sun Dec 04 06:47:30 2005] [notice] jk2_init() Found child 32586 in scoreboard slot 7
363:[Sun Dec 04 06:47:34 2005] [notice] jk2_init() Found child 32588 in scoreboard slot 8
364:[Sun Dec 04 06:47:38 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
365:[Sun Dec 04 06:47:39 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
366:[Sun Dec 04 06:47:39 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
368:[Sun Dec 04 06:48:09 2005] [notice] jk2_init() Found child 32592 in scoreboard slot 10
369:[Sun Dec 04 06:48:09 2005] [notice] jk2_init() Found child 32591 in scoreboard slot 7
370:[Sun Dec 04 06:48:22 2005] [notice] jk2_init() Found child 32594 in scoreboard slot 6
371:[Sun Dec 04 06:48:22 2005] [notice] jk2_init() Found child 32593 in scoreboard slot 8
372:[Sun Dec 04 06:48:48 2005] [notice] jk2_init() Found child 32597 in scoreboard slot 10
373:[Sun Dec 04 06:49:06 2005] [notice] jk2_init() Found child 32600 in scoreboard slot 9
374:[Sun Dec 04 06:49:06 2005] [notice] jk2_init() Found child 32601 in scoreboard slot 7
375:[Sun Dec 04 06:49:23 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
377:[Sun Dec 04 06:49:40 2005] [notice] jk2_init() Found child 32605 in scoreboard slot 9
378:[Sun Dec 04 06:49:40 2005] [notice] jk2_init() Found child 32604 in scoreboard slot 6
379:[Sun Dec 04 06:51:13 2005] [notice] jk2_init() Found child 32622 in scoreboard slot 7
380:[Sun Dec 04 06:51:14 2005] [notice] jk2_init() Found child 32623 in scoreboard slot 11
381:[Sun Dec 04 06:51:13 2005] [notice] jk2_init() Found child 32624 in scoreboard slot 8
382:[Sun Dec 04 06:51:13 2005] [notice] jk2_init() Found child 32621 in scoreboard slot 9
383:[Sun Dec 04 06:51:23 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
385:[Sun Dec 04 06:51:23 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
387:[Sun Dec 04 06:51:23 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
389:[Sun Dec 04 06:51:23 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
391:[Sun Dec 04 06:51:25 2005] [notice] jk2_init() Found child 32626 in scoreboard slot 6
392:[Sun Dec 04 06:51:26 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
394:[Sun Dec 04 06:52:07 2005] [notice] jk2_init() Found child 32627 in scoreboard slot 9
395:[Sun Dec 04 06:52:08 2005] [notice] jk2_init() Found child 32628 in scoreboard slot 7
396:[Sun Dec 04 06:52:13 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
397:[Sun Dec 04 06:52:14 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
400:[Sun Dec 04 06:52:27 2005] [notice] jk2_init() Found child 32630 in scoreboard slot 8
401:[Sun Dec 04 06:52:27 2005] [notice] jk2_init() Found child 32629 in scoreboard slot 10
402:[Sun Dec 04 06:52:39 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
403:[Sun Dec 04 06:52:39 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
406:[Sun Dec 04 06:53:04 2005] [notice] jk2_init() Found child 32633 in scoreboard slot 9
407:[Sun Dec 04 06:53:04 2005] [notice] jk2_init() Found child 32634 in scoreboard slot 11
408:[Sun Dec 04 06:53:04 2005] [notice] jk2_init() Found child 32632 in scoreboard slot 7
409:[Sun Dec 04 06:53:23 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
411:[Sun Dec 04 06:53:38 2005] [notice] jk2_init() Found child 32636 in scoreboard slot 6
412:[Sun Dec 04 06:53:37 2005] [notice] jk2_init() Found child 32637 in scoreboard slot 7
413:[Sun Dec 04 06:53:37 2005] [notice] jk2_init() Found child 32638 in scoreboard slot 9
414:[Sun Dec 04 06:54:04 2005] [notice] jk2_init() Found child 32640 in scoreboard slot 8
415:[Sun Dec 04 06:54:04 2005] [notice] jk2_init() Found child 32641 in scoreboard slot 6
416:[Sun Dec 04 06:54:04 2005] [notice] jk2_init() Found child 32642 in scoreboard slot 7
417:[Sun Dec 04 06:54:35 2005] [notice] jk2_init() Found child 32646 in scoreboard slot 6
418:[Sun Dec 04 06:55:00 2005] [notice] jk2_init() Found child 32648 in scoreboard slot 9
419:[Sun Dec 04 06:55:00 2005] [notice] jk2_init() Found child 32652 in scoreboard slot 7
420:[Sun Dec 04 06:55:00 2005] [notice] jk2_init() Found child 32649 in scoreboard slot 10
421:[Sun Dec 04 06:55:00 2005] [notice] jk2_init() Found child 32651 in scoreboard slot 6
422:[Sun Dec 04 06:55:00 2005] [notice] jk2_init() Found child 32650 in scoreboard slot 8
423:[Sun Dec 04 06:55:19 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
424:[Sun Dec 04 06:55:19 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
425:[Sun Dec 04 06:55:19 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
429:[Sun Dec 04 06:55:55 2005] [notice] jk2_init() Found child 32660 in scoreboard slot 6
430:[Sun Dec 04 06:55:54 2005] [notice] jk2_init() Found child 32658 in scoreboard slot 10
431:[Sun Dec 04 06:55:54 2005] [notice] jk2_init() Found child 32659 in scoreboard slot 8
432:[Sun Dec 04 06:55:54 2005] [notice] jk2_init() Found child 32657 in scoreboard slot 9
433:[Sun Dec 04 06:56:10 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
435:[Sun Dec 04 06:56:37 2005] [notice] jk2_init() Found child 32663 in scoreboard slot 10
436:[Sun Dec 04 06:56:37 2005] [notice] jk2_init() Found child 32664 in scoreboard slot 8
437:[Sun Dec 04 06:57:19 2005] [notice] jk2_init() Found child 32670 in scoreboard slot 6
438:[Sun Dec 04 06:57:19 2005] [notice] jk2_init() Found child 32667 in scoreboard slot 9
439:[Sun Dec 04 06:57:19 2005] [notice] jk2_init() Found child 32668 in scoreboard slot 10
440:[Sun Dec 04 06:57:19 2005] [notice] jk2_init() Found child 32669 in scoreboard slot 8
441:[Sun Dec 04 06:57:19 2005] [notice] jk2_init() Found child 32671 in scoreboard slot 7
442:[Sun Dec 04 06:57:23 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
443:[Sun Dec 04 06:57:23 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
446:[Sun Dec 04 06:57:23 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
448:[Sun Dec 04 06:57:23 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
450:[Sun Dec 04 06:57:24 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
452:[Sun Dec 04 06:58:12 2005] [notice] jk2_init() Found child 32674 in scoreboard slot 8
453:[Sun Dec 04 06:58:13 2005] [notice] jk2_init() Found child 32672 in scoreboard slot 9
454:[Sun Dec 04 06:58:13 2005] [notice] jk2_init() Found child 32673 in scoreboard slot 10
455:[Sun Dec 04 06:58:27 2005] [notice] jk2_init() Found child 32675 in scoreboard slot 6
456:[Sun Dec 04 06:58:28 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
457:[Sun Dec 04 06:58:28 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
460:[Sun Dec 04 06:58:51 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
462:[Sun Dec 04 06:58:54 2005] [notice] jk2_init() Found child 32677 in scoreboard slot 7
463:[Sun Dec 04 06:58:54 2005] [notice] jk2_init() Found child 32676 in scoreboard slot 9
464:[Sun Dec 04 06:58:54 2005] [notice] jk2_init() Found child 32678 in scoreboard slot 10
465:[Sun Dec 04 06:59:28 2005] [notice] jk2_init() Found child 32679 in scoreboard slot 8
466:[Sun Dec 04 06:59:28 2005] [notice] jk2_init() Found child 32680 in scoreboard slot 6
467:[Sun Dec 04 06:59:34 2005] [notice] jk2_init() Found child 32681 in scoreboard slot 9
468:[Sun Dec 04 06:59:34 2005] [notice] jk2_init() Found child 32682 in scoreboard slot 7
469:[Sun Dec 04 06:59:38 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
471:[Sun Dec 04 06:59:45 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
472:[Sun Dec 04 06:59:45 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
475:[Sun Dec 04 06:59:59 2005] [notice] jk2_init() Found child 32683 in scoreboard slot 10
476:[Sun Dec 04 07:00:06 2005] [notice] jk2_init() Found child 32685 in scoreboard slot 6
477:[Sun Dec 04 07:00:32 2005] [notice] jk2_init() Found child 32688 in scoreboard slot 11
478:[Sun Dec 04 07:00:32 2005] [notice] jk2_init() Found child 32695 in scoreboard slot 8
479:[Sun Dec 04 07:00:32 2005] [notice] jk2_init() Found child 32696 in scoreboard slot 6
480:[Sun Dec 04 07:01:25 2005] [notice] jk2_init() Found child 32701 in scoreboard slot 10
481:[Sun Dec 04 07:01:26 2005] [notice] jk2_init() Found child 32702 in scoreboard slot 11
482:[Sun Dec 04 07:01:55 2005] [notice] jk2_init() Found child 32711 in scoreboard slot 10
483:[Sun Dec 04 07:01:55 2005] [notice] jk2_init() Found child 32708 in scoreboard slot 7
484:[Sun Dec 04 07:01:55 2005] [notice] jk2_init() Found child 32710 in scoreboard slot 9
485:[Sun Dec 04 07:01:55 2005] [notice] jk2_init() Found child 32709 in scoreboard slot 8
486:[Sun Dec 04 07:01:57 2005] [notice] jk2_init() Found child 32712 in scoreboard slot 6
487:[Sun Dec 04 07:02:01 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
488:[Sun Dec 04 07:02:01 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
489:[Sun Dec 04 07:02:01 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
490:[Sun Dec 04 07:02:01 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
491:[Sun Dec 04 07:02:01 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
497:[Sun Dec 04 07:02:52 2005] [notice] jk2_init() Found child 32713 in scoreboard slot 7
498:[Sun Dec 04 07:03:23 2005] [notice] jk2_init() Found child 32717 in scoreboard slot 10
499:[Sun Dec 04 07:03:48 2005] [notice] jk2_init() Found child 32720 in scoreboard slot 8
500:[Sun Dec 04 07:04:27 2005] [notice] jk2_init() Found child 32726 in scoreboard slot 8
501:[Sun Dec 04 07:04:55 2005] [notice] jk2_init() Found child 32730 in scoreboard slot 7
502:[Sun Dec 04 07:04:55 2005] [notice] jk2_init() Found child 32729 in scoreboard slot 6
503:[Sun Dec 04 07:04:55 2005] [notice] jk2_init() Found child 32731 in scoreboard slot 8
504:[Sun Dec 04 07:05:44 2005] [notice] jk2_init() Found child 32739 in scoreboard slot 7
505:[Sun Dec 04 07:05:44 2005] [notice] jk2_init() Found child 32740 in scoreboard slot 8
506:[Sun Dec 04 07:06:11 2005] [notice] jk2_init() Found child 32742 in scoreboard slot 10
507:[Sun Dec 04 07:07:23 2005] [notice] jk2_init() Found child 32758 in scoreboard slot 7
508:[Sun Dec 04 07:07:23 2005] [notice] jk2_init() Found child 32755 in scoreboard slot 8
509:[Sun Dec 04 07:07:23 2005] [notice] jk2_init() Found child 32754 in scoreboard slot 11
510:[Sun Dec 04 07:07:30 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
511:[Sun Dec 04 07:07:30 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
512:[Sun Dec 04 07:07:30 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
516:[Sun Dec 04 07:08:02 2005] [notice] jk2_init() Found child 32761 in scoreboard slot 6
517:[Sun Dec 04 07:08:02 2005] [notice] jk2_init() Found child 32762 in scoreboard slot 9
518:[Sun Dec 04 07:08:02 2005] [notice] jk2_init() Found child 32763 in scoreboard slot 10
519:[Sun Dec 04 07:08:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
521:[Sun Dec 04 07:08:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
523:[Sun Dec 04 07:08:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
525:[Sun Dec 04 07:10:54 2005] [notice] jk2_init() Found child 308 in scoreboard slot 8
526:[Sun Dec 04 07:11:04 2005] [notice] jk2_init() Found child 310 in scoreboard slot 6
527:[Sun Dec 04 07:11:04 2005] [notice] jk2_init() Found child 309 in scoreboard slot 7
528:[Sun Dec 04 07:11:05 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
530:[Sun Dec 04 07:11:13 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
531:[Sun Dec 04 07:11:13 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
534:[Sun Dec 04 07:11:49 2005] [notice] jk2_init() Found child 311 in scoreboard slot 9
535:[Sun Dec 04 07:12:05 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
537:[Sun Dec 04 07:12:22 2005] [notice] jk2_init() Found child 312 in scoreboard slot 10
538:[Sun Dec 04 07:12:22 2005] [notice] jk2_init() Found child 313 in scoreboard slot 8
539:[Sun Dec 04 07:12:40 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
540:[Sun Dec 04 07:12:40 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
543:[Sun Dec 04 07:13:09 2005] [notice] jk2_init() Found child 314 in scoreboard slot 7
544:[Sun Dec 04 07:13:09 2005] [notice] jk2_init() Found child 315 in scoreboard slot 6
545:[Sun Dec 04 07:13:10 2005] [notice] jk2_init() Found child 316 in scoreboard slot 9
546:[Sun Dec 04 07:13:36 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
547:[Sun Dec 04 07:13:36 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
548:[Sun Dec 04 07:13:36 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
551:[Sun Dec 04 07:14:07 2005] [notice] jk2_init() Found child 319 in scoreboard slot 7
552:[Sun Dec 04 07:14:07 2005] [notice] jk2_init() Found child 317 in scoreboard slot 10
553:[Sun Dec 04 07:14:08 2005] [notice] jk2_init() Found child 318 in scoreboard slot 8
554:[Sun Dec 04 07:14:21 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
556:[Sun Dec 04 07:14:47 2005] [notice] jk2_init() Found child 321 in scoreboard slot 9
557:[Sun Dec 04 07:15:09 2005] [notice] jk2_init() Found child 324 in scoreboard slot 11
558:[Sun Dec 04 07:15:09 2005] [notice] jk2_init() Found child 323 in scoreboard slot 8
559:[Sun Dec 04 07:17:56 2005] [notice] jk2_init() Found child 350 in scoreboard slot 9
560:[Sun Dec 04 07:17:56 2005] [notice] jk2_init() Found child 353 in scoreboard slot 12
561:[Sun Dec 04 07:17:56 2005] [notice] jk2_init() Found child 352 in scoreboard slot 11
562:[Sun Dec 04 07:17:56 2005] [notice] jk2_init() Found child 349 in scoreboard slot 8
563:[Sun Dec 04 07:17:56 2005] [notice] jk2_init() Found child 348 in scoreboard slot 7
564:[Sun Dec 04 07:17:56 2005] [notice] jk2_init() Found child 347 in scoreboard slot 6
565:[Sun Dec 04 07:17:56 2005] [notice] jk2_init() Found child 351 in scoreboard slot 10
566:[Sun Dec 04 07:18:00 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
568:[Sun Dec 04 07:18:00 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
570:[Sun Dec 04 07:18:00 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
572:[Sun Dec 04 07:18:00 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
574:[Sun Dec 04 07:18:00 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
576:[Sun Dec 04 07:18:00 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
578:[Sun Dec 04 07:18:00 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
592:[Sun Dec 04 16:24:03 2005] [notice] jk2_init() Found child 1219 in scoreboard slot 6
594:[Sun Dec 04 16:24:06 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
596:[Sun Dec 04 16:31:07 2005] [notice] jk2_init() Found child 1248 in scoreboard slot 7
597:[Sun Dec 04 16:32:37 2005] [notice] jk2_init() Found child 1253 in scoreboard slot 9
598:[Sun Dec 04 16:32:56 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
600:[Sun Dec 04 16:32:58 2005] [notice] jk2_init() Found child 1254 in scoreboard slot 7
601:[Sun Dec 04 16:32:58 2005] [notice] jk2_init() Found child 1256 in scoreboard slot 6
602:[Sun Dec 04 16:32:58 2005] [notice] jk2_init() Found child 1255 in scoreboard slot 8
603:[Sun Dec 04 16:32:58 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
605:[Sun Dec 04 16:32:58 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
607:[Sun Dec 04 16:32:58 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
609:[Sun Dec 04 16:35:49 2005] [notice] jk2_init() Found child 1262 in scoreboard slot 9
610:[Sun Dec 04 16:35:52 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
612:[Sun Dec 04 16:41:15 2005] [notice] jk2_init() Found child 1275 in scoreboard slot 6
613:[Sun Dec 04 16:41:16 2005] [notice] jk2_init() Found child 1276 in scoreboard slot 9
614:[Sun Dec 04 16:41:22 2005] [notice] jk2_init() Found child 1277 in scoreboard slot 7
615:[Sun Dec 04 16:41:22 2005] [notice] jk2_init() Found child 1278 in scoreboard slot 8
616:[Sun Dec 04 16:41:22 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
617:[Sun Dec 04 16:41:22 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
618:[Sun Dec 04 16:41:22 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
619:[Sun Dec 04 16:41:22 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
624:[Sun Dec 04 16:45:52 2005] [notice] jk2_init() Found child 1283 in scoreboard slot 6
625:[Sun Dec 04 16:45:52 2005] [notice] jk2_init() Found child 1284 in scoreboard slot 9
626:[Sun Dec 04 16:46:09 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
628:[Sun Dec 04 16:46:45 2005] [notice] jk2_init() Found child 1288 in scoreboard slot 9
629:[Sun Dec 04 16:47:11 2005] [notice] jk2_init() Found child 1291 in scoreboard slot 6
630:[Sun Dec 04 16:47:59 2005] [notice] jk2_init() Found child 1296 in scoreboard slot 6
631:[Sun Dec 04 16:47:59 2005] [notice] jk2_init() Found child 1300 in scoreboard slot 10
632:[Sun Dec 04 16:47:59 2005] [notice] jk2_init() Found child 1298 in scoreboard slot 8
633:[Sun Dec 04 16:47:59 2005] [notice] jk2_init() Found child 1297 in scoreboard slot 7
634:[Sun Dec 04 16:47:59 2005] [notice] jk2_init() Found child 1299 in scoreboard slot 9
635:[Sun Dec 04 16:48:01 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
637:[Sun Dec 04 16:48:01 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
639:[Sun Dec 04 16:48:01 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
641:[Sun Dec 04 16:48:01 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
643:[Sun Dec 04 16:48:01 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
645:[Sun Dec 04 16:50:53 2005] [notice] jk2_init() Found child 1308 in scoreboard slot 6
646:[Sun Dec 04 16:50:53 2005] [notice] jk2_init() Found child 1309 in scoreboard slot 7
647:[Sun Dec 04 16:51:26 2005] [notice] jk2_init() Found child 1313 in scoreboard slot 6
648:[Sun Dec 04 16:51:26 2005] [notice] jk2_init() Found child 1312 in scoreboard slot 10
649:[Sun Dec 04 16:52:34 2005] [notice] jk2_init() Found child 1320 in scoreboard slot 8
650:[Sun Dec 04 16:52:45 2005] [notice] jk2_init() Found child 1321 in scoreboard slot 9
651:[Sun Dec 04 16:52:45 2005] [notice] jk2_init() Found child 1322 in scoreboard slot 10
652:[Sun Dec 04 16:52:45 2005] [notice] jk2_init() Found child 1323 in scoreboard slot 6
653:[Sun Dec 04 16:52:46 2005] [notice] jk2_init() Found child 1324 in scoreboard slot 7
654:[Sun Dec 04 16:52:46 2005] [notice] jk2_init() Found child 1325 in scoreboard slot 8
655:[Sun Dec 04 16:52:49 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
656:[Sun Dec 04 16:52:49 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
657:[Sun Dec 04 16:52:49 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
658:[Sun Dec 04 16:52:49 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
659:[Sun Dec 04 16:52:49 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
665:[Sun Dec 04 16:55:54 2005] [notice] jk2_init() Found child 1331 in scoreboard slot 10
666:[Sun Dec 04 16:56:25 2005] [notice] jk2_init() Found child 1338 in scoreboard slot 7
667:[Sun Dec 04 16:56:25 2005] [notice] jk2_init() Found child 1334 in scoreboard slot 8
668:[Sun Dec 04 16:56:25 2005] [notice] jk2_init() Found child 1336 in scoreboard slot 10
669:[Sun Dec 04 16:56:25 2005] [notice] jk2_init() Found child 1337 in scoreboard slot 6
670:[Sun Dec 04 16:56:25 2005] [notice] jk2_init() Found child 1335 in scoreboard slot 9
671:[Sun Dec 04 16:56:27 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
673:[Sun Dec 04 16:56:27 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
675:[Sun Dec 04 16:56:27 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
677:[Sun Dec 04 16:56:27 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
679:[Sun Dec 04 16:56:27 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
681:[Sun Dec 04 17:01:43 2005] [notice] jk2_init() Found child 1358 in scoreboard slot 8
682:[Sun Dec 04 17:01:43 2005] [notice] jk2_init() Found child 1356 in scoreboard slot 6
683:[Sun Dec 04 17:01:43 2005] [notice] jk2_init() Found child 1354 in scoreboard slot 9
684:[Sun Dec 04 17:01:43 2005] [notice] jk2_init() Found child 1357 in scoreboard slot 7
685:[Sun Dec 04 17:01:43 2005] [notice] jk2_init() Found child 1355 in scoreboard slot 10
686:[Sun Dec 04 17:01:47 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
688:[Sun Dec 04 17:01:47 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
690:[Sun Dec 04 17:01:47 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
692:[Sun Dec 04 17:01:47 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
694:[Sun Dec 04 17:01:47 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
696:[Sun Dec 04 17:05:45 2005] [notice] jk2_init() Found child 1375 in scoreboard slot 9
697:[Sun Dec 04 17:05:45 2005] [notice] jk2_init() Found child 1376 in scoreboard slot 10
698:[Sun Dec 04 17:05:45 2005] [notice] jk2_init() Found child 1377 in scoreboard slot 6
699:[Sun Dec 04 17:05:48 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
700:[Sun Dec 04 17:05:48 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
701:[Sun Dec 04 17:05:48 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
705:[Sun Dec 04 17:11:23 2005] [notice] jk2_init() Found child 1387 in scoreboard slot 7
706:[Sun Dec 04 17:11:37 2005] [notice] jk2_init() Found child 1390 in scoreboard slot 10
707:[Sun Dec 04 17:11:37 2005] [notice] jk2_init() Found child 1388 in scoreboard slot 8
708:[Sun Dec 04 17:11:37 2005] [notice] jk2_init() Found child 1389 in scoreboard slot 9
709:[Sun Dec 04 17:12:42 2005] [notice] jk2_init() Found child 1393 in scoreboard slot 8
710:[Sun Dec 04 17:12:50 2005] [notice] jk2_init() Found child 1395 in scoreboard slot 10
711:[Sun Dec 04 17:12:50 2005] [notice] jk2_init() Found child 1396 in scoreboard slot 6
712:[Sun Dec 04 17:12:50 2005] [notice] jk2_init() Found child 1394 in scoreboard slot 9
713:[Sun Dec 04 17:12:54 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
714:[Sun Dec 04 17:12:54 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
715:[Sun Dec 04 17:12:54 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
716:[Sun Dec 04 17:12:54 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
721:[Sun Dec 04 17:12:56 2005] [notice] jk2_init() Found child 1397 in scoreboard slot 7
722:[Sun Dec 04 17:12:57 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
724:[Sun Dec 04 17:17:07 2005] [notice] jk2_init() Found child 1414 in scoreboard slot 7
725:[Sun Dec 04 17:17:07 2005] [notice] jk2_init() Found child 1412 in scoreboard slot 10
726:[Sun Dec 04 17:17:07 2005] [notice] jk2_init() Found child 1413 in scoreboard slot 6
727:[Sun Dec 04 17:20:38 2005] [notice] jk2_init() Found child 1448 in scoreboard slot 6
728:[Sun Dec 04 17:20:38 2005] [notice] jk2_init() Found child 1439 in scoreboard slot 7
729:[Sun Dec 04 17:20:38 2005] [notice] jk2_init() Found child 1441 in scoreboard slot 9
730:[Sun Dec 04 17:20:38 2005] [notice] jk2_init() Found child 1450 in scoreboard slot 11
731:[Sun Dec 04 17:20:39 2005] [notice] jk2_init() Found child 1449 in scoreboard slot 10
732:[Sun Dec 04 17:20:39 2005] [notice] jk2_init() Found child 1440 in scoreboard slot 8
733:[Sun Dec 04 17:20:44 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
734:[Sun Dec 04 17:20:44 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
735:[Sun Dec 04 17:20:44 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
736:[Sun Dec 04 17:20:44 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
737:[Sun Dec 04 17:20:44 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
743:[Sun Dec 04 17:21:01 2005] [notice] jk2_init() Found child 1452 in scoreboard slot 7
744:[Sun Dec 04 17:21:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
746:[Sun Dec 04 17:26:04 2005] [notice] jk2_init() Found child 1461 in scoreboard slot 8
747:[Sun Dec 04 17:26:39 2005] [notice] jk2_init() Found child 1462 in scoreboard slot 6
748:[Sun Dec 04 17:27:13 2005] [notice] jk2_init() Found child 1466 in scoreboard slot 8
749:[Sun Dec 04 17:28:00 2005] [notice] jk2_init() Found child 1470 in scoreboard slot 7
750:[Sun Dec 04 17:28:42 2005] [notice] jk2_init() Found child 1477 in scoreboard slot 6
751:[Sun Dec 04 17:28:41 2005] [notice] jk2_init() Found child 1476 in scoreboard slot 8
752:[Sun Dec 04 17:31:00 2005] [notice] jk2_init() Found child 1501 in scoreboard slot 7
753:[Sun Dec 04 17:31:00 2005] [notice] jk2_init() Found child 1502 in scoreboard slot 6
754:[Sun Dec 04 17:31:00 2005] [notice] jk2_init() Found child 1498 in scoreboard slot 8
755:[Sun Dec 04 17:31:00 2005] [notice] jk2_init() Found child 1499 in scoreboard slot 11
756:[Sun Dec 04 17:31:10 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
757:[Sun Dec 04 17:31:10 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
758:[Sun Dec 04 17:31:10 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
759:[Sun Dec 04 17:31:11 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
764:[Sun Dec 04 17:31:43 2005] [notice] jk2_init() Found child 1503 in scoreboard slot 9
765:[Sun Dec 04 17:31:43 2005] [notice] jk2_init() Found child 1504 in scoreboard slot 8
766:[Sun Dec 04 17:31:45 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
767:[Sun Dec 04 17:31:45 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
770:[Sun Dec 04 17:34:52 2005] [notice] jk2_init() Found child 1507 in scoreboard slot 10
771:[Sun Dec 04 17:34:57 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
774:[Sun Dec 04 17:36:14 2005] [notice] jk2_init() Found child 1512 in scoreboard slot 7
775:[Sun Dec 04 17:36:14 2005] [notice] jk2_init() Found child 1513 in scoreboard slot 6
776:[Sun Dec 04 17:37:08 2005] [notice] jk2_init() Found child 1517 in scoreboard slot 7
777:[Sun Dec 04 17:37:08 2005] [notice] jk2_init() Found child 1518 in scoreboard slot 6
778:[Sun Dec 04 17:37:47 2005] [notice] jk2_init() Found child 1520 in scoreboard slot 8
779:[Sun Dec 04 17:37:47 2005] [notice] jk2_init() Found child 1521 in scoreboard slot 10
780:[Sun Dec 04 17:39:00 2005] [notice] jk2_init() Found child 1529 in scoreboard slot 9
781:[Sun Dec 04 17:39:01 2005] [notice] jk2_init() Found child 1530 in scoreboard slot 8
782:[Sun Dec 04 17:39:00 2005] [notice] jk2_init() Found child 1528 in scoreboard slot 7
783:[Sun Dec 04 17:39:00 2005] [notice] jk2_init() Found child 1527 in scoreboard slot 6
784:[Sun Dec 04 17:43:08 2005] [notice] jk2_init() Found child 1565 in scoreboard slot 9
786:[Sun Dec 04 17:43:08 2005] [notice] jk2_init() Found child 1561 in scoreboard slot 6
787:[Sun Dec 04 17:43:08 2005] [notice] jk2_init() Found child 1563 in scoreboard slot 8
788:[Sun Dec 04 17:43:08 2005] [notice] jk2_init() Found child 1562 in scoreboard slot 7
790:[Sun Dec 04 17:43:08 2005] [notice] jk2_init() Found child 1568 in scoreboard slot 13
791:[Sun Dec 04 17:43:12 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
793:[Sun Dec 04 17:43:12 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
795:[Sun Dec 04 17:43:12 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
797:[Sun Dec 04 17:43:12 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
799:[Sun Dec 04 17:43:12 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
801:[Sun Dec 04 17:43:12 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
803:[Sun Dec 04 17:43:12 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
807:[Sun Dec 04 19:25:51 2005] [notice] jk2_init() Found child 1763 in scoreboard slot 6
808:[Sun Dec 04 19:25:53 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
810:[Sun Dec 04 19:32:20 2005] [notice] jk2_init() Found child 1786 in scoreboard slot 8
811:[Sun Dec 04 19:32:20 2005] [notice] jk2_init() Found child 1787 in scoreboard slot 9
812:[Sun Dec 04 19:32:32 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
814:[Sun Dec 04 19:32:34 2005] [notice] jk2_init() Found child 1788 in scoreboard slot 6
815:[Sun Dec 04 19:32:34 2005] [notice] jk2_init() Found child 1790 in scoreboard slot 8
816:[Sun Dec 04 19:32:34 2005] [notice] jk2_init() Found child 1789 in scoreboard slot 7
817:[Sun Dec 04 19:32:34 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
819:[Sun Dec 04 19:32:34 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
821:[Sun Dec 04 19:32:34 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
823:[Sun Dec 04 19:35:58 2005] [notice] jk2_init() Found child 1797 in scoreboard slot 9
824:[Sun Dec 04 19:35:58 2005] [notice] jk2_init() Found child 1798 in scoreboard slot 6
825:[Sun Dec 04 19:35:58 2005] [notice] jk2_init() Found child 1799 in scoreboard slot 7
826:[Sun Dec 04 19:35:58 2005] [notice] jk2_init() Found child 1800 in scoreboard slot 10
827:[Sun Dec 04 19:35:58 2005] [notice] jk2_init() Found child 1801 in scoreboard slot 12
829:[Sun Dec 04 19:36:07 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
831:[Sun Dec 04 19:36:07 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
833:[Sun Dec 04 19:36:07 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
835:[Sun Dec 04 19:36:07 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
837:[Sun Dec 04 19:36:07 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
839:[Sun Dec 04 19:41:20 2005] [notice] jk2_init() Found child 1816 in scoreboard slot 9
840:[Sun Dec 04 19:41:20 2005] [notice] jk2_init() Found child 1814 in scoreboard slot 7
841:[Sun Dec 04 19:41:20 2005] [notice] jk2_init() Found child 1813 in scoreboard slot 6
842:[Sun Dec 04 19:41:20 2005] [notice] jk2_init() Found child 1815 in scoreboard slot 8
843:[Sun Dec 04 19:41:21 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
845:[Sun Dec 04 19:41:21 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
847:[Sun Dec 04 19:41:21 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
849:[Sun Dec 04 19:41:21 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
851:[Sun Dec 04 19:46:04 2005] [notice] jk2_init() Found child 1821 in scoreboard slot 6
852:[Sun Dec 04 19:46:04 2005] [notice] jk2_init() Found child 1822 in scoreboard slot 7
853:[Sun Dec 04 19:46:13 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
854:[Sun Dec 04 19:46:13 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
857:[Sun Dec 04 19:46:16 2005] [notice] jk2_init() Found child 1823 in scoreboard slot 8
858:[Sun Dec 04 19:46:19 2005] [notice] jk2_init() Found child 1824 in scoreboard slot 9
859:[Sun Dec 04 19:46:20 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
861:[Sun Dec 04 19:46:20 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
863:[Sun Dec 04 19:50:39 2005] [notice] jk2_init() Found child 1833 in scoreboard slot 7
864:[Sun Dec 04 19:50:39 2005] [notice] jk2_init() Found child 1832 in scoreboard slot 6
865:[Sun Dec 04 19:50:51 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
866:[Sun Dec 04 19:50:51 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
868:[Sun Dec 04 19:50:57 2005] [notice] jk2_init() Found child 1834 in scoreboard slot 8
870:[Sun Dec 04 19:51:16 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
872:[Sun Dec 04 19:51:43 2005] [notice] jk2_init() Found child 1835 in scoreboard slot 9
873:[Sun Dec 04 19:51:52 2005] [notice] jk2_init() Found child 1836 in scoreboard slot 6
874:[Sun Dec 04 19:51:52 2005] [notice] jk2_init() Found child 1837 in scoreboard slot 7
875:[Sun Dec 04 19:51:54 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
877:[Sun Dec 04 19:51:54 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
879:[Sun Dec 04 19:51:54 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
881:[Sun Dec 04 19:56:51 2005] [notice] jk2_init() Found child 1851 in scoreboard slot 6
882:[Sun Dec 04 19:56:51 2005] [notice] jk2_init() Found child 1852 in scoreboard slot 9
883:[Sun Dec 04 19:56:51 2005] [notice] jk2_init() Found child 1853 in scoreboard slot 7
884:[Sun Dec 04 19:56:51 2005] [notice] jk2_init() Found child 1850 in scoreboard slot 8
885:[Sun Dec 04 19:56:53 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
887:[Sun Dec 04 19:56:53 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
889:[Sun Dec 04 19:56:53 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
891:[Sun Dec 04 19:56:53 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
893:[Sun Dec 04 20:01:00 2005] [notice] jk2_init() Found child 1861 in scoreboard slot 8
894:[Sun Dec 04 20:01:00 2005] [notice] jk2_init() Found child 1862 in scoreboard slot 6
895:[Sun Dec 04 20:01:30 2005] [notice] jk2_init() Found child 1867 in scoreboard slot 8
896:[Sun Dec 04 20:01:30 2005] [notice] jk2_init() Found child 1864 in scoreboard slot 7
897:[Sun Dec 04 20:01:30 2005] [notice] jk2_init() Found child 1868 in scoreboard slot 6
898:[Sun Dec 04 20:01:30 2005] [notice] jk2_init() Found child 1863 in scoreboard slot 9
899:[Sun Dec 04 20:01:37 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
900:[Sun Dec 04 20:01:37 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
901:[Sun Dec 04 20:01:37 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
902:[Sun Dec 04 20:01:37 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
907:[Sun Dec 04 20:05:55 2005] [notice] jk2_init() Found child 1887 in scoreboard slot 8
908:[Sun Dec 04 20:05:55 2005] [notice] jk2_init() Found child 1885 in scoreboard slot 9
909:[Sun Dec 04 20:05:55 2005] [notice] jk2_init() Found child 1888 in scoreboard slot 6
910:[Sun Dec 04 20:05:55 2005] [notice] jk2_init() Found child 1886 in scoreboard slot 7
911:[Sun Dec 04 20:05:58 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
913:[Sun Dec 04 20:05:59 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
915:[Sun Dec 04 20:05:59 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
917:[Sun Dec 04 20:05:59 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
919:[Sun Dec 04 20:11:09 2005] [notice] jk2_init() Found child 1899 in scoreboard slot 7
920:[Sun Dec 04 20:11:09 2005] [notice] jk2_init() Found child 1900 in scoreboard slot 8
921:[Sun Dec 04 20:11:09 2005] [notice] jk2_init() Found child 1901 in scoreboard slot 6
922:[Sun Dec 04 20:11:09 2005] [notice] jk2_init() Found child 1898 in scoreboard slot 9
923:[Sun Dec 04 20:11:14 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
925:[Sun Dec 04 20:11:14 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
927:[Sun Dec 04 20:11:14 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
929:[Sun Dec 04 20:11:14 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
931:[Sun Dec 04 20:16:10 2005] [notice] jk2_init() Found child 1912 in scoreboard slot 9
932:[Sun Dec 04 20:16:10 2005] [notice] jk2_init() Found child 1915 in scoreboard slot 6
933:[Sun Dec 04 20:16:10 2005] [notice] jk2_init() Found child 1913 in scoreboard slot 7
934:[Sun Dec 04 20:16:10 2005] [notice] jk2_init() Found child 1914 in scoreboard slot 8
935:[Sun Dec 04 20:16:15 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
936:[Sun Dec 04 20:16:15 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
937:[Sun Dec 04 20:16:15 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
938:[Sun Dec 04 20:16:15 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
943:[Sun Dec 04 20:20:57 2005] [notice] jk2_init() Found child 1931 in scoreboard slot 7
944:[Sun Dec 04 20:21:09 2005] [notice] jk2_init() Found child 1932 in scoreboard slot 8
945:[Sun Dec 04 20:21:08 2005] [notice] jk2_init() Found child 1933 in scoreboard slot 6
946:[Sun Dec 04 20:21:21 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
947:[Sun Dec 04 20:21:31 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
948:[Sun Dec 04 20:21:31 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
949:[Sun Dec 04 20:21:37 2005] [notice] jk2_init() Found child 1934 in scoreboard slot 9
951:[Sun Dec 04 20:22:09 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
952:[Sun Dec 04 20:22:12 2005] [notice] jk2_init() Found child 1936 in scoreboard slot 8
953:[Sun Dec 04 20:22:12 2005] [notice] jk2_init() Found child 1935 in scoreboard slot 7
954:[Sun Dec 04 20:22:49 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
956:[Sun Dec 04 20:22:57 2005] [notice] jk2_init() Found child 1937 in scoreboard slot 6
957:[Sun Dec 04 20:23:12 2005] [notice] jk2_init() Found child 1938 in scoreboard slot 9
958:[Sun Dec 04 20:24:45 2005] [notice] jk2_init() Found child 1950 in scoreboard slot 9
959:[Sun Dec 04 20:24:45 2005] [notice] jk2_init() Found child 1951 in scoreboard slot 7
960:[Sun Dec 04 20:24:45 2005] [notice] jk2_init() Found child 1949 in scoreboard slot 6
961:[Sun Dec 04 20:24:45 2005] [notice] jk2_init() Found child 1948 in scoreboard slot 8
962:[Sun Dec 04 20:24:49 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
964:[Sun Dec 04 20:24:49 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
966:[Sun Dec 04 20:24:49 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
968:[Sun Dec 04 20:24:49 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
970:[Sun Dec 04 20:26:10 2005] [notice] jk2_init() Found child 1957 in scoreboard slot 8
971:[Sun Dec 04 20:26:53 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
973:[Sun Dec 04 20:26:58 2005] [notice] jk2_init() Found child 1959 in scoreboard slot 9
974:[Sun Dec 04 20:26:58 2005] [notice] jk2_init() Found child 1958 in scoreboard slot 6
975:[Sun Dec 04 20:27:43 2005] [notice] jk2_init() Found child 1961 in scoreboard slot 8
976:[Sun Dec 04 20:28:00 2005] [notice] jk2_init() Found child 1962 in scoreboard slot 6
977:[Sun Dec 04 20:28:00 2005] [notice] jk2_init() Found child 1963 in scoreboard slot 9
978:[Sun Dec 04 20:28:26 2005] [notice] jk2_init() Found child 1964 in scoreboard slot 7
979:[Sun Dec 04 20:28:39 2005] [notice] jk2_init() Found child 1966 in scoreboard slot 6
980:[Sun Dec 04 20:28:39 2005] [notice] jk2_init() Found child 1967 in scoreboard slot 9
981:[Sun Dec 04 20:28:39 2005] [notice] jk2_init() Found child 1965 in scoreboard slot 8
982:[Sun Dec 04 20:29:34 2005] [notice] jk2_init() Found child 1970 in scoreboard slot 6
983:[Sun Dec 04 20:30:59 2005] [notice] jk2_init() Found child 1984 in scoreboard slot 10
984:[Sun Dec 04 20:31:35 2005] [notice] jk2_init() Found child 1990 in scoreboard slot 9
985:[Sun Dec 04 20:32:37 2005] [notice] jk2_init() Found child 1999 in scoreboard slot 6
986:[Sun Dec 04 20:32:37 2005] [notice] jk2_init() Found child 2000 in scoreboard slot 7
987:[Sun Dec 04 20:32:37 2005] [notice] jk2_init() Found child 1998 in scoreboard slot 9
988:[Sun Dec 04 20:32:50 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
989:[Sun Dec 04 20:32:50 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
990:[Sun Dec 04 20:32:50 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
994:[Sun Dec 04 20:33:35 2005] [notice] jk2_init() Found child 2002 in scoreboard slot 8
995:[Sun Dec 04 20:33:35 2005] [notice] jk2_init() Found child 2001 in scoreboard slot 9
996:[Sun Dec 04 20:33:47 2005] [notice] jk2_init() Found child 2005 in scoreboard slot 7
997:[Sun Dec 04 20:33:47 2005] [notice] jk2_init() Found child 2004 in scoreboard slot 6
998:[Sun Dec 04 20:34:13 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1000:[Sun Dec 04 20:34:20 2005] [notice] jk2_init() Found child 2007 in scoreboard slot 8
1001:[Sun Dec 04 20:34:20 2005] [notice] jk2_init() Found child 2006 in scoreboard slot 9
1002:[Sun Dec 04 20:34:21 2005] [notice] jk2_init() Found child 2008 in scoreboard slot 6
1003:[Sun Dec 04 20:34:25 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1005:[Sun Dec 04 20:34:25 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1007:[Sun Dec 04 20:34:25 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1009:[Sun Dec 04 20:37:29 2005] [notice] jk2_init() Found child 2028 in scoreboard slot 9
1010:[Sun Dec 04 20:37:29 2005] [notice] jk2_init() Found child 2027 in scoreboard slot 7
1011:[Sun Dec 04 20:37:29 2005] [notice] jk2_init() Found child 2029 in scoreboard slot 8
1012:[Sun Dec 04 20:37:46 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1013:[Sun Dec 04 20:37:46 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1016:[Sun Dec 04 20:38:10 2005] [notice] jk2_init() Found child 2030 in scoreboard slot 6
1017:[Sun Dec 04 20:38:10 2005] [notice] jk2_init() Found child 2031 in scoreboard slot 7
1018:[Sun Dec 04 20:38:11 2005] [notice] jk2_init() Found child 2032 in scoreboard slot 9
1019:[Sun Dec 04 20:38:14 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1020:[Sun Dec 04 20:38:14 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1021:[Sun Dec 04 20:38:14 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1025:[Sun Dec 04 20:41:12 2005] [notice] jk2_init() Found child 2042 in scoreboard slot 8
1026:[Sun Dec 04 20:41:47 2005] [notice] jk2_init() Found child 2045 in scoreboard slot 9
1027:[Sun Dec 04 20:42:42 2005] [notice] jk2_init() Found child 2051 in scoreboard slot 8
1028:[Sun Dec 04 20:44:29 2005] [notice] jk2_init() Found child 2059 in scoreboard slot 7
1029:[Sun Dec 04 20:44:29 2005] [notice] jk2_init() Found child 2060 in scoreboard slot 9
1030:[Sun Dec 04 20:44:30 2005] [notice] jk2_init() Found child 2061 in scoreboard slot 8
1031:[Sun Dec 04 20:47:16 2005] [notice] jk2_init() Found child 2081 in scoreboard slot 6
1033:[Sun Dec 04 20:47:16 2005] [notice] jk2_init() Found child 2083 in scoreboard slot 8
1034:[Sun Dec 04 20:47:16 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1036:[Sun Dec 04 20:47:16 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1038:[Sun Dec 04 20:47:16 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1041:[Sun Dec 04 20:47:17 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1044:[Sun Dec 04 20:47:17 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1047:[Sun Dec 04 20:47:17 2005] [notice] jk2_init() Found child 2084 in scoreboard slot 9
1048:[Sun Dec 04 20:47:17 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1050:[Sun Dec 04 20:47:17 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1054:[Mon Dec 05 03:21:00 2005] [notice] jk2_init() Found child 2760 in scoreboard slot 6
1055:[Mon Dec 05 03:21:02 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1057:[Mon Dec 05 03:23:21 2005] [notice] jk2_init() Found child 2763 in scoreboard slot 7
1058:[Mon Dec 05 03:23:24 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1061:[Mon Dec 05 03:25:44 2005] [notice] jk2_init() Found child 2773 in scoreboard slot 6
1062:[Mon Dec 05 03:25:46 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1064:[Mon Dec 05 03:36:51 2005] [notice] jk2_init() Found child 2813 in scoreboard slot 7
1065:[Mon Dec 05 03:36:51 2005] [notice] jk2_init() Found child 2815 in scoreboard slot 8
1066:[Mon Dec 05 03:36:51 2005] [notice] jk2_init() Found child 2812 in scoreboard slot 6
1067:[Mon Dec 05 03:36:51 2005] [notice] jk2_init() Found child 2811 in scoreboard slot 9
1068:[Mon Dec 05 03:36:57 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1069:[Mon Dec 05 03:36:57 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1070:[Mon Dec 05 03:36:57 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1071:[Mon Dec 05 03:36:57 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1076:[Mon Dec 05 03:40:46 2005] [notice] jk2_init() Found child 2823 in scoreboard slot 9
1077:[Mon Dec 05 03:40:55 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1079:[Mon Dec 05 03:44:50 2005] [notice] jk2_init() Found child 2824 in scoreboard slot 10
1081:[Mon Dec 05 03:44:50 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1083:[Mon Dec 05 03:46:38 2005] [notice] jk2_init() Found child 2838 in scoreboard slot 10
1084:[Mon Dec 05 03:46:38 2005] [notice] jk2_init() Found child 2836 in scoreboard slot 9
1085:[Mon Dec 05 03:46:38 2005] [notice] jk2_init() Found child 2837 in scoreboard slot 6
1086:[Mon Dec 05 03:46:50 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1087:[Mon Dec 05 03:47:02 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1088:[Mon Dec 05 03:47:19 2005] [notice] jk2_init() Found child 2840 in scoreboard slot 8
1089:[Mon Dec 05 03:47:19 2005] [notice] jk2_init() Found child 2841 in scoreboard slot 6
1090:[Mon Dec 05 03:47:19 2005] [notice] jk2_init() Found child 2842 in scoreboard slot 9
1091:[Mon Dec 05 03:47:53 2005] [notice] jk2_init() Found child 2846 in scoreboard slot 9
1092:[Mon Dec 05 03:47:53 2005] [notice] jk2_init() Found child 2843 in scoreboard slot 7
1093:[Mon Dec 05 03:47:53 2005] [notice] jk2_init() Found child 2844 in scoreboard slot 8
1094:[Mon Dec 05 03:47:53 2005] [notice] jk2_init() Found child 2845 in scoreboard slot 6
1095:[Mon Dec 05 03:47:54 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1097:[Mon Dec 05 03:47:54 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1099:[Mon Dec 05 03:47:54 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1101:[Mon Dec 05 03:47:54 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1103:[Mon Dec 05 03:50:49 2005] [notice] jk2_init() Found child 2857 in scoreboard slot 9
1104:[Mon Dec 05 03:50:50 2005] [notice] jk2_init() Found child 2854 in scoreboard slot 7
1105:[Mon Dec 05 03:50:49 2005] [notice] jk2_init() Found child 2855 in scoreboard slot 8
1106:[Mon Dec 05 03:50:49 2005] [notice] jk2_init() Found child 2856 in scoreboard slot 6
1107:[Mon Dec 05 03:50:59 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1108:[Mon Dec 05 03:50:59 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1109:[Mon Dec 05 03:50:59 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1110:[Mon Dec 05 03:50:59 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1115:[Mon Dec 05 03:56:12 2005] [notice] jk2_init() Found child 2866 in scoreboard slot 7
1116:[Mon Dec 05 03:56:12 2005] [notice] jk2_init() Found child 2867 in scoreboard slot 8
1117:[Mon Dec 05 03:56:12 2005] [notice] jk2_init() Found child 2865 in scoreboard slot 9
1118:[Mon Dec 05 03:56:12 2005] [notice] jk2_init() Found child 2864 in scoreboard slot 6
1119:[Mon Dec 05 03:56:15 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1121:[Mon Dec 05 03:56:15 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1123:[Mon Dec 05 03:56:15 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1125:[Mon Dec 05 03:56:15 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1127:[Mon Dec 05 04:00:55 2005] [notice] jk2_init() Found child 2877 in scoreboard slot 10
1128:[Mon Dec 05 04:01:18 2005] [notice] jk2_init() Found child 2883 in scoreboard slot 9
1129:[Mon Dec 05 04:01:18 2005] [notice] jk2_init() Found child 2878 in scoreboard slot 7
1130:[Mon Dec 05 04:01:18 2005] [notice] jk2_init() Found child 2880 in scoreboard slot 8
1131:[Mon Dec 05 04:01:18 2005] [notice] jk2_init() Found child 2879 in scoreboard slot 6
1132:[Mon Dec 05 04:01:23 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1134:[Mon Dec 05 04:01:23 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1136:[Mon Dec 05 04:01:23 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1138:[Mon Dec 05 04:01:23 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1140:[Mon Dec 05 04:06:19 2005] [notice] jk2_init() Found child 3667 in scoreboard slot 7
1141:[Mon Dec 05 04:06:19 2005] [notice] jk2_init() Found child 3669 in scoreboard slot 6
1142:[Mon Dec 05 04:06:27 2005] [notice] jk2_init() Found child 3670 in scoreboard slot 8
1143:[Mon Dec 05 04:06:43 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1144:[Mon Dec 05 04:06:43 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1147:[Mon Dec 05 04:07:23 2005] [notice] jk2_init() Found child 3672 in scoreboard slot 7
1148:[Mon Dec 05 04:07:37 2005] [notice] jk2_init() Found child 3673 in scoreboard slot 6
1149:[Mon Dec 05 04:07:48 2005] [notice] jk2_init() Found child 3675 in scoreboard slot 9
1150:[Mon Dec 05 04:07:48 2005] [notice] jk2_init() Found child 3674 in scoreboard slot 8
1151:[Mon Dec 05 04:08:37 2005] [notice] jk2_init() Found child 3678 in scoreboard slot 8
1152:[Mon Dec 05 04:08:37 2005] [notice] jk2_init() Found child 3681 in scoreboard slot 6
1153:[Mon Dec 05 04:08:37 2005] [notice] jk2_init() Found child 3679 in scoreboard slot 9
1154:[Mon Dec 05 04:08:37 2005] [notice] jk2_init() Found child 3680 in scoreboard slot 7
1155:[Mon Dec 05 04:08:57 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1156:[Mon Dec 05 04:09:32 2005] [notice] jk2_init() Found child 3685 in scoreboard slot 6
1157:[Mon Dec 05 04:10:47 2005] [notice] jk2_init() Found child 3698 in scoreboard slot 9
1158:[Mon Dec 05 04:10:47 2005] [notice] jk2_init() Found child 3690 in scoreboard slot 6
1159:[Mon Dec 05 04:10:47 2005] [notice] jk2_init() Found child 3691 in scoreboard slot 8
1160:[Mon Dec 05 04:13:54 2005] [notice] jk2_init() Found child 3744 in scoreboard slot 6
1161:[Mon Dec 05 04:13:54 2005] [notice] jk2_init() Found child 3747 in scoreboard slot 8
1162:[Mon Dec 05 04:13:54 2005] [notice] jk2_init() Found child 3754 in scoreboard slot 12
1163:[Mon Dec 05 04:13:54 2005] [notice] jk2_init() Found child 3755 in scoreboard slot 13
1164:[Mon Dec 05 04:13:54 2005] [notice] jk2_init() Found child 3753 in scoreboard slot 10
1165:[Mon Dec 05 04:13:54 2005] [notice] jk2_init() Found child 3752 in scoreboard slot 9
1166:[Mon Dec 05 04:13:54 2005] [notice] jk2_init() Found child 3746 in scoreboard slot 7
1167:[Mon Dec 05 04:14:00 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1168:[Mon Dec 05 04:14:00 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1170:[Mon Dec 05 04:14:00 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1172:[Mon Dec 05 04:14:00 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1174:[Mon Dec 05 04:14:00 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1176:[Mon Dec 05 04:14:00 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1178:[Mon Dec 05 04:14:00 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1181:[Mon Dec 05 05:06:42 2005] [notice] jk2_init() Found child 4596 in scoreboard slot 8
1182:[Mon Dec 05 05:06:42 2005] [notice] jk2_init() Found child 4595 in scoreboard slot 7
1183:[Mon Dec 05 05:06:42 2005] [notice] jk2_init() Found child 4594 in scoreboard slot 6
1184:[Mon Dec 05 05:06:47 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1185:[Mon Dec 05 05:06:47 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1186:[Mon Dec 05 05:06:47 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1190:[Mon Dec 05 05:11:04 2005] [notice] jk2_init() Found child 4609 in scoreboard slot 7
1191:[Mon Dec 05 05:11:04 2005] [notice] jk2_init() Found child 4608 in scoreboard slot 6
1192:[Mon Dec 05 05:11:34 2005] [notice] jk2_init() Found child 4611 in scoreboard slot 9
1193:[Mon Dec 05 05:11:54 2005] [notice] jk2_init() Found child 4613 in scoreboard slot 7
1194:[Mon Dec 05 05:11:54 2005] [notice] jk2_init() Found child 4612 in scoreboard slot 6
1195:[Mon Dec 05 05:12:32 2005] [notice] jk2_init() Found child 4615 in scoreboard slot 9
1196:[Mon Dec 05 05:12:56 2005] [notice] jk2_init() Found child 4616 in scoreboard slot 6
1197:[Mon Dec 05 05:12:56 2005] [notice] jk2_init() Found child 4617 in scoreboard slot 7
1198:[Mon Dec 05 05:12:56 2005] [notice] jk2_init() Found child 4618 in scoreboard slot 8
1199:[Mon Dec 05 05:15:29 2005] [notice] jk2_init() Found child 4634 in scoreboard slot 6
1200:[Mon Dec 05 05:15:29 2005] [notice] jk2_init() Found child 4637 in scoreboard slot 7
1201:[Mon Dec 05 05:15:29 2005] [notice] jk2_init() Found child 4631 in scoreboard slot 9
1202:[Mon Dec 05 05:15:29 2005] [notice] jk2_init() Found child 4630 in scoreboard slot 8
1203:[Mon Dec 05 05:15:33 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1205:[Mon Dec 05 05:15:33 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1207:[Mon Dec 05 05:15:33 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1209:[Mon Dec 05 05:15:33 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1211:[Mon Dec 05 06:35:27 2005] [notice] jk2_init() Found child 4820 in scoreboard slot 8
1212:[Mon Dec 05 06:35:27 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1214:[Mon Dec 05 06:36:58 2005] [notice] jk2_init() Found child 4821 in scoreboard slot 10
1215:[Mon Dec 05 06:36:58 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1218:[Mon Dec 05 07:16:00 2005] [notice] jk2_init() Found child 4893 in scoreboard slot 7
1219:[Mon Dec 05 07:16:00 2005] [notice] jk2_init() Found child 4892 in scoreboard slot 6
1220:[Mon Dec 05 07:16:03 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1222:[Mon Dec 05 07:16:03 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1224:[Mon Dec 05 07:21:03 2005] [notice] jk2_init() Found child 4907 in scoreboard slot 6
1225:[Mon Dec 05 07:21:02 2005] [notice] jk2_init() Found child 4906 in scoreboard slot 9
1226:[Mon Dec 05 07:21:02 2005] [notice] jk2_init() Found child 4905 in scoreboard slot 8
1227:[Mon Dec 05 07:21:09 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1228:[Mon Dec 05 07:21:09 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1231:[Mon Dec 05 07:21:09 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1233:[Mon Dec 05 07:25:55 2005] [notice] jk2_init() Found child 4916 in scoreboard slot 8
1234:[Mon Dec 05 07:25:55 2005] [notice] jk2_init() Found child 4917 in scoreboard slot 9
1235:[Mon Dec 05 07:25:55 2005] [notice] jk2_init() Found child 4915 in scoreboard slot 7
1236:[Mon Dec 05 07:25:59 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1237:[Mon Dec 05 07:25:59 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1238:[Mon Dec 05 07:25:59 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1242:[Mon Dec 05 07:31:22 2005] [notice] jk2_init() Found child 4932 in scoreboard slot 6
1243:[Mon Dec 05 07:32:03 2005] [notice] jk2_init() Found child 4938 in scoreboard slot 8
1244:[Mon Dec 05 07:32:03 2005] [notice] jk2_init() Found child 4935 in scoreboard slot 9
1245:[Mon Dec 05 07:32:03 2005] [notice] jk2_init() Found child 4936 in scoreboard slot 6
1246:[Mon Dec 05 07:32:03 2005] [notice] jk2_init() Found child 4937 in scoreboard slot 7
1247:[Mon Dec 05 07:32:06 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1249:[Mon Dec 05 07:32:06 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1251:[Mon Dec 05 07:32:06 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1253:[Mon Dec 05 07:32:06 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1255:[Mon Dec 05 07:36:19 2005] [notice] jk2_init() Found child 4950 in scoreboard slot 7
1256:[Mon Dec 05 07:37:47 2005] [notice] jk2_init() Found child 4961 in scoreboard slot 6
1257:[Mon Dec 05 07:37:48 2005] [notice] jk2_init() Found child 4962 in scoreboard slot 7
1258:[Mon Dec 05 07:37:48 2005] [notice] jk2_init() Found child 4960 in scoreboard slot 9
1259:[Mon Dec 05 07:37:48 2005] [notice] jk2_init() Found child 4959 in scoreboard slot 8
1260:[Mon Dec 05 07:37:58 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1261:[Mon Dec 05 07:37:58 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1262:[Mon Dec 05 07:37:58 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1263:[Mon Dec 05 07:37:58 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1268:[Mon Dec 05 07:41:07 2005] [notice] jk2_init() Found child 4974 in scoreboard slot 9
1269:[Mon Dec 05 07:41:35 2005] [notice] jk2_init() Found child 4975 in scoreboard slot 6
1270:[Mon Dec 05 07:41:50 2005] [notice] jk2_init() Found child 4977 in scoreboard slot 8
1271:[Mon Dec 05 07:41:50 2005] [notice] jk2_init() Found child 4976 in scoreboard slot 7
1272:[Mon Dec 05 07:43:07 2005] [notice] jk2_init() Found child 4984 in scoreboard slot 7
1273:[Mon Dec 05 07:43:08 2005] [notice] jk2_init() Found child 4985 in scoreboard slot 10
1274:[Mon Dec 05 07:43:07 2005] [notice] jk2_init() Found child 4983 in scoreboard slot 6
1275:[Mon Dec 05 07:43:15 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1277:[Mon Dec 05 07:43:15 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1279:[Mon Dec 05 07:43:15 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1281:[Mon Dec 05 07:43:19 2005] [notice] jk2_init() Found child 4986 in scoreboard slot 8
1282:[Mon Dec 05 07:43:19 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1284:[Mon Dec 05 07:46:01 2005] [notice] jk2_init() Found child 4991 in scoreboard slot 6
1285:[Mon Dec 05 07:46:01 2005] [notice] jk2_init() Found child 4992 in scoreboard slot 7
1286:[Mon Dec 05 07:46:46 2005] [notice] jk2_init() Found child 4996 in scoreboard slot 7
1287:[Mon Dec 05 07:46:46 2005] [notice] jk2_init() Found child 4995 in scoreboard slot 6
1288:[Mon Dec 05 07:47:13 2005] [notice] jk2_init() Found child 4998 in scoreboard slot 8
1289:[Mon Dec 05 07:47:13 2005] [notice] jk2_init() Found child 4999 in scoreboard slot 6
1290:[Mon Dec 05 07:47:21 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1291:[Mon Dec 05 07:47:21 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1292:[Mon Dec 05 07:47:21 2005] [notice] jk2_init() Found child 5000 in scoreboard slot 7
1294:[Mon Dec 05 07:47:21 2005] [notice] jk2_init() Found child 5001 in scoreboard slot 9
1296:[Mon Dec 05 07:47:36 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1297:[Mon Dec 05 07:47:36 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1300:[Mon Dec 05 07:48:04 2005] [notice] jk2_init() Found child 5002 in scoreboard slot 8
1301:[Mon Dec 05 07:48:04 2005] [notice] jk2_init() Found child 5003 in scoreboard slot 6
1302:[Mon Dec 05 07:48:46 2005] [notice] jk2_init() Found child 5005 in scoreboard slot 9
1303:[Mon Dec 05 07:48:46 2005] [notice] jk2_init() Found child 5006 in scoreboard slot 8
1304:[Mon Dec 05 07:48:55 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1305:[Mon Dec 05 07:48:55 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1308:[Mon Dec 05 07:48:56 2005] [notice] jk2_init() Found child 5007 in scoreboard slot 6
1309:[Mon Dec 05 07:48:56 2005] [notice] jk2_init() Found child 5008 in scoreboard slot 7
1310:[Mon Dec 05 07:48:56 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1312:[Mon Dec 05 07:48:56 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1314:[Mon Dec 05 07:50:54 2005] [notice] jk2_init() Found child 5017 in scoreboard slot 8
1315:[Mon Dec 05 07:50:54 2005] [notice] jk2_init() Found child 5016 in scoreboard slot 9
1316:[Mon Dec 05 07:51:22 2005] [notice] jk2_init() Found child 5018 in scoreboard slot 6
1317:[Mon Dec 05 07:51:20 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1319:[Mon Dec 05 07:51:39 2005] [notice] jk2_init() Found child 5020 in scoreboard slot 9
1320:[Mon Dec 05 07:51:39 2005] [notice] jk2_init() Found child 5019 in scoreboard slot 7
1321:[Mon Dec 05 07:51:56 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1322:[Mon Dec 05 07:51:56 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1325:[Mon Dec 05 07:52:29 2005] [notice] jk2_init() Found child 5021 in scoreboard slot 8
1326:[Mon Dec 05 07:52:29 2005] [notice] jk2_init() Found child 5022 in scoreboard slot 6
1327:[Mon Dec 05 07:52:56 2005] [notice] jk2_init() Found child 5024 in scoreboard slot 9
1328:[Mon Dec 05 07:52:56 2005] [notice] jk2_init() Found child 5023 in scoreboard slot 7
1329:[Mon Dec 05 07:52:55 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1331:[Mon Dec 05 07:53:24 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1332:[Mon Dec 05 07:54:01 2005] [notice] jk2_init() Found child 5029 in scoreboard slot 8
1333:[Mon Dec 05 07:54:02 2005] [notice] jk2_init() Found child 5030 in scoreboard slot 6
1334:[Mon Dec 05 07:54:48 2005] [notice] jk2_init() Found child 5033 in scoreboard slot 8
1335:[Mon Dec 05 07:54:48 2005] [notice] jk2_init() Found child 5032 in scoreboard slot 9
1336:[Mon Dec 05 07:55:00 2005] [notice] jk2_init() Found child 5035 in scoreboard slot 7
1337:[Mon Dec 05 07:55:00 2005] [notice] jk2_init() Found child 5034 in scoreboard slot 6
1338:[Mon Dec 05 07:55:07 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1340:[Mon Dec 05 07:55:07 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1342:[Mon Dec 05 07:55:07 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1344:[Mon Dec 05 07:55:13 2005] [notice] jk2_init() Found child 5036 in scoreboard slot 9
1345:[Mon Dec 05 07:57:01 2005] [notice] jk2_init() Found child 5050 in scoreboard slot 8
1346:[Mon Dec 05 07:57:01 2005] [notice] jk2_init() Found child 5049 in scoreboard slot 7
1347:[Mon Dec 05 07:57:01 2005] [notice] jk2_init() Found child 5048 in scoreboard slot 6
1348:[Mon Dec 05 07:57:02 2005] [notice] jk2_init() Found child 5051 in scoreboard slot 9
1351:[Mon Dec 05 07:57:02 2005] [notice] jk2_init() Found child 5052 in scoreboard slot 10
1352:[Mon Dec 05 07:57:02 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1354:[Mon Dec 05 07:57:02 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1356:[Mon Dec 05 07:57:02 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1358:[Mon Dec 05 07:57:02 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1360:[Mon Dec 05 07:57:02 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1362:[Mon Dec 05 07:57:02 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1364:[Mon Dec 05 07:57:02 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1367:[Mon Dec 05 09:36:13 2005] [notice] jk2_init() Found child 5271 in scoreboard slot 7
1368:[Mon Dec 05 09:36:13 2005] [notice] jk2_init() Found child 5270 in scoreboard slot 6
1369:[Mon Dec 05 09:36:14 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1371:[Mon Dec 05 09:36:14 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1373:[Mon Dec 05 09:55:21 2005] [notice] jk2_init() Found child 5295 in scoreboard slot 8
1374:[Mon Dec 05 09:55:21 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1376:[Mon Dec 05 10:10:32 2005] [notice] jk2_init() Found child 5330 in scoreboard slot 9
1377:[Mon Dec 05 10:10:33 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1379:[Mon Dec 05 10:16:20 2005] [notice] jk2_init() Found child 5344 in scoreboard slot 7
1380:[Mon Dec 05 10:16:52 2005] [notice] jk2_init() Found child 5347 in scoreboard slot 6
1381:[Mon Dec 05 10:16:53 2005] [notice] jk2_init() Found child 5348 in scoreboard slot 7
1382:[Mon Dec 05 10:17:45 2005] [notice] jk2_init() Found child 5350 in scoreboard slot 9
1383:[Mon Dec 05 10:17:45 2005] [notice] jk2_init() Found child 5349 in scoreboard slot 8
1384:[Mon Dec 05 10:17:49 2005] [notice] jk2_init() Found child 5352 in scoreboard slot 7
1385:[Mon Dec 05 10:17:50 2005] [notice] jk2_init() Found child 5351 in scoreboard slot 6
1386:[Mon Dec 05 10:17:51 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1387:[Mon Dec 05 10:17:51 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1388:[Mon Dec 05 10:17:51 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1389:[Mon Dec 05 10:17:51 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1394:[Mon Dec 05 10:21:05 2005] [notice] jk2_init() Found child 5366 in scoreboard slot 9
1395:[Mon Dec 05 10:21:05 2005] [notice] jk2_init() Found child 5365 in scoreboard slot 8
1396:[Mon Dec 05 10:21:05 2005] [notice] jk2_init() Found child 5367 in scoreboard slot 6
1397:[Mon Dec 05 10:21:07 2005] [notice] jk2_init() Found child 5368 in scoreboard slot 7
1398:[Mon Dec 05 10:21:13 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1399:[Mon Dec 05 10:21:13 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1400:[Mon Dec 05 10:21:13 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1401:[Mon Dec 05 10:21:13 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1406:[Mon Dec 05 10:26:26 2005] [notice] jk2_init() Found child 5384 in scoreboard slot 7
1407:[Mon Dec 05 10:26:26 2005] [notice] jk2_init() Found child 5385 in scoreboard slot 8
1408:[Mon Dec 05 10:26:25 2005] [notice] jk2_init() Found child 5386 in scoreboard slot 9
1409:[Mon Dec 05 10:26:25 2005] [notice] jk2_init() Found child 5387 in scoreboard slot 6
1410:[Mon Dec 05 10:26:31 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1412:[Mon Dec 05 10:26:31 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1414:[Mon Dec 05 10:26:31 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1416:[Mon Dec 05 10:26:31 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1418:[Mon Dec 05 10:26:36 2005] [notice] jk2_init() Found child 5388 in scoreboard slot 10
1419:[Mon Dec 05 10:26:36 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1423:[Mon Dec 05 10:31:40 2005] [notice] jk2_init() Found child 5404 in scoreboard slot 8
1424:[Mon Dec 05 10:31:40 2005] [notice] jk2_init() Found child 5405 in scoreboard slot 9
1425:[Mon Dec 05 10:33:41 2005] [notice] jk2_init() Found child 5418 in scoreboard slot 6
1426:[Mon Dec 05 10:33:41 2005] [notice] jk2_init() Found child 5419 in scoreboard slot 7
1427:[Mon Dec 05 10:33:41 2005] [notice] jk2_init() Found child 5417 in scoreboard slot 9
1428:[Mon Dec 05 10:33:41 2005] [notice] jk2_init() Found child 5416 in scoreboard slot 8
1429:[Mon Dec 05 10:33:44 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1431:[Mon Dec 05 10:33:44 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1433:[Mon Dec 05 10:33:44 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1435:[Mon Dec 05 10:33:44 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1437:[Mon Dec 05 10:36:10 2005] [notice] jk2_init() Found child 5426 in scoreboard slot 6
1438:[Mon Dec 05 10:36:10 2005] [notice] jk2_init() Found child 5425 in scoreboard slot 9
1439:[Mon Dec 05 10:36:58 2005] [notice] jk2_init() Found child 5428 in scoreboard slot 8
1440:[Mon Dec 05 10:37:27 2005] [notice] jk2_init() Found child 5429 in scoreboard slot 9
1441:[Mon Dec 05 10:37:27 2005] [notice] jk2_init() Found child 5430 in scoreboard slot 6
1442:[Mon Dec 05 10:38:00 2005] [notice] jk2_init() Found child 5434 in scoreboard slot 6
1443:[Mon Dec 05 10:38:00 2005] [notice] jk2_init() Found child 5433 in scoreboard slot 9
1444:[Mon Dec 05 10:38:00 2005] [notice] jk2_init() Found child 5435 in scoreboard slot 7
1445:[Mon Dec 05 10:38:00 2005] [notice] jk2_init() Found child 5432 in scoreboard slot 8
1446:[Mon Dec 05 10:38:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1448:[Mon Dec 05 10:38:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1450:[Mon Dec 05 10:38:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1452:[Mon Dec 05 10:38:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1454:[Mon Dec 05 10:41:14 2005] [notice] jk2_init() Found child 5470 in scoreboard slot 9
1455:[Mon Dec 05 10:41:14 2005] [notice] jk2_init() Found child 5469 in scoreboard slot 8
1456:[Mon Dec 05 10:42:23 2005] [notice] jk2_init() Found child 5474 in scoreboard slot 9
1457:[Mon Dec 05 10:42:23 2005] [notice] jk2_init() Found child 5475 in scoreboard slot 6
1458:[Mon Dec 05 10:43:19 2005] [notice] jk2_init() Found child 5482 in scoreboard slot 9
1459:[Mon Dec 05 10:43:19 2005] [notice] jk2_init() Found child 5480 in scoreboard slot 7
1460:[Mon Dec 05 10:43:19 2005] [notice] jk2_init() Found child 5479 in scoreboard slot 6
1461:[Mon Dec 05 10:43:19 2005] [notice] jk2_init() Found child 5481 in scoreboard slot 8
1462:[Mon Dec 05 10:43:34 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1463:[Mon Dec 05 10:43:34 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1465:[Mon Dec 05 10:43:41 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1467:[Mon Dec 05 10:43:48 2005] [notice] jk2_init() Found child 5484 in scoreboard slot 7
1468:[Mon Dec 05 10:43:48 2005] [notice] jk2_init() Found child 5483 in scoreboard slot 6
1469:[Mon Dec 05 10:43:51 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1471:[Mon Dec 05 10:43:51 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1473:[Mon Dec 05 10:46:55 2005] [notice] jk2_init() Found child 5497 in scoreboard slot 7
1474:[Mon Dec 05 10:46:55 2005] [notice] jk2_init() Found child 5495 in scoreboard slot 9
1475:[Mon Dec 05 10:46:55 2005] [notice] jk2_init() Found child 5494 in scoreboard slot 8
1476:[Mon Dec 05 10:46:55 2005] [notice] jk2_init() Found child 5496 in scoreboard slot 6
1477:[Mon Dec 05 10:47:12 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1478:[Mon Dec 05 10:47:12 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1481:[Mon Dec 05 10:47:32 2005] [notice] jk2_init() Found child 5499 in scoreboard slot 9
1482:[Mon Dec 05 10:47:33 2005] [notice] jk2_init() Found child 5498 in scoreboard slot 8
1483:[Mon Dec 05 10:47:44 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1484:[Mon Dec 05 10:47:44 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1487:[Mon Dec 05 10:47:47 2005] [notice] jk2_init() Found child 5500 in scoreboard slot 6
1488:[Mon Dec 05 10:47:47 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1490:[Mon Dec 05 10:48:43 2005] [notice] jk2_init() Found child 5503 in scoreboard slot 10
1491:[Mon Dec 05 10:48:46 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1494:[Mon Dec 05 10:51:12 2005] [notice] jk2_init() Found child 5515 in scoreboard slot 7
1495:[Mon Dec 05 10:51:12 2005] [notice] jk2_init() Found child 5516 in scoreboard slot 8
1496:[Mon Dec 05 10:51:33 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1497:[Mon Dec 05 10:51:33 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1500:[Mon Dec 05 10:51:59 2005] [notice] jk2_init() Found child 5517 in scoreboard slot 6
1501:[Mon Dec 05 10:52:00 2005] [notice] jk2_init() Found child 5518 in scoreboard slot 9
1502:[Mon Dec 05 10:52:15 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1503:[Mon Dec 05 10:52:15 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1505:[Mon Dec 05 10:53:42 2005] [notice] jk2_init() Found child 5527 in scoreboard slot 7
1506:[Mon Dec 05 10:53:42 2005] [notice] jk2_init() Found child 5526 in scoreboard slot 9
1507:[Mon Dec 05 10:55:47 2005] [notice] jk2_init() Found child 5538 in scoreboard slot 9
1508:[Mon Dec 05 10:59:25 2005] [notice] jk2_init() Found child 5565 in scoreboard slot 9
1509:[Mon Dec 05 10:59:25 2005] [notice] jk2_init() Found child 5563 in scoreboard slot 7
1510:[Mon Dec 05 10:59:25 2005] [notice] jk2_init() Found child 5562 in scoreboard slot 6
1511:[Mon Dec 05 10:59:25 2005] [notice] jk2_init() Found child 5564 in scoreboard slot 8
1512:[Mon Dec 05 10:59:25 2005] [notice] jk2_init() Found child 5567 in scoreboard slot 12
1513:[Mon Dec 05 10:59:25 2005] [notice] jk2_init() Found child 5568 in scoreboard slot 13
1514:[Mon Dec 05 10:59:25 2005] [notice] jk2_init() Found child 5566 in scoreboard slot 10
1515:[Mon Dec 05 10:59:29 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1516:[Mon Dec 05 10:59:29 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1517:[Mon Dec 05 10:59:29 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1518:[Mon Dec 05 10:59:29 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1519:[Mon Dec 05 10:59:29 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1520:[Mon Dec 05 10:59:29 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1521:[Mon Dec 05 10:59:29 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1529:[Mon Dec 05 11:02:05 2005] [notice] jk2_init() Found child 5579 in scoreboard slot 6
1530:[Mon Dec 05 11:04:16 2005] [notice] jk2_init() Found child 5592 in scoreboard slot 8
1531:[Mon Dec 05 11:04:16 2005] [notice] jk2_init() Found child 5593 in scoreboard slot 9
1532:[Mon Dec 05 11:06:50 2005] [notice] jk2_init() Found child 5616 in scoreboard slot 6
1533:[Mon Dec 05 11:06:51 2005] [notice] jk2_init() Found child 5617 in scoreboard slot 7
1534:[Mon Dec 05 11:06:51 2005] [notice] jk2_init() Found child 5618 in scoreboard slot 8
1535:[Mon Dec 05 11:06:51 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1537:[Mon Dec 05 11:06:51 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1539:[Mon Dec 05 11:06:51 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1542:[Mon Dec 05 11:06:52 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1545:[Mon Dec 05 11:06:52 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1548:[Mon Dec 05 11:06:52 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1551:[Mon Dec 05 11:06:52 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1553:[Mon Dec 05 12:35:57 2005] [notice] jk2_init() Found child 5785 in scoreboard slot 6
1554:[Mon Dec 05 12:35:57 2005] [notice] jk2_init() Found child 5786 in scoreboard slot 7
1555:[Mon Dec 05 12:36:36 2005] [notice] jk2_init() Found child 5790 in scoreboard slot 7
1556:[Mon Dec 05 12:36:36 2005] [notice] jk2_init() Found child 5788 in scoreboard slot 9
1557:[Mon Dec 05 12:36:36 2005] [notice] jk2_init() Found child 5789 in scoreboard slot 6
1558:[Mon Dec 05 12:36:36 2005] [notice] jk2_init() Found child 5787 in scoreboard slot 8
1559:[Mon Dec 05 12:36:39 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1561:[Mon Dec 05 12:36:39 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1563:[Mon Dec 05 12:36:39 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1565:[Mon Dec 05 12:36:39 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1567:[Mon Dec 05 12:40:37 2005] [notice] jk2_init() Found child 5798 in scoreboard slot 8
1568:[Mon Dec 05 12:40:38 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1570:[Mon Dec 05 12:50:42 2005] [notice] jk2_init() Found child 5811 in scoreboard slot 6
1571:[Mon Dec 05 12:50:42 2005] [notice] jk2_init() Found child 5810 in scoreboard slot 9
1572:[Mon Dec 05 12:50:43 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1573:[Mon Dec 05 12:50:43 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1576:[Mon Dec 05 12:55:48 2005] [notice] jk2_init() Found child 5817 in scoreboard slot 8
1577:[Mon Dec 05 12:55:48 2005] [notice] jk2_init() Found child 5816 in scoreboard slot 7
1578:[Mon Dec 05 12:55:49 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1580:[Mon Dec 05 12:55:49 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1582:[Mon Dec 05 13:00:33 2005] [notice] jk2_init() Found child 5825 in scoreboard slot 9
1583:[Mon Dec 05 13:00:33 2005] [notice] jk2_init() Found child 5826 in scoreboard slot 6
1584:[Mon Dec 05 13:00:34 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1586:[Mon Dec 05 13:00:34 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1588:[Mon Dec 05 13:05:24 2005] [notice] jk2_init() Found child 5845 in scoreboard slot 7
1589:[Mon Dec 05 13:05:24 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1591:[Mon Dec 05 13:10:55 2005] [notice] jk2_init() Found child 5856 in scoreboard slot 8
1592:[Mon Dec 05 13:10:59 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1594:[Mon Dec 05 13:16:27 2005] [notice] jk2_init() Found child 5877 in scoreboard slot 9
1595:[Mon Dec 05 13:16:27 2005] [notice] jk2_init() Found child 5876 in scoreboard slot 8
1596:[Mon Dec 05 13:16:27 2005] [notice] jk2_init() Found child 5878 in scoreboard slot 6
1597:[Mon Dec 05 13:16:27 2005] [notice] jk2_init() Found child 5875 in scoreboard slot 7
1598:[Mon Dec 05 13:16:29 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1600:[Mon Dec 05 13:16:29 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1602:[Mon Dec 05 13:16:29 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1604:[Mon Dec 05 13:16:29 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1606:[Mon Dec 05 13:21:35 2005] [notice] jk2_init() Found child 5893 in scoreboard slot 9
1607:[Mon Dec 05 13:21:34 2005] [notice] jk2_init() Found child 5892 in scoreboard slot 8
1608:[Mon Dec 05 13:22:45 2005] [notice] jk2_init() Found child 5901 in scoreboard slot 9
1609:[Mon Dec 05 13:22:45 2005] [notice] jk2_init() Found child 5899 in scoreboard slot 7
1610:[Mon Dec 05 13:22:45 2005] [notice] jk2_init() Found child 5900 in scoreboard slot 8
1611:[Mon Dec 05 13:22:45 2005] [notice] jk2_init() Found child 5898 in scoreboard slot 6
1612:[Mon Dec 05 13:22:48 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1614:[Mon Dec 05 13:22:48 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1616:[Mon Dec 05 13:22:48 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1618:[Mon Dec 05 13:22:48 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1620:[Mon Dec 05 13:26:03 2005] [notice] jk2_init() Found child 5912 in scoreboard slot 7
1621:[Mon Dec 05 13:26:37 2005] [notice] jk2_init() Found child 5914 in scoreboard slot 9
1622:[Mon Dec 05 13:26:37 2005] [notice] jk2_init() Found child 5915 in scoreboard slot 6
1623:[Mon Dec 05 13:27:15 2005] [notice] jk2_init() Found child 5917 in scoreboard slot 8
1624:[Mon Dec 05 13:27:14 2005] [notice] jk2_init() Found child 5916 in scoreboard slot 7
1625:[Mon Dec 05 13:27:15 2005] [notice] jk2_init() Found child 5919 in scoreboard slot 6
1626:[Mon Dec 05 13:27:15 2005] [notice] jk2_init() Found child 5918 in scoreboard slot 9
1627:[Mon Dec 05 13:28:14 2005] [notice] jk2_init() Found child 5925 in scoreboard slot 8
1628:[Mon Dec 05 13:28:14 2005] [notice] jk2_init() Found child 5923 in scoreboard slot 6
1629:[Mon Dec 05 13:28:14 2005] [notice] jk2_init() Found child 5924 in scoreboard slot 7
1630:[Mon Dec 05 13:28:14 2005] [notice] jk2_init() Found child 5922 in scoreboard slot 9
1631:[Mon Dec 05 13:28:17 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1633:[Mon Dec 05 13:28:17 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1635:[Mon Dec 05 13:28:17 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1637:[Mon Dec 05 13:28:17 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1639:[Mon Dec 05 13:31:19 2005] [notice] jk2_init() Found child 5935 in scoreboard slot 9
1640:[Mon Dec 05 13:31:19 2005] [notice] jk2_init() Found child 5936 in scoreboard slot 6
1641:[Mon Dec 05 13:31:53 2005] [notice] jk2_init() Found child 5938 in scoreboard slot 8
1642:[Mon Dec 05 13:31:53 2005] [notice] jk2_init() Found child 5937 in scoreboard slot 7
1643:[Mon Dec 05 13:32:01 2005] [notice] jk2_init() Found child 5940 in scoreboard slot 6
1644:[Mon Dec 05 13:32:01 2005] [notice] jk2_init() Found child 5939 in scoreboard slot 9
1645:[Mon Dec 05 13:32:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1646:[Mon Dec 05 13:32:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1649:[Mon Dec 05 13:32:09 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1650:[Mon Dec 05 13:32:09 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1653:[Mon Dec 05 13:32:28 2005] [notice] jk2_init() Found child 5942 in scoreboard slot 8
1654:[Mon Dec 05 13:32:28 2005] [notice] jk2_init() Found child 5941 in scoreboard slot 7
1655:[Mon Dec 05 13:32:30 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1656:[Mon Dec 05 13:32:30 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1659:[Mon Dec 05 13:36:27 2005] [notice] jk2_init() Found child 5954 in scoreboard slot 7
1660:[Mon Dec 05 13:36:27 2005] [notice] jk2_init() Found child 5953 in scoreboard slot 6
1661:[Mon Dec 05 13:36:58 2005] [notice] jk2_init() Found child 5956 in scoreboard slot 9
1662:[Mon Dec 05 13:36:58 2005] [notice] jk2_init() Found child 5957 in scoreboard slot 6
1663:[Mon Dec 05 13:36:58 2005] [notice] jk2_init() Found child 5955 in scoreboard slot 8
1664:[Mon Dec 05 13:37:47 2005] [notice] jk2_init() Found child 5961 in scoreboard slot 6
1665:[Mon Dec 05 13:37:47 2005] [notice] jk2_init() Found child 5960 in scoreboard slot 9
1666:[Mon Dec 05 13:38:52 2005] [notice] jk2_init() Found child 5968 in scoreboard slot 9
1667:[Mon Dec 05 13:38:53 2005] [notice] jk2_init() Found child 5965 in scoreboard slot 6
1668:[Mon Dec 05 13:38:52 2005] [notice] jk2_init() Found child 5967 in scoreboard slot 8
1669:[Mon Dec 05 13:38:53 2005] [notice] jk2_init() Found child 5969 in scoreboard slot 10
1670:[Mon Dec 05 13:38:52 2005] [notice] jk2_init() Found child 5966 in scoreboard slot 7
1671:[Mon Dec 05 13:39:09 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1672:[Mon Dec 05 13:39:09 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1675:[Mon Dec 05 13:39:36 2005] [notice] jk2_init() Found child 5970 in scoreboard slot 6
1676:[Mon Dec 05 13:39:36 2005] [notice] jk2_init() Found child 5971 in scoreboard slot 7
1677:[Mon Dec 05 13:39:41 2005] [notice] jk2_init() Found child 5972 in scoreboard slot 8
1678:[Mon Dec 05 13:39:41 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1679:[Mon Dec 05 13:39:41 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1680:[Mon Dec 05 13:39:41 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1684:[Mon Dec 05 13:41:11 2005] [notice] jk2_init() Found child 5981 in scoreboard slot 9
1685:[Mon Dec 05 13:41:12 2005] [notice] jk2_init() Found child 5982 in scoreboard slot 6
1686:[Mon Dec 05 13:41:58 2005] [notice] jk2_init() Found child 5984 in scoreboard slot 8
1687:[Mon Dec 05 13:41:58 2005] [notice] jk2_init() Found child 5985 in scoreboard slot 9
1688:[Mon Dec 05 13:43:27 2005] [notice] jk2_init() Found child 5992 in scoreboard slot 8
1689:[Mon Dec 05 13:43:27 2005] [notice] jk2_init() Found child 5993 in scoreboard slot 9
1690:[Mon Dec 05 13:43:27 2005] [notice] jk2_init() Found child 5990 in scoreboard slot 6
1691:[Mon Dec 05 13:43:27 2005] [notice] jk2_init() Found child 5991 in scoreboard slot 7
1692:[Mon Dec 05 13:43:43 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1693:[Mon Dec 05 13:43:44 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1694:[Mon Dec 05 13:43:43 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1698:[Mon Dec 05 13:44:18 2005] [notice] jk2_init() Found child 5995 in scoreboard slot 7
1699:[Mon Dec 05 13:44:18 2005] [notice] jk2_init() Found child 5996 in scoreboard slot 8
1700:[Mon Dec 05 13:44:32 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1701:[Mon Dec 05 13:44:35 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1704:[Mon Dec 05 13:44:53 2005] [notice] jk2_init() Found child 5997 in scoreboard slot 9
1705:[Mon Dec 05 13:45:01 2005] [notice] jk2_init() Found child 5998 in scoreboard slot 6
1706:[Mon Dec 05 13:45:01 2005] [notice] jk2_init() Found child 5999 in scoreboard slot 7
1707:[Mon Dec 05 13:45:08 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1708:[Mon Dec 05 13:45:08 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1709:[Mon Dec 05 13:45:08 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1713:[Mon Dec 05 13:46:20 2005] [notice] jk2_init() Found child 6007 in scoreboard slot 7
1714:[Mon Dec 05 13:46:20 2005] [notice] jk2_init() Found child 6006 in scoreboard slot 6
1715:[Mon Dec 05 13:46:20 2005] [notice] jk2_init() Found child 6005 in scoreboard slot 9
1716:[Mon Dec 05 13:46:50 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1717:[Mon Dec 05 13:47:06 2005] [notice] jk2_init() Found child 6008 in scoreboard slot 8
1718:[Mon Dec 05 13:47:06 2005] [notice] jk2_init() Found child 6009 in scoreboard slot 9
1719:[Mon Dec 05 13:47:09 2005] [notice] jk2_init() Found child 6011 in scoreboard slot 7
1720:[Mon Dec 05 13:47:09 2005] [notice] jk2_init() Found child 6010 in scoreboard slot 6
1721:[Mon Dec 05 13:47:11 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1722:[Mon Dec 05 13:47:11 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1723:[Mon Dec 05 13:47:11 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1724:[Mon Dec 05 13:47:11 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1729:[Mon Dec 05 13:51:17 2005] [notice] jk2_init() Found child 6028 in scoreboard slot 9
1730:[Mon Dec 05 13:52:19 2005] [notice] jk2_init() Found child 6036 in scoreboard slot 9
1731:[Mon Dec 05 13:52:19 2005] [notice] jk2_init() Found child 6033 in scoreboard slot 6
1732:[Mon Dec 05 13:52:19 2005] [notice] jk2_init() Found child 6035 in scoreboard slot 8
1733:[Mon Dec 05 13:52:19 2005] [notice] jk2_init() Found child 6034 in scoreboard slot 7
1734:[Mon Dec 05 13:52:33 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1735:[Mon Dec 05 13:52:33 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1738:[Mon Dec 05 13:53:00 2005] [notice] jk2_init() Found child 6038 in scoreboard slot 7
1739:[Mon Dec 05 13:53:00 2005] [notice] jk2_init() Found child 6037 in scoreboard slot 6
1740:[Mon Dec 05 13:53:00 2005] [notice] jk2_init() Found child 6039 in scoreboard slot 10
1741:[Mon Dec 05 13:53:31 2005] [notice] jk2_init() Found child 6043 in scoreboard slot 9
1742:[Mon Dec 05 13:53:31 2005] [notice] jk2_init() Found child 6042 in scoreboard slot 7
1743:[Mon Dec 05 13:53:31 2005] [notice] jk2_init() Found child 6041 in scoreboard slot 6
1744:[Mon Dec 05 13:53:34 2005] [notice] jk2_init() Found child 6044 in scoreboard slot 8
1745:[Mon Dec 05 13:53:35 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1746:[Mon Dec 05 13:53:35 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1747:[Mon Dec 05 13:53:35 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1748:[Mon Dec 05 13:53:35 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1753:[Mon Dec 05 13:56:21 2005] [notice] jk2_init() Found child 6052 in scoreboard slot 6
1754:[Mon Dec 05 13:56:38 2005] [notice] jk2_init() Found child 6053 in scoreboard slot 7
1755:[Mon Dec 05 13:57:07 2005] [notice] jk2_init() Found child 6054 in scoreboard slot 9
1756:[Mon Dec 05 13:57:07 2005] [notice] jk2_init() Found child 6055 in scoreboard slot 8
1757:[Mon Dec 05 13:58:31 2005] [notice] jk2_init() Found child 6063 in scoreboard slot 8
1758:[Mon Dec 05 13:58:31 2005] [notice] jk2_init() Found child 6062 in scoreboard slot 9
1759:[Mon Dec 05 13:59:43 2005] [notice] jk2_init() Found child 6069 in scoreboard slot 7
1760:[Mon Dec 05 13:59:43 2005] [notice] jk2_init() Found child 6070 in scoreboard slot 9
1761:[Mon Dec 05 13:59:43 2005] [notice] jk2_init() Found child 6071 in scoreboard slot 8
1762:[Mon Dec 05 14:01:47 2005] [notice] jk2_init() Found child 6100 in scoreboard slot 7
1763:[Mon Dec 05 14:01:47 2005] [notice] jk2_init() Found child 6101 in scoreboard slot 8
1764:[Mon Dec 05 14:01:47 2005] [notice] jk2_init() Found child 6099 in scoreboard slot 6
1765:[Mon Dec 05 14:01:48 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1767:[Mon Dec 05 14:01:48 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1769:[Mon Dec 05 14:01:48 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1771:[Mon Dec 05 14:11:40 2005] [notice] jk2_init() Found child 6115 in scoreboard slot 10
1773:[Mon Dec 05 14:11:45 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1775:[Mon Dec 05 15:31:06 2005] [notice] jk2_init() Found child 6259 in scoreboard slot 6
1776:[Mon Dec 05 15:31:06 2005] [notice] jk2_init() Found child 6260 in scoreboard slot 7
1777:[Mon Dec 05 15:31:09 2005] [notice] jk2_init() Found child 6261 in scoreboard slot 8
1778:[Mon Dec 05 15:31:10 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1780:[Mon Dec 05 15:31:10 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1782:[Mon Dec 05 15:31:10 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1784:[Mon Dec 05 15:40:59 2005] [notice] jk2_init() Found child 6277 in scoreboard slot 7
1785:[Mon Dec 05 15:40:59 2005] [notice] jk2_init() Found child 6276 in scoreboard slot 6
1786:[Mon Dec 05 15:41:32 2005] [notice] jk2_init() Found child 6280 in scoreboard slot 7
1787:[Mon Dec 05 15:41:32 2005] [notice] jk2_init() Found child 6278 in scoreboard slot 8
1788:[Mon Dec 05 15:41:32 2005] [notice] jk2_init() Found child 6279 in scoreboard slot 6
1789:[Mon Dec 05 15:41:32 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1791:[Mon Dec 05 15:41:32 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1793:[Mon Dec 05 15:41:32 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1795:[Mon Dec 05 15:45:42 2005] [notice] jk2_init() Found child 6285 in scoreboard slot 8
1796:[Mon Dec 05 15:45:44 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1798:[Mon Dec 05 15:50:53 2005] [notice] jk2_init() Found child 6293 in scoreboard slot 6
1799:[Mon Dec 05 15:50:53 2005] [notice] jk2_init() Found child 6294 in scoreboard slot 7
1800:[Mon Dec 05 15:51:18 2005] [notice] jk2_init() Found child 6297 in scoreboard slot 7
1801:[Mon Dec 05 15:51:18 2005] [notice] jk2_init() Found child 6295 in scoreboard slot 8
1802:[Mon Dec 05 15:51:18 2005] [notice] jk2_init() Found child 6296 in scoreboard slot 6
1803:[Mon Dec 05 15:51:20 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1805:[Mon Dec 05 15:51:20 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1807:[Mon Dec 05 15:51:20 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1809:[Mon Dec 05 15:55:31 2005] [notice] jk2_init() Found child 6302 in scoreboard slot 8
1810:[Mon Dec 05 15:55:32 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1812:[Mon Dec 05 16:01:17 2005] [notice] jk2_init() Found child 6310 in scoreboard slot 6
1813:[Mon Dec 05 16:02:00 2005] [notice] jk2_init() Found child 6315 in scoreboard slot 6
1814:[Mon Dec 05 16:02:00 2005] [notice] jk2_init() Found child 6316 in scoreboard slot 7
1815:[Mon Dec 05 16:02:00 2005] [notice] jk2_init() Found child 6314 in scoreboard slot 8
1816:[Mon Dec 05 16:02:02 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1817:[Mon Dec 05 16:02:02 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1818:[Mon Dec 05 16:02:02 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1822:[Mon Dec 05 16:06:07 2005] [notice] jk2_init() Found child 6333 in scoreboard slot 8
1823:[Mon Dec 05 16:06:21 2005] [notice] jk2_init() Found child 6335 in scoreboard slot 7
1824:[Mon Dec 05 16:07:08 2005] [notice] jk2_init() Found child 6339 in scoreboard slot 8
1825:[Mon Dec 05 16:07:08 2005] [notice] jk2_init() Found child 6340 in scoreboard slot 6
1826:[Mon Dec 05 16:07:08 2005] [notice] jk2_init() Found child 6338 in scoreboard slot 7
1827:[Mon Dec 05 16:07:09 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1829:[Mon Dec 05 16:07:09 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1831:[Mon Dec 05 16:07:09 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1833:[Mon Dec 05 16:10:43 2005] [notice] jk2_init() Found child 6351 in scoreboard slot 8
1834:[Mon Dec 05 16:10:43 2005] [notice] jk2_init() Found child 6350 in scoreboard slot 7
1835:[Mon Dec 05 16:10:44 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1837:[Mon Dec 05 16:10:44 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1839:[Mon Dec 05 16:16:34 2005] [notice] jk2_init() Found child 6368 in scoreboard slot 8
1840:[Mon Dec 05 16:16:34 2005] [notice] jk2_init() Found child 6367 in scoreboard slot 7
1841:[Mon Dec 05 16:16:34 2005] [notice] jk2_init() Found child 6366 in scoreboard slot 6
1842:[Mon Dec 05 16:16:36 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1844:[Mon Dec 05 16:16:36 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1846:[Mon Dec 05 16:16:36 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1848:[Mon Dec 05 16:21:25 2005] [notice] jk2_init() Found child 6387 in scoreboard slot 7
1849:[Mon Dec 05 16:21:25 2005] [notice] jk2_init() Found child 6386 in scoreboard slot 6
1850:[Mon Dec 05 16:21:25 2005] [notice] jk2_init() Found child 6385 in scoreboard slot 8
1851:[Mon Dec 05 16:21:29 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1853:[Mon Dec 05 16:21:29 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1855:[Mon Dec 05 16:21:29 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1857:[Mon Dec 05 16:26:00 2005] [notice] jk2_init() Found child 6400 in scoreboard slot 7
1858:[Mon Dec 05 16:26:00 2005] [notice] jk2_init() Found child 6399 in scoreboard slot 6
1859:[Mon Dec 05 16:26:00 2005] [notice] jk2_init() Found child 6398 in scoreboard slot 8
1860:[Mon Dec 05 16:26:05 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1862:[Mon Dec 05 16:26:05 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1864:[Mon Dec 05 16:26:05 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1866:[Mon Dec 05 16:31:48 2005] [notice] jk2_init() Found child 6420 in scoreboard slot 6
1867:[Mon Dec 05 16:31:49 2005] [notice] jk2_init() Found child 6421 in scoreboard slot 7
1868:[Mon Dec 05 16:31:49 2005] [notice] jk2_init() Found child 6422 in scoreboard slot 8
1869:[Mon Dec 05 16:31:52 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1870:[Mon Dec 05 16:31:52 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1871:[Mon Dec 05 16:31:52 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1875:[Mon Dec 05 16:36:06 2005] [notice] jk2_init() Found child 6434 in scoreboard slot 7
1876:[Mon Dec 05 16:36:06 2005] [notice] jk2_init() Found child 6433 in scoreboard slot 6
1877:[Mon Dec 05 16:36:42 2005] [notice] jk2_init() Found child 6435 in scoreboard slot 8
1878:[Mon Dec 05 16:37:03 2005] [notice] jk2_init() Found child 6437 in scoreboard slot 7
1879:[Mon Dec 05 16:38:17 2005] [notice] jk2_init() Found child 6443 in scoreboard slot 7
1880:[Mon Dec 05 16:38:17 2005] [notice] jk2_init() Found child 6442 in scoreboard slot 6
1881:[Mon Dec 05 16:39:59 2005] [notice] jk2_init() Found child 6453 in scoreboard slot 10
1882:[Mon Dec 05 16:39:59 2005] [notice] jk2_init() Found child 6451 in scoreboard slot 7
1883:[Mon Dec 05 16:39:59 2005] [notice] jk2_init() Found child 6452 in scoreboard slot 8
1884:[Mon Dec 05 16:40:06 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1885:[Mon Dec 05 16:40:06 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1886:[Mon Dec 05 16:40:06 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1891:[Mon Dec 05 17:31:37 2005] [notice] jk2_init() Found child 6561 in scoreboard slot 10
1893:[Mon Dec 05 17:31:41 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1895:[Mon Dec 05 17:35:57 2005] [notice] jk2_init() Found child 6569 in scoreboard slot 8
1896:[Mon Dec 05 17:35:57 2005] [notice] jk2_init() Found child 6568 in scoreboard slot 7
1897:[Mon Dec 05 17:35:58 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1899:[Mon Dec 05 17:35:58 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1901:[Mon Dec 05 17:40:38 2005] [notice] jk2_init() Found child 6577 in scoreboard slot 7
1902:[Mon Dec 05 17:40:38 2005] [notice] jk2_init() Found child 6578 in scoreboard slot 8
1903:[Mon Dec 05 17:40:39 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1905:[Mon Dec 05 17:40:39 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1907:[Mon Dec 05 17:46:02 2005] [notice] jk2_init() Found child 6585 in scoreboard slot 7
1908:[Mon Dec 05 17:46:02 2005] [notice] jk2_init() Found child 6586 in scoreboard slot 8
1909:[Mon Dec 05 17:46:06 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1910:[Mon Dec 05 17:46:06 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1913:[Mon Dec 05 17:50:40 2005] [notice] jk2_init() Found child 6595 in scoreboard slot 8
1914:[Mon Dec 05 17:50:40 2005] [notice] jk2_init() Found child 6594 in scoreboard slot 7
1915:[Mon Dec 05 17:50:41 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1917:[Mon Dec 05 17:50:41 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1919:[Mon Dec 05 17:55:35 2005] [notice] jk2_init() Found child 6601 in scoreboard slot 8
1920:[Mon Dec 05 17:55:35 2005] [notice] jk2_init() Found child 6600 in scoreboard slot 7
1921:[Mon Dec 05 17:55:35 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1922:[Mon Dec 05 17:55:35 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1925:[Mon Dec 05 18:00:24 2005] [notice] jk2_init() Found child 6609 in scoreboard slot 7
1926:[Mon Dec 05 18:00:26 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1928:[Mon Dec 05 18:10:56 2005] [notice] jk2_init() Found child 6639 in scoreboard slot 7
1929:[Mon Dec 05 18:10:56 2005] [notice] jk2_init() Found child 6638 in scoreboard slot 8
1930:[Mon Dec 05 18:10:58 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1932:[Mon Dec 05 18:10:58 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1934:[Mon Dec 05 18:15:45 2005] [notice] jk2_init() Found child 6652 in scoreboard slot 7
1935:[Mon Dec 05 18:15:45 2005] [notice] jk2_init() Found child 6651 in scoreboard slot 8
1936:[Mon Dec 05 18:15:47 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1937:[Mon Dec 05 18:15:47 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1940:[Mon Dec 05 18:20:51 2005] [notice] jk2_init() Found child 6670 in scoreboard slot 7
1941:[Mon Dec 05 18:20:51 2005] [notice] jk2_init() Found child 6669 in scoreboard slot 8
1942:[Mon Dec 05 18:20:53 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1944:[Mon Dec 05 18:20:53 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1946:[Mon Dec 05 18:26:06 2005] [notice] jk2_init() Found child 6684 in scoreboard slot 7
1947:[Mon Dec 05 18:27:29 2005] [notice] jk2_init() Found child 6688 in scoreboard slot 8
1948:[Mon Dec 05 18:27:33 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1950:[Mon Dec 05 18:27:37 2005] [notice] jk2_init() Found child 6689 in scoreboard slot 7
1951:[Mon Dec 05 18:27:37 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1953:[Mon Dec 05 18:35:51 2005] [notice] jk2_init() Found child 6707 in scoreboard slot 8
1954:[Mon Dec 05 18:35:51 2005] [notice] jk2_init() Found child 6708 in scoreboard slot 7
1955:[Mon Dec 05 18:35:53 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1957:[Mon Dec 05 18:35:53 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1959:[Mon Dec 05 18:40:54 2005] [notice] jk2_init() Found child 6719 in scoreboard slot 7
1960:[Mon Dec 05 18:40:54 2005] [notice] jk2_init() Found child 6718 in scoreboard slot 8
1961:[Mon Dec 05 18:40:54 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1963:[Mon Dec 05 18:40:54 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1965:[Mon Dec 05 18:45:51 2005] [notice] jk2_init() Found child 6725 in scoreboard slot 7
1966:[Mon Dec 05 18:45:51 2005] [notice] jk2_init() Found child 6724 in scoreboard slot 8
1967:[Mon Dec 05 18:45:53 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1969:[Mon Dec 05 18:45:53 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1971:[Mon Dec 05 18:50:30 2005] [notice] jk2_init() Found child 6733 in scoreboard slot 8
1972:[Mon Dec 05 18:50:31 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1974:[Mon Dec 05 18:56:03 2005] [notice] jk2_init() Found child 6740 in scoreboard slot 7
1975:[Mon Dec 05 18:56:03 2005] [notice] jk2_init() Found child 6741 in scoreboard slot 8
1976:[Mon Dec 05 18:56:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1978:[Mon Dec 05 18:56:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1980:[Mon Dec 05 19:00:43 2005] [notice] jk2_init() Found child 6750 in scoreboard slot 8
1981:[Mon Dec 05 19:00:43 2005] [notice] jk2_init() Found child 6749 in scoreboard slot 7
1982:[Mon Dec 05 19:00:44 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1983:[Mon Dec 05 19:00:44 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1986:[Mon Dec 05 19:00:54 2005] [notice] jk2_init() Found child 6751 in scoreboard slot 10
1987:[Mon Dec 05 19:00:54 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1990:[Mon Dec 05 19:11:00 2005] [notice] jk2_init() Found child 6780 in scoreboard slot 7
1991:[Mon Dec 05 19:11:04 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1993:[Mon Dec 05 19:14:08 2005] [notice] jk2_init() Found child 6784 in scoreboard slot 8
1995:[Mon Dec 05 19:14:11 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
1997:[Mon Dec 05 19:15:55 2005] [notice] jk2_init() Found child 6791 in scoreboard slot 8
1998:[Mon Dec 05 19:15:55 2005] [notice] jk2_init() Found child 6790 in scoreboard slot 7
1999:[Mon Dec 05 19:15:57 2005] [notice] workerEnv.init() ok /etc/httpd/conf/workers2.properties
ubuntu@ip-172-31-27-220:~$

***what i learned***
i learned using grep command
sort and finding uniq using grep
finding specific words in script
