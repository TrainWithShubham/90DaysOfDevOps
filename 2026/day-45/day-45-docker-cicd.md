Task 1: Prepare
- Use the app you Dockerized on Day 36 (or any simple Dockerfile)
- Add the Dockerfile to your github-actions-practice repo (or create a minimal one)
- Make sure DOCKER_USERNAME and DOCKER_TOKEN secrets are set from Day 44
  Added both dockerfile and Dockerized app and also verify secerets are on point.
  
  <img width="407" height="233" alt="image" src="https://github.com/user-attachments/assets/a607f6ae-f399-44d4-b984-0cadfb4c6cd1" />

Task 2: Build the Docker Image in CI
Create .github/workflows/docker-publish.yml that:
- Triggers on push to main
- Checks out the code
- Builds the Docker image and tags it
  <img width="773" height="372" alt="image" src="https://github.com/user-attachments/assets/9ae1f5f5-335d-41b7-9f7a-31a34a5fdc9d" />

Verify: Check the build step logs — does the image build successfully?
<img width="793" height="625" alt="image" src="https://github.com/user-attachments/assets/f0a3db51-19ce-441f-9f72-1b3f82bd7021" />


Task 3: Push to Docker Hub
Add steps to:
- Log in to Docker Hub using your secrets
- Tag the image as username/repo:latest and also username/repo:sha-<short-commit-hash>
  <img width="932" height="687" alt="image" src="https://github.com/user-attachments/assets/a550c7b0-fbb5-41f3-9945-22a5803006ab" />
  

- Push both tags
  <img width="885" height="805" alt="image" src="https://github.com/user-attachments/assets/368c2c47-0a22-45ca-bf3c-22bdda296c5e" />

  
- Verify: Go to Docker Hub — is your image there with both tags?
  <img width="857" height="337" alt="image" src="https://github.com/user-attachments/assets/466bc522-2bf0-47a2-b302-c3b32b279e9d" />


Task 4: Only Push on Main
- Add a condition so the push step only runs on the main branch — not on feature branches or PRs.
- Test it: push to a feature branch and verify the image is built but NOT pushed.
  <img width="907" height="745" alt="image" src="https://github.com/user-attachments/assets/fa0bc2e1-c9a4-4044-838a-d7c0f57fcaca" />

  Docker Hub Repo
  <img width="858" height="250" alt="image" src="https://github.com/user-attachments/assets/1a3d834e-b11c-4d1f-a5cb-d1eb435c004f" />

Task 5: Add a Status Badge
- Get the badge URL for your docker-publish workflow from the Actions tab
- Add it to your README.md
- Push — the badge should show green
  
  <img width="321" height="208" alt="image" src="https://github.com/user-attachments/assets/0f316e9d-40d6-41de-8e09-cfe6918dc77d" />




