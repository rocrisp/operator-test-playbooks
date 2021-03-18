#!/bin/bash
set +o pipefail


for CSV_TO_TEST in $OP_TEST_MODIFIED_CSVS; do
CSV_PATH_TO_TEST="https://raw.githubusercontent.com/$OP_TEST_MODIFIED_REPO_BRANCH/$CSV_TO_TEST"

GODEBUG=x509ignoreCN=0 ansible-pull -U $OP_TEST_ANSIBLE_PULL_REPO -C $OP_TEST_ANSIBLE_PULL_BRANCH -i localhost, -e ansible_connection=local upstream/local.yml -e run_upstream=true --tags cosmetics -e run_bundle_test=true -e run_remove_catalog_repo=false -vv -e csv_external_file_path=$CSV_PATH_TO_TEST -e run_prepare_catalog_repo_upstream=false
done