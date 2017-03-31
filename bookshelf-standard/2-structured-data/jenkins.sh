#!/usr/bin/env bash

# Copyright 2017 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Fail on non-zero return and print command to stdout
set -xe

# Jenkins provides values for GOOGLE_PROJECT_ID and GOOGLE_VERSION_ID

# Make sure it works on GAE7

# Deploy and run selenium tests
mvn clean appengine:update verify \
  -Pselenium \
  -Dappengine.appId="${GOOGLE_PROJECT_ID}" \
  -Dappengine.version="${GOOGLE_VERSION_ID}"


# Make sure it deploys on GAE8

FILE_PATH=src/main/webapp/WEB-INF/appengine-web.xml
sed -i'.bak' '/<appengine-web-app/ a <runtime>java8</runtime>' "${FILE_PATH}"
# Restore the backup after we're done
trap 'mv "${FILE_PATH}"{.bak,}' EXIT
# Deploy and run selenium tests
mvn clean appengine:update verify \
  -Pselenium \
  -Dappengine.appId="${GOOGLE_PROJECT_ID}" \
  -Dappengine.version="${GOOGLE_VERSION_ID}"