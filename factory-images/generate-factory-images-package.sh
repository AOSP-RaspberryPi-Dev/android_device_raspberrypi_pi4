#!/bin/bash

# Copyright 2023 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

get_build_var() {
    "${ANDROID_BUILD_TOP}"/build/soong/soong_ui.bash --dumpvar-mode "${1}"
}

SCRIPT_PATH="${BASH_SOURCE[0]}"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

source "${SCRIPT_DIR}"/../../../common/clear-factory-images-variables.sh
BUILD="$(whoami)"
DEVICE="$(get_build_var TARGET_DEVICE)"
PRODUCT="$(get_build_var TARGET_PRODUCT)"
VERSION="$(get_build_var BUILD_ID)"
SRCPREFIX=
BOOTLOADER="U-Boot-$(cat "${OUT}"/obj/U_BOOT_OBJ/include/config/uboot.release | sed 's/\"//g')"
source "${SCRIPT_DIR}"/../../../common/generate-factory-images-common.sh
