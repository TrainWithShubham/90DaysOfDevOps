**Day 12 – Breather & Revision (Days 01–11)**

**Day 1:**  
After revisiting Day 01, I feel my learning plan is still aligned with my goals. The step-by-step approach and hands-on practice from Days 1–11 have helped me build a strong foundation, so I don’t see a need to tweak my plan at this stage.

**Day 4 \- 5:**  
I checked the status of the nginx and docker services using systemctl status and reviewed their logs using journalctl. Both services were active, running, and enabled, and the logs did not show any errors.

**Day 6 \- 11:**  
I have practiced all the mentioned file operations and have used them in my earlier work experience as well. I am comfortable with commands like `chmod`, `chown`, and `ls -l`. However, my learning focus now is on understanding **when to assign full permissions versus limited permissions**, especially while setting up a new server. I usually know what permission to fix when an error occurs, but I want to be more deliberate and secure by default.

**Cheat Sheet Refresh (Day 03):**  
During revision, I refreshed my Day 03 Linux cheat sheet and identified the commands I would immediately use during an incident. These commands give quick visibility into service health, logs, and running processes, helping me diagnose issues faster.

### **Top 5 Commands I’d Reach for First**

1. **systemctl status \<service\>**  
    To quickly check whether a service is running, failed, or inactive and see recent errors.  
2. **journalctl \-u \<service\>**  
    To analyze service logs and understand why a service failed or behaved unexpectedly.  
3. **ps \-ef | grep \<service\>**  
    To confirm whether the process is actually running and identify the PID.

4. **systemctl is-enabled \<service\>**  
    To verify whether the service is configured to start automatically after reboot.

5. **ls \-l**  
    To quickly check file permissions and ownership when troubleshooting access or execution issues.

---

### **Key Takeaway**

These commands together help me **assess service health, trace failures using logs, and verify permissions**, which are the first steps I take during real production incidents.

**User / Group Sanity Check (Days 09 & 11\)**  
I created new users and groups, assigned users to groups, and then created files and directories with specific owners and groups. I tested access using a user who was not the owner but was part of the assigned group, and the user was able to access the files based on group permissions. I also verified that a user who was neither the owner nor part of the group, and had no permissions assigned under others, was unable to access the files.

### **Which 3 commands save me the most time right now, and why?**

1. **systemctl status \<service\>**  
    This gives an immediate view of whether a service is running, failed, or inactive, along with recent error messages.  
2. **journalctl \-u \<service\>**  
    This helps me quickly analyze service logs to understand the root cause of failures or unexpected behavior.  
3. **ls \-l**  
    This allows me to instantly verify file permissions and ownership when dealing with access or execution issues.

