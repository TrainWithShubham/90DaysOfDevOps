### 1️⃣ What Can Go Wrong?
When **5 developers push code and deploy manually**, many problems can happen:
**Code Conflicts**
- Two developers modify the same file
- When merged, the application may break.

**Untested Code in Production**
  - Code may be deployed without proper testing.
  - Bugs reach production.
    
**Human Error**
Exmple:
- Deploy wrong branch
- Miss a file during deployment
- Wron environment variable
- Wrong server

**Overwriting Changes**
Developer A deploys version 1
Devolper B deploys older version by mistakes

**Environment Differences**
Production may not match the production machine.
```
id="envdiff"

Dev machine: Node 18
Server: Node 16
```
Apppliction may crash

**Depoyment Downtime**
Manual Deployment offent cause:
- service intteruption
- longer process

### 2️⃣ What Does “It Works on My Machine” Mean?

 This Means: 
  The code works correctly on the Developer's computer but fails in another environment (testing or production).

Exmple:

Developer machine:

 ```
id="devenv"
Node 18
Decoker installed
Correct environment variable
```
Production Server

```
id="prodenv"
Node 16
missing dependency
Different OS configuration
```
Result: Application Crashes.
As we can see both developer and production have different verion of node, dependency is missing in production and OS is defferent.

This is why DevOps uses:
- Docker
- CI/CDpipeline
- Infrastrcture as code

They ensure the same environment everywhere.

### 3️⃣ How Many Times Can a Team Safely Deploy Manually?

1-2 times per day at most
Maual deployment require;
- coordination
- downtime window
- testing after deploymet

Example workflow:

```
id="maualdeploy"

Prepare release
Stop server
Upload files
Test manually
```
This take time and risky.
 **How CI/CD Solves This**
 with CI/CD:

 ```
id="cicdflow"
Developer pushes code
↓
Automated tests run
↓
Build artifact
↓
Deploy automatically
```
Benefits:
- Deploy 10–100 times per day
- Consistent environments
- No manual mistakes
- Faster feedback

  Companies like **Amazon deploy thousands of times per day** using CI/CD.
