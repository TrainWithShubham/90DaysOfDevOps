# Day 42 – Runners: GitHub-Hosted and Self-Hosted

## What I learned today

Today I learned what a runner is. A runner is the machine that actually runs my workflow jobs. I learned about two kinds: GitHub-hosted runners, and my own self-hosted runner.

---

## Task 1: GitHub-Hosted Runners

I made one workflow with 3 jobs. Each job ran on a different operating system: ubuntu-latest, windows-latest, and macos-latest. Each job printed its OS name, its hostname, and the current user running it.

What happened: all 3 jobs ran at the same time, in parallel, and each one printed its own details correctly.

Question: What is a GitHub-hosted runner? Who manages it?

My answer: A GitHub-hosted runner is a virtual machine that GitHub creates fresh for every workflow run, then deletes right after it finishes. GitHub manages it completely. I do not set it up, maintain it, or pay for any hardware. I just use it.

## Task 2: What Comes Pre-installed

On the ubuntu-latest runner, I added a step that checked the versions of Docker, Python, Node, and Git.

What happened: all four tools were already installed, with no setup needed from me. It printed real version numbers for each one.

Question: Why does it matter that runners come with tools pre-installed?

My answer: It saves time. If runners came empty, every single workflow would need extra steps to install Docker, Python, Node, and Git before doing any real work. This would make every run slower and more repetitive.

## Task 3: Setting Up My Own Self-Hosted Runner

I went to my repo settings, then Actions, then Runners, and added a new self-hosted runner. I chose Linux since I am using WSL on my Windows machine. I downloaded the runner, configured it with my repo token, and started it.

What happened: my runner showed up in the Runners list with a green dot, marked as Idle. This means it was online and ready to accept jobs.

## Task 4: Using My Self-Hosted Runner

I made a new file called self-hosted.yml. It uses runs-on self-hosted, so the job runs on my own machine instead of a GitHub cloud machine. The job printed the hostname, printed the working directory, created a small test file, and then showed the contents of that file.

What happened: the job ran successfully, and I confirmed the test file was really created on my own machine, not somewhere in the cloud.

## Task 5: Labels

I added a custom label called my-linux-runner to my self-hosted runner. Then I updated my workflow to require both labels together: self-hosted and my-linux-runner.

What happened: once my runner had that exact label, the job matched correctly and ran successfully on my machine again.

Question: Why are labels useful when you have multiple self-hosted runners?

My answer: Labels let me target one specific runner, or a specific group of runners, instead of just any random one. For example, if one runner has more memory, or a GPU, or a certain tool installed, labels let my workflow say "only run this job on the runner that has this label," instead of it landing on whichever machine happens to be free.

---

## Task 6: GitHub-Hosted vs Self-Hosted

|                     | GitHub-Hosted                                                | Self-Hosted                                                                                            |
| ------------------- | ------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------ |
| Who manages it?     | GitHub                                                       | Me                                                                                                     |
| Cost                | Free minutes included, then billed per minute                | Free to use, but I pay for my own hardware and electricity                                             |
| Pre-installed tools | Comes with Docker, Python, Node, Git already installed       | Nothing pre-installed, I set up everything myself                                                      |
| Good for            | Quick, simple jobs, and public open-source projects          | Special hardware needs like a GPU, private networks, custom software                                   |
| Security concern    | Low, since GitHub gives a fresh, isolated machine every time | Higher, especially on public repos, since a bad Pull Request could run harmful code on my real machine |

---

## Summary in my own simple words

- GitHub-hosted runner: a temporary machine that GitHub creates and manages for me.
- Self-hosted runner: my own machine, registered to my repo, that I fully control.
- Pre-installed tools save time because I do not need to install them every run.
- Labels let me choose exactly which runner should pick up a job.
- Self-hosted runners give me more control, but also more responsibility for security.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
