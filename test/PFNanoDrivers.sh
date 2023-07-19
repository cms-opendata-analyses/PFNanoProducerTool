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

# MC (2016, postVFP):
#cmsDriver.py nano_mc_2016_ULPostVFP --mc --eventcontent NANOAODSIM --datatier NANOAODSIM --step NANO \
#--conditions 106X_mcRun2_asymptotic_v15  --era Run2_2016,run2_nanoAOD_106Xv1 \
#--customise_commands="process.add_(cms.Service('InitRootHandlers', EnableIMT = cms.untracked.bool(False)))" --nThreads 4 \
#-n 100 --filein /store/mc/RunIISummer19UL16MiniAOD/QCD_Pt_2400to3200_TuneCP5_13TeV_pythia8/MINIAODSIM/106X_mcRun2_asymptotic_v13-v2/100000/EF482706-F402-E648-AB6A-D5B2700C8023.root --fileout file:nano_mc2016post.root \
#--customise PhysicsTools/PFNano/pfnano_cff.PFnano_customizeMC$NOINPUTS  $NO_EXEC $PARALLEL

# MC from MCM, Summer20UL
#cmsDriver.py nano_mc_2016_ULPostVFP --mc --eventcontent NANOAODSIM --datatier NANOAODSIM --step NANO \
#--conditions 106X_mcRun2_asymptotic_v17 --era Run2_2016,run2_nanoAOD_106Xv2 \
#--customise_commands="process.add_(cms.Service('InitRootHandlers', EnableIMT = cms.untracked.bool(False)))" --nThreads 4 \
#--fileout file:nano_mc2016post.root  --filein /store/mc/RunIISummer20UL16MiniAODv2/QCD_HT1000to1500_TuneCP5_PSWeights_13TeV-madgraph-pythia8/MINIAODSIM/106X_mcRun2_asymptotic_v17-v1/2520000/302EA76A-383E-9A44-88A4-B5832C5BB88E.root -n 100 \
#--customise PhysicsTools/PFNano/python/pfnano_cff.PFnano_customizeData_onlyaddPFcands$NOINPUTS  $NO_EXEC $PARALLEL

# Data (2016), edited according to the Nano gitlab page of conditions:
cmsDriver.py nano_data_2016_UL --data --eventcontent NANOAODSIM --datatier NANOAODSIM --step NANO \
--conditions 106X_dataRun2_v37   --era Run2_2016,run2_nanoAOD_106Xv2 \
--customise_commands="process.add_(cms.Service('InitRootHandlers', EnableIMT = cms.untracked.bool(False)))" --nThreads 4 \
-n 100 --filein /store/data/Run2016H/JetHT/MINIAOD/UL2016_MiniAODv2-v2/130000/676E37D2-044C-D346-92D9-A127A55FD279.root --fileout file:nano_data2016.root \
--customise PhysicsTools/PFNano/pfnano_cff.PFnano_customizeData_onlyaddPFcands$NOINPUTS  $NO_EXEC $PARALLEL

