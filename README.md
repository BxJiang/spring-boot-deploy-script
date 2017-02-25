# spring-boot-deploy-script
## PREREQUISITES:
    1. Gradle > 2.0.0 is installed
    2. Your project is build with gradle
    3. Your deploy profile is 'online', or you shold change the profile set in 'app.sh'
    4. You deploy on linux system
  
## HOW TO USE:
    1. git clone https://github.com/BxJiang/spring-boot-deploy-script.git ~/script
    2. copy deploy.sh to root directory of your project
    3. set APP_NAME and VERSION variable in deploy.sh (in your project root dir)
    4. run deploy.sh

## WHAT YOU GET:
    1. ~/app/your_app
    2. run {your_app_name}.sh to see what you can do with your deployed app
