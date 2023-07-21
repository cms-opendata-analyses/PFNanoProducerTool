# Open Data PFNano

## CMS driver commands

For this you need to utilize the following commands if you haven't run them already:

```
cmsenv
voms-proxy-init --voms cms --valid 168:00
source crab.sh
python crabby.py -c card_example.yml --make --submit
```
To check the status of your crab job, it should look something like this: 

```
crab status -d <path>
```
When running
``` 
python crabby.py -c card_example.yml --make --submit
``` 
command it will give you the 
