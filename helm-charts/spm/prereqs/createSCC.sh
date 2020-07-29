#!/bin/sh
###############################################################################
# Copyright 2020 IBM Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
###############################################################################

usage() {
  echo "Usage: $0 [OPTIONS] [arg]"
  echo ""
  echo "  OPTIONS:"
  echo "  =============="
  echo "  -n|--namespace        [namespace]           - The name of an existing namespace for the SPM deployment."
  echo "  -h|--help                                   - Print this usage information."
  echo ""
}

if [ "$#" -lt 1 ]; then
  usage >&2
  exit 1
fi

while [ -n "$1" ]; do
  case $1 in
    -n|--namespace)
      NAMESPACE=$2
      shift 2
    ;;
    -h|--help)
      usage >&2
      exit 0
    ;;
    *)
      echo "Unknown option: $1"
      usage >&2
      exit 1
    ;;
  esac
done

kubectl get namespace $NAMESPACE &> /dev/null
if [ $? -ne 0 ]; then
  echo "ERROR: Namespace '$NAMESPACE' does not exist."
  usage >&2
  exit 1
fi

# Check if the user has permission to interact with SCCs
oc auth can-i list scc -A &> /dev/null
if [[ $? != 0 ]]; then
  echo "ERROR: The user '$(oc whoami)' does not have permission to assign SecurityContextConstraints! Contact your cluster administrator."
  exit 1
fi

# check to see if the SCC already exists
oc get scc spm-dev-scc
if [[ $? == 0 ]]; then
  echo "spm-dev-scc already exists"
  # SCC exists, check to see if the serviceaccount is already added
  oc describe scc spm-dev-scc | grep "Users:" | grep -q ${NAMESPACE}
  if [[ $? == 0 ]]; then
    # serviceaccount for this namespace is already there, do nothing
    echo "ServiceAccount: default for namespace ${NAMESPACE} is already bound to SCC spm-dev-scc, no addition to the scc is required"
  else
    # The serviceAccount: default  does not already exist for this namespace, it needs to be added to the spm-dev-scc SCC
    echo "ServiceAccount: default for namespace ${NAMESPACE} is not already bound to SCC spm-dev-scc, adding it now..."
    oc adm policy add-scc-to-user spm-dev-scc system:serviceaccount:${NAMESPACE}:default
  fi
else
  echo "SCC spm-dev-scc does not already exist, creating now...."
  sed -e "s/%NAMESPACE%/${NAMESPACE}/g" $(dirname $0)/scc.yaml | oc apply -f -
fi
