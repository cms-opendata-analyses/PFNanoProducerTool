# PFNano

This is a [NanoAOD](https://twiki.cern.ch/twiki/bin/view/CMSPublic/WorkBookNanoAOD) framework that allows users to add Particle Flow candidates to NanoAOD files, by preprocessing MiniAOD files. 

The current full content of these NanoAOD files can be seen [here](https://htmlpreview.github.io/?https://github.com/josephmoop/PFNano/blob/c6ea74b6f5ac6646c5ab86dac0b1a6e0fb4edeae/test/nanoAOD_2016MC.html).
In this version, PFcandidates can be saved in several collections: general PF candidates only, AK4 jet candidates only, AK8 jet candidate only, or all the PF candidates. 
This format can be used with [fastjet](http://fastjet.fr) directly.

## Recipe

This repository is intended to be used in the CMSSW_10_6_30 docker container for Open Data.
A getting-started tutorial for using this container can be found FIXME.

To install PFNanoProducerTool, launch the CMSSW_10_6_30 container, and make sure you are located in CMSSW_10_6_30/src. 

```
cmsenv
git clone https://github.com/cms-opendata-analyses/PFNanoProducerTool.git PhysicsTools/PFNano
scram b
cd PhysicsTools/PFNano/
```

There are python config files ready to run in `PhysicsTools/PFNano/` for the 2016UL Open Data. The default setting is to add only the general PF Candidate collection.

```
cmsRun pfnano_data_2016UL_OpenData.py
```

### How to create python files using cmsDriver

All python config files were produced with `cmsDriver.py`. as shown in `PFNanoDrivers.sh`.

For OpenData 2016 the conditions, global tags, etc, are all correct. However users should customize the input files and output file names. 

To run the driver script:
```
bash PFNanoDrivers.sh  # run to only produce configs
bash PFNanoDrivers.sh  -e # run to actually execute configs on 100 events
```

Commented example cmsDriver commands are included in this script to show how the NanoAOD customization can be changed to add more PF candidate collections.
All available options can be found by studying `python/pfnano_cff.py`. 



