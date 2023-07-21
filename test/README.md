# Open Data PFNano

## Edits to Files

The main edits that are needed to be made are the card_example.yml file. The file utilizes the information given in the file to create a crab job. The important points to edit are the datasets you are working with as well as the config file needed.

storageSite = T3_US_FNALLPC<br>
directory = /store/user/your_username/WHATEVER<br>
CMS group: ex. uscms group (if in the US)<br>
config: python file created by running PFNanoDrivers.sh<br>
data: /JetHT/Run2016H-UL2016_MiniAODv2-v2/MINIOAD -> should correspond to what is in "datasets." It will differ based on what dataset you have been working on.<br>
If lumimask is desired, you will need to find and paste the proper URL. An example url would look like this:
```
'https://cms-service-dqmdc.web.cern.ch/CAF/certification/Collisions16/13TeV/Cert_271036-275783_13TeV_PromptReco_Collisions16_JSON.txt'
```

## Submission to Crab

For this you need to utilize the following commands if you haven't run them already:

```
cmsenv
voms-proxy-init --voms cms --valid 168:00
source crab.sh
python crabby.py -c card_example.yml --make --submit
```
The `voms-proxy-init --voms cms --valid 168:00` is important as it extends the proxy for a week, allowing time for the job to complete.
To check the status of your crab job, it should look something like this: 

```
crab status -d <path>
```
When running `python crabby.py -c card_example.yml --make --submit` command it will give you the file path for you to put in. 

