# Day 12 – Breather & Revision (Days 01–11)

---

1. **Which 3 commands save you the most time right now, and why?**

- ls -l – quick permission & ownership check

- systemctl status – instant service health

-

2. **How do you check if a service is healthy?**

systemctl status <service>
ps -ef | grep <service>
journalctl -u <service>


3. **How do you safely change ownership and permissions without breaking access?**

sudo chown user:group file
chmod 640 file
ls -l file

4. **What will you focus on improving in the next 3 days?**

- Faster permission calculation (chmod numbers)

- Better log reading with journalctl

- More real-world troubleshooting practice


