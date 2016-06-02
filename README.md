## Deployment ##

Staging: https://give-staging.herokuapp.com  
Production: https://give-production.herokuapp.com  
  
To deploy to Staging: 
```
#!bash

git push staging develop:master
```
To deploy to Production:

```
#!bash

git push production master
```
When using heroku commands must specify remote

```
#!bash

heroku <command> <argument> --remote staging (or production)
```  