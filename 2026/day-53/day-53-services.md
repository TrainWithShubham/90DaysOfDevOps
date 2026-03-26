Task 1: Deploy the Application
- create a Deployment that you will expose with Services. Create app-deployment.yml
  <img width="1726" height="762" alt="image" src="https://github.com/user-attachments/assets/25e3f2e5-1244-47b3-b17b-e46d37aee62f" />

Task 2: ClusterIP Service (Internal Access)
- Create clusterip-service.yaml, Apply the changes and check the services
  <img width="1308" height="216" alt="image" src="https://github.com/user-attachments/assets/e6de92a3-d7b2-46ee-877e-04df17c36df2" />

-  Test it from inside the cluster: Run a temporary pod to test connectivity
   <img width="1881" height="695" alt="image" src="https://github.com/user-attachments/assets/67c8c27b-17a9-4ae2-b88c-6db951110eee" />

Task 3: Discover Services with DNS
- Create Test Pod adn test service access (Inside Pod) using short name
  <img width="1903" height="643" alt="image" src="https://github.com/user-attachments/assets/92b4bb69-9df0-41bd-855c-63b1e5c0e76e" />

  
- Test Service Access (Inside Pod) Using full DNS name and do ns Lookup
  <img width="1082" height="712" alt="image" src="https://github.com/user-attachments/assets/acbf63d8-c8a1-412b-a4a2-e605efabcb44" />


Task 4: NodePort Service (External Access via Node)
- Create nodeport-service.yaml. Apply changes and get services. Then access the service via port forwarding.
  <img width="1908" height="693" alt="53t4" src="https://github.com/user-attachments/assets/e4fe8ec3-54cc-482b-b222-85a6410996b9" />

  <img width="1391" height="408" alt="image" src="https://github.com/user-attachments/assets/2fa6b5e4-8080-44d6-8d55-b080f83a956b" />
  

Task 5: LoadBalancer Service (Cloud External Access)
- Create loadbalancer-service.yaml. Apply changes and get services. Then access service via port forwarding
  <img width="1550" height="300" alt="image" src="https://github.com/user-attachments/assets/688c4c09-f306-4266-9999-cb2c7b5cafa2" />

  <img width="1381" height="466" alt="52t5output" src="https://github.com/user-attachments/assets/1680eca6-50ac-4bd7-a426-56fcf426a1b6" />


Task 6: Understand the Service Types Side by Side
- Check all three services
  <img width="1286" height="136" alt="image" src="https://github.com/user-attachments/assets/e8095a4a-6b09-4b8c-a0e5-4d3f7c9db0a7" />

  <img width="1381" height="443" alt="image" src="https://github.com/user-attachments/assets/60e1fd2c-2005-447c-95a7-44636075cc86" />

Task 7: Clean Up
  <img width="1307" height="470" alt="image" src="https://github.com/user-attachments/assets/36594085-27ea-4b69-b0c1-86a9bcadc4ee" />




  
