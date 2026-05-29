# Week 4: Git and GitHub Challenge

Welcome to the Week 4 Challenge! In this task you will practice the essential Git and GitHub commands and concepts taught by Shubham Bhaiya. This includes:

- **Git Basics:** `git init`, `git add`, `git commit`
- **Repository Management:** `git clone`, forking a repository, and understanding how a GitHub repo is made
- **Branching:** Creating branches (`git branch`), switching between branches (`git switch` / `git checkout`), and viewing commit history (`git log`)
- **Authentication:** Pushing and pulling using a Personal Access Token (PAT)
- **Critical Thinking:** Explaining why branching strategies are important in collaborative development

To make this challenge more difficult, additional steps have been added. You will also be required to explore SSH authentication as a bonus task. Complete all the tasks and document every step in `solution.md`. Finally, share your experience on LinkedIn (details provided at the end).

---

## Challenge Tasks

### Task 1: Fork and Clone the Repository
1. **Fork the Repository:**  
   - Visit [this repository](https://github.com/LondheShubham153/90DaysOfDevOps) and fork it to your own GitHub account. If not done yet.
  
2. **Clone Your Fork Locally:**  
   - Clone the forked repository using HTTPS:
     ```bash
     git clone <your-fork-url>
     ```
   - Change directory into the cloned repository:
     ```bash
     cd 2025/git/01_Git_and_Github_Basics
     ```

---

### Task 2: Initialize a Local Repository and Create a File
1. **Set Up Your Challenge Directory:**  
   - Inside the cloned repository, create a new directory for this challenge:
     ```bash
     mkdir week-4-challenge
     cd week-4-challenge
     ```

2. **Initialize a Git Repository:**  
   - Initialize the directory as a new Git repository:
     ```bash
     git init
     ```

3. **Create a File:**  
   - Create a file named `info.txt` and add some initial content (for example, your name and a brief introduction).

4. **Stage and Commit Your File:**  
   - Stage the file:
     ```bash
     git add info.txt
     ```
   - Commit the file with a descriptive message:
     ```bash
     git commit -m "Initial commit: Add info.txt with introductory content"
     ```

---

## Task 3: Configure Remote URL with PAT and Push/Pull

1. **Configure Remote URL with Your PAT:**  
   To avoid entering your Personal Access Token (PAT) every time you push or pull, update your remote URL to include your credentials.  

   **⚠️ Note:** Embedding your PAT in the URL is only for this exercise. It is not recommended for production use.  
   
   Replace `<your-username>`, `<your-PAT>`, and `<repository-name>` with your actual GitHub username, your PAT, and the repository name respectively:
   
   ```bash
   git remote add origin https://<your-username>:<your-PAT>@github.com/<your-username>/90DaysOfDevOps.git
   ```
   If a remote named `origin` already exists, update it with:
   ```bash
   git remote set-url origin https://<your-username>:<your-PAT>@github.com/<your-username>/90DaysOfDevOps.git
   ```
2. **Push Your Commit to Remote:**  
   - Push your current branch (typically `main`) and set the upstream:
     ```bash
     git push -u origin main
     ```
3. **(Optional) Pull Remote Changes:**  
   - Verify your configuration by pulling changes:
     ```bash
     git pull origin main
     ```

---

### Task 4: Explore Your Commit History
1. **View the Git Log:**  
   - Check your commit history using:
     ```bash
     git log
     ```
   - Take note of the commit hash and details as you will reference these in your documentation.

---

### Task 5: Advanced Branching and Switching
1. **Create a New Branch:**  
   - Create a branch called `feature-update`:
     ```bash
     git branch feature-update
     ```
  
2. **Switch to the New Branch:**  
   - Switch using `git switch`:
     ```bash
     git switch feature-update
     ```
   - Alternatively, you can use:
     ```bash
     git checkout feature-update
     ```

3. **Modify the File and Commit Changes:**  
   - Edit `info.txt` (for example, add more details or improvements).
   - Stage and commit your changes:
     ```bash
     git add info.txt
     git commit -m "Feature update: Enhance info.txt with additional details"
     git push origin feature-update
     ```
   - Merge this branch to `main` via a Pull Request on GitHub.
   
4. **(Advanced) Optional Extra Challenge:**  
   - If you feel confident, create another branch (e.g., `experimental`) from your main branch, make a conflicting change to `info.txt`, then switch back to `feature-update` and merge `experimental` to simulate a merge conflict. Resolve the conflict manually, then commit the resolution.  
   > *Note: This extra step is optional and intended for those looking for an additional challenge.*

---

### Task 6: Explain Branching Strategies
1. **Document Your Process:**  
   - Create (or update) a file named `solution.md` in your repository.
   - List all the Git commands you used in Tasks 1–4.
   - **Explain:** Write a brief explanation on **why branching strategies are important** in collaborative development. Consider addressing:
     - Isolating features and bug fixes
     - Facilitating parallel development
     - Reducing merge conflicts
     - Enabling effective code reviews

---

### Bonus Task: Explore SSH Authentication
1. **Generate an SSH Key (if not already set up):**
   - Create an SSH key pair:
     ```bash
     ssh-keygen
     ```
   - Follow the prompts and then locate your public key (typically found at `~/.ssh/id_ed25519.pub`).

2. **Add Your SSH Public Key to GitHub:**  
   - Copy the contents of your public key and add it to your GitHub account under **SSH and GPG keys**.  
     (See [Connecting to GitHub with SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh) for help.)

3. **Switch Your Remote URL to SSH:**  
   - Change the remote URL from HTTPS to SSH:
     ```bash
     git remote set-url origin git@github.com:<your-username>/90DaysOfDevOps.git
     ```

4. **Push Your Branch Using SSH:**  
   - Test the SSH connection by pushing your branch:
     ```bash
     git push origin feature-update
     ```

---

## 📢 How to Submit

1. **Push Your Final Work:**  
   - Ensure your branch (e.g., `feature-update`) with the updated `solution.md` file is pushed to your fork.

2. **Create a Pull Request (PR):**  
   - Open a PR from your branch to the main repository.
   - Use a clear title such as:
     ```
     Week 4 Challenge - DevOps Batch 9: Git & GitHub Advanced Challenge
     ```
   - In the PR description, summarize your process and list the Git commands you used.

3. **Share Your Experience on LinkedIn:**  
   - Write a LinkedIn post summarizing your Week 4 experience.
   - Include screenshots or logs of your tasks.
   - Use hashtags: **#90DaysOfDevOps #GitGithub #DevOps**
   - Optionally, share any blog posts, GitHub repos, or articles you create about this challenge.

---

## Additional Resources

- **Git Documentation:**  
  [https://git-scm.com/docs](https://git-scm.com/docs)

- **Creating a Personal Access Token:**  
  [GitHub PAT Setup](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)

- **Forking and Cloning Repositories:**  
  [Fork a Repository](https://docs.github.com/en/get-started/quickstart/fork-a-repo) | [Cloning a Repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)

- **SSH Authentication with GitHub:**  
  [Connecting to GitHub with SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)

- **Understanding Branching Strategies:**  
  [Git Branching Strategies](https://www.atlassian.com/git/tutorials/comparing-workflows)

---

Happy coding and best of luck with this challenge! Document your journey thoroughly and be sure to explore the additional resources if you get stuck.
