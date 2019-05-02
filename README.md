# GLPI-Docker-installer

Install GLPI in a Docker container

0 - If no updates are merged in git GLPI, proced
If yes read # Updates in GLPI versions

1 - Add a password on docker-compose.yml lines #17 & #20

2 - Execute create.sh + <Version of GLPI>
$sh create.sh 9.4.2
Type the same password on docker-compose.yml file

3 - Run docker stack deploy --compose-file docker-compose.yml glpi

# Important

- On docker-compose.yml add a password in lines 17 & 20

(Note! Remember that pass to use in 'create.sh' script)

# Updates in GLPI versions

- After merge updates on git GLPI, change the version in docker-compose.yml (line #4)
- Then use that numbering to execute create.sh
