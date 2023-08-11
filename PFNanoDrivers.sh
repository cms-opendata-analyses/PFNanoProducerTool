#!/bin/bash

# Super overblown parser
PARAMS=""
# Set defaults
NO_EXEC="--no_exec "
# Parser
while (( "$#" )); do
  # Parse
  case "$1" in
    -e|--exec)
      NO_EXEC=""
      shift
      ;;
    -p|--parallel)
      PARALLEL=" &"
      shift
      ;;
    --noInputs)
      NOINPUTS="_noInputs"
      shift
      ;;
    -b|--my-flag-with-argument)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        MY_FLAG_ARG=$2
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        exit 1
      fi
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done
# set positional arguments in their proper place
eval set -- "$PARAMS"

### Drivers to add ONLY the basic PFCandidates collection to NanoAOD

# MC, Summer20UL
cmsDriver.py pfnano_mc_2016UL_OpenData --mc --eventcontent NANOEDMAODSIM --datatier NANOAODSIM --step NANO \
--conditions 106X_mcRun2_asymptotic_v17 --era Run2_2016,run2_nanoAOD_106Xv2 \
--customise_commands="process.add_(cms.Service('InitRootHandlers', EnableIMT = cms.untracked.bool(False)))" --nThreads 4 \
--fileout file:nano_mc2016post.root  --filein "root://cmseos.fnal.gov//store/user/jmanagan/QCDtestfile.root" -n 100 \ 
--customise PhysicsTools/PFNano/pfnano_cff.PFnano_customizeMC_onlyaddPFcands$NOINPUTS  $NO_EXEC $PARALLEL

# Data 2016
cmsDriver.py pfnano_data_2016UL_OpenData --data --eventcontent NANOAODSIM --datatier NANOAODSIM --step NANO \
--conditions 106X_dataRun2_v37   --era Run2_2016,run2_nanoAOD_106Xv2 \
--customise_commands="process.add_(cms.Service('InitRootHandlers', EnableIMT = cms.untracked.bool(False)))" --nThreads 4 \
-n 100 --filein /store/data/Run2016H/JetHT/MINIAOD/UL2016_MiniAODv2-v2/130000/676E37D2-044C-D346-92D9-A127A55FD279.root --fileout file:nano_data2016.root \
--customise PhysicsTools/PFNano/pfnano_cff.PFnano_customizeData_onlyaddPFcands$NOINPUTS  $NO_EXEC $PARALLEL

### Drivers to add general PFCandidates AND specific jet candidates to NanoAOD

# MC, Summer20UL
# cmsDriver.py pfnano_jetcands_mc_2016UL_OpenData --mc --eventcontent NANOEDMAODSIM --datatier NANOAODSIM --step NANO \
# --conditions 106X_mcRun2_asymptotic_v17 --era Run2_2016,run2_nanoAOD_106Xv2 \
# --customise_commands="process.add_(cms.Service('InitRootHandlers', EnableIMT = cms.untracked.bool(False)))" --nThreads 4 \
# --fileout file:nano_mc2016post.root  --filein "root://cmseos.fnal.gov//store/user/jmanagan/QCDtestfile.root" -n 100 \ 
# --customise PhysicsTools/PFNano/pfnano_cff.PFnano_customizeMC_allPF$NOINPUTS  $NO_EXEC $PARALLEL

# Data 2016
# cmsDriver.py pfnano_jetcands_data_2016UL_OpenData --data --eventcontent NANOAODSIM --datatier NANOAODSIM --step NANO \
# --conditions 106X_dataRun2_v37   --era Run2_2016,run2_nanoAOD_106Xv2 \
# --customise_commands="process.add_(cms.Service('InitRootHandlers', EnableIMT = cms.untracked.bool(False)))" --nThreads 4 \
# -n 100 --filein /store/data/Run2016H/JetHT/MINIAOD/UL2016_MiniAODv2-v2/130000/676E37D2-044C-D346-92D9-A127A55FD279.root --fileout file:nano_data2016.root \
# --customise PhysicsTools/PFNano/pfnano_cff.PFnano_customizeData_allPF$NOINPUTS  $NO_EXEC $PARALLEL
