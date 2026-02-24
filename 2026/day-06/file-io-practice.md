# Creating and Updating file with linux commands

---

touch notes.txt


echo "I’m a passionate learner with a strong interest in Linux, DevOps, and Cloud technologies." > notes.txt
echo "I enjoy working hands-on with tools and solving real-world technical problems." >> notes.txt


echo "Currently focused on DevOps practices, Git & GitHub, cloud, and system administration." | tee -a notes.txt


echo "I believe in learning by doing and staying consistent every day." >> notes.txt
echo "My goal is to grow into a skilled DevOps professional." >> notes.txt
echo "I want to build, automate, and manage reliable systems." >> notes.txt
echo "Linux commands and cloud tools are my daily practice." >> notes.txt
echo "Step by step improvement is my learning strategy." >> notes.txt


cat notes.txt

head -n 2 notes.txt

tail -n 2 notes.txt
