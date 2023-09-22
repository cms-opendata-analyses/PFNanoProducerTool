# Auto generated configuration file
# using: 
# Revision: 1.19 
# Source: /local/reps/CMSSW/CMSSW/Configuration/Applications/python/ConfigBuilder.py,v 
# with command line options: nano_data_2016_UL --data --eventcontent NANOAODSIM --datatier NANOAODSIM --step NANO --conditions 106X_dataRun2_v37 --era Run2_2016,run2_nanoAOD_106Xv2 --customise_commands=process.add_(cms.Service('InitRootHandlers', EnableIMT = cms.untracked.bool(False))) --nThreads 4 -n 100 --filein /store/data/Run2016H/JetHT/MINIAOD/UL2016_MiniAODv2-v2/130000/676E37D2-044C-D346-92D9-A127A55FD279.root --fileout file:nano_data2016.root --customise PhysicsTools/PFNano/pfnano_cff.PFnano_customizeData_onlyaddPFcands
import sys
import os

# This is a copy of the auto generated configuration file with the addition of input file parameters
# for easier use in a cloud environment
# Arguments:
# - first file number
# - last file number 
# - file listing name
# - number of events
# 
# If you do not give them all, you will get:
##### Exception Message:
##### python encountered the error: <type 'exceptions.IndexError'>
##### list index out of range
#----
#---- sys.argv takes the parameters given as input cmsRun <config_file> <first file n> <last file n> <file listing> <n events> 
#---- NB the first two parameters are always "cmsRun" and the config file name
import FWCore.ParameterSet.Config as cms

from Configuration.Eras.Era_Run2_2016_cff import Run2_2016
from Configuration.Eras.Modifier_run2_nanoAOD_106Xv2_cff import run2_nanoAOD_106Xv2

process = cms.Process('NANO',Run2_2016,run2_nanoAOD_106Xv2)

# import of standard configurations
process.load('Configuration.StandardSequences.Services_cff')
process.load('SimGeneral.HepPDTESSource.pythiapdt_cfi')
process.load('FWCore.MessageService.MessageLogger_cfi')
process.load('Configuration.EventContent.EventContent_cff')
process.load('Configuration.StandardSequences.GeometryRecoDB_cff')
process.load('Configuration.StandardSequences.MagneticField_AutoFromDBCurrent_cff')
process.load('PhysicsTools.NanoAOD.nano_cff')
process.load('Configuration.StandardSequences.EndOfProcess_cff')
process.load('Configuration.StandardSequences.FrontierConditions_GlobalTag_cff')

#process.maxEvents = cms.untracked.PSet(
#    input = cms.untracked.int32(100)
#)
#---- Select the maximum number of events to process (if -1, run over all events)
nevents = eval(sys.argv[5])
process.maxEvents = cms.untracked.PSet( input = cms.untracked.int32(nevents) )

# Input source
#process.source = cms.Source("PoolSource",
#    fileNames = cms.untracked.vstring('/store/data/Run2016H/JetHT/MINIAOD/UL2016_MiniAODv2-v2/130000/676E37D2-044C-D346-92D9-A127A55FD279.root'),
#    secondaryFileNames = cms.untracked.vstring()
#)
#---- Define the test source files to be read using the xrootd protocol, requires file list as input (/mnt/vol/files_recid.txt) and first and last file numbers
fileindex = eval(sys.argv[4])
files = open(fileindex, "r").read().splitlines()
f = eval(sys.argv[2])
l = eval(sys.argv[3])
#print(files[f-1:l])
process.source = cms.Source("PoolSource",
  fileNames = cms.untracked.vstring(files[f-1:l])
)

process.options = cms.untracked.PSet(

)

# Production Info
process.configurationMetadata = cms.untracked.PSet(
    annotation = cms.untracked.string('nano_data_2016_UL nevts:100'),
    name = cms.untracked.string('Applications'),
    version = cms.untracked.string('$Revision: 1.19 $')
)

# Output definition

process.NANOAODSIMoutput = cms.OutputModule("NanoAODOutputModule",
    compressionAlgorithm = cms.untracked.string('LZMA'),
    compressionLevel = cms.untracked.int32(9),
    dataset = cms.untracked.PSet(
        dataTier = cms.untracked.string('NANOAODSIM'),
        filterName = cms.untracked.string('')
    ),
    fileName = cms.untracked.string('file:nano_data2016.root'),
    outputCommands = process.NANOAODSIMEventContent.outputCommands
)

# Additional output definition

# Other statements
from Configuration.AlCa.GlobalTag import GlobalTag
process.GlobalTag = GlobalTag(process.GlobalTag, '106X_dataRun2_v37', '')

# Path and EndPath definitions
process.nanoAOD_step = cms.Path(process.nanoSequence)
process.endjob_step = cms.EndPath(process.endOfProcess)
process.NANOAODSIMoutput_step = cms.EndPath(process.NANOAODSIMoutput)

# Schedule definition
process.schedule = cms.Schedule(process.nanoAOD_step,process.endjob_step,process.NANOAODSIMoutput_step)
from PhysicsTools.PatAlgos.tools.helpers import associatePatAlgosToolsTask
associatePatAlgosToolsTask(process)

#Setup FWK for multithreaded
process.options.numberOfThreads=cms.untracked.uint32(4)
process.options.numberOfStreams=cms.untracked.uint32(0)
process.options.numberOfConcurrentLuminosityBlocks=cms.untracked.uint32(1)

# customisation of the process.

# Automatic addition of the customisation function from PhysicsTools.NanoAOD.nano_cff
from PhysicsTools.NanoAOD.nano_cff import nanoAOD_customizeData 

#call to customisation function nanoAOD_customizeData imported from PhysicsTools.NanoAOD.nano_cff
process = nanoAOD_customizeData(process)

# Automatic addition of the customisation function from PhysicsTools.PFNano.pfnano_cff
from PhysicsTools.PFNano.pfnano_cff import PFnano_customizeData_onlyaddPFcands 

#call to customisation function PFnano_customizeData_onlyaddPFcands imported from PhysicsTools.PFNano.pfnano_cff
process = PFnano_customizeData_onlyaddPFcands(process)

# End of customisation functions

# Customisation from command line

process.add_(cms.Service('InitRootHandlers', EnableIMT = cms.untracked.bool(False)))
# Add early deletion of temporary data products to reduce peak memory need
from Configuration.StandardSequences.earlyDeleteSettings_cff import customiseEarlyDelete
process = customiseEarlyDelete(process)
# End adding early deletion
