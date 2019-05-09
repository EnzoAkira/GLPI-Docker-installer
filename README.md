## GLPI-Docker-installer

Install GLPI in a Docker container

 0 - If no updates are merged into git GLPI, proceed
  * If yes read **Updates in GLPI versions**

 1 - Add a password on docker-compose.yml @lines #17 & #20

 2 - Execute create.sh + <Version of GLPI>
  * $sh create.sh 9.4.3
  * Type the same password put on docker-compose.yml file

 3 - Run docker stack deploy --compose-file docker-compose.yml glpi

## Updates in GLPI versions

- After merge updates on git GLPI 9.X/gocontact, change the version in docker-compose.yml (line #4)
- Then use that numbering to execute create.sh


## Important

- On docker-compose.yml add a password at lines 17 & 20

(**Note!** Remember to use the same password on 'create.sh' script)