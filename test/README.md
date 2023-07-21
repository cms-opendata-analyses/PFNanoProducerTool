# Open Data PFNano


## Creating the PFNanoDrivers.sh Script

Utilizing the cmsrun command, we ran `bash PFNanoDrivers.sh -e` to create the configs and execute. The PFNanoDrivers.sh file was a condensed version of the make_configs_UL.sh file. It only included the data and MC from 2016 instead from 2016-2018. This shell script gave us nano_data2016.root.

## Edits to addPFCands_cff.py & pfnano_cff.py

We made a few minor edits to the logic of the addPFCands_cff file in order to make the file only output packed PFCands. We added a function in pfnano_cff that set the pfcands parameter to be true which allows it to only add the pfcands. 

## Getting HTML Files

We ran the following command to get an HTML file utilizing the above changes:
```
python PhysicsTools/NanoAOD/test/inspectNanoFile.py PhysicsTools/PFNano/test/nano_data2016.root -s website_with_collectionsize.html -d sillyHTML.html
```
This yielded this [data HTML file](https://htmlpreview.github.io/?https://github.com/josephmoop/PFNano/blob/c6ea74b6f5ac6646c5ab86dac0b1a6e0fb4edeae/test/nanoAOD_2016data.html). When modifying the config file slightly, the code gave this [Monty Carlo HTML file](https://htmlpreview.github.io/?https://github.com/josephmoop/PFNano/blob/c6ea74b6f5ac6646c5ab86dac0b1a6e0fb4edeae/test/nanoAOD_2016MC.html). 

## Edits to card_example.yml

After creating the config files, the main edits that are needed to be made are the card_example.yml file. The file utilizes the information given in the file to create a crab job. The necessary edits to the card_example.yml file are as follows:

1. storageSite = T3_US_FNALLPC
2. outLFNDirBase: '/store/user/your_username/Whatever_Directory'
4. voGroup: uscms group 
5. config: python file created by running PFNanoDrivers.sh
6. data: /JetHT/Run2016H-UL2016_MiniAODv2-v2/MINIOAD /JetHT/Run2016H-UL2016_MiniAODv2-v2/MINIOAD-> should correspond to what is in "datasets." 
7. If lumimask is desired, you will need to find and paste the proper URL. Our URL looked like this:
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
When running `python crabby.py -c card_example.yml --make --submit` command it will give you the file path for you to put in. <br>

