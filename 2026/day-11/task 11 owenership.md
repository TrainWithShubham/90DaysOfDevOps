# Create files
touch devops-file.txt
touch project-data.txt
touch scripts.sh

# Create directories
mkdir team-folder
mkdir secure-data

# Check ownership
ls -l

# Change owner and group
sudo chown tokyo:heist-team devops-file.txt
sudo chown berlin:heist-team project-data.txt
sudo chown professor:admin-team scripts.sh

# Change ownership recursively for directory
sudo chown -R tokyo:heist-team team-folder
sudo chown -R professor:admin-team secure-data

# Change only group
sudo chown :admin-team scripts.sh
