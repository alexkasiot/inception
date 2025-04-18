WORK IN PROGRESS (also the instructions)
- run "make" to build .secrets folder/files, .env file and the containers' volumes
- populate the secrets and the env files with the desired values by changing [your_value] to the desired value in the vars_init.sh script and then runnning it. The example script will always exist for reference.
- run "make up" for compose to build and start everything
- run "make down" for compose to stop and remove the containers
- run "make fclean" to clean everything and start with a clean slate
- rum "make f_super_clean" to also clean the variables initialization script