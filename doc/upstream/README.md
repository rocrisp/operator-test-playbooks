# Instruction for operator test via ansible

## Standard test on clean machine
```
ansible-playbook -vv -i myhost, local.yml \
-e run_upstream=true \
-e operator_dir=/tmp/community-operators-for-catalog/upstream-community-operators/aqua
```

## Standard test with operator prerequisites (-e run_prereqs=true)
```
ansible-playbook -vv -i myhost, local.yml \
-e run_upstream=true \
-e operator_dir=/tmp/community-operators-for-catalog/upstream-community-operators/aqua \
--tags test
```

## Standard test without operator prerequisites (-e run_prereqs=false)
```
ansible-playbook -vv -i myhost, local.yml \
-e run_upstream=true \
-e operator_dir=/tmp/community-operators-for-catalog/upstream-community-operators/aqua \
--tags pure_test
```
or
```
ansible-playbook -vv -i myhost, local.yml \
-e run_upstream=true \
-e operator_dir=/tmp/community-operators-for-catalog/upstream-community-operators/aqua \
--tags test \
-e run_prereqs=false
```

## Super full test on clean machine
```
ansible-playbook -vv -i myhost, local.yml \
-e run_upstream=true \
-e operator_dir=/tmp/community-operators-for-catalog/upstream-community-operators/aqua \
-e run_manifest_test=true \
-e run_bundle_test=true
```

## Super full test quick (without installation)
```
ansible-playbook -vv -i myhost, local.yml \
-e run_upstream=true \
-e operator_dir=/tmp/community-operators-for-catalog/upstream-community-operators/aqua \
-e run_manifest_test=true \
-e run_bundle_test=true \
--tags pure_test
```

## Install host only
```
ansible-playbook -vv -i myhost, local.yml \
-e run_upstream=true \
--tags install
```

## Reset host (eg. kind, registry)
```
ansible-playbook -vv -i myhost, local.yml \
-e run_upstream=true \
--tags reset
```

## Install dependency in playbook docker image when building
```
ansible-playbook -vv -i myhost, local.yml \
-e run_upstream=true \
--tags image_build
```

## Input source image (not supported now)
```
ansible-playbook -vv -i myhost, local.yml \
-e run_upstream=true \
-e operator_input_image=quay.io/cvpops/test-bundle:tigera-131 \
--tags pure_test
```

## Deploy operators to index
Config file:
```
$ cat test/operatos_config.yaml
operator_base_dir: /tmp/community-operators-for-catalog/upstream-community-operators
operators:
- aqua
- prometheus
```

### Deploy starting index image
```
ansible-playbook -vv -i myhost, local.yml \
-e run_upstream=true \
--tags deploy_bundles \
-e operators_config=test/operatos_config.yaml
```

### Deploy starting index image
```
ansible-playbook -vv -i myhost, local.yml \
-e run_upstream=true \
--tags deploy_bundles \
-e operators_config=test/operatos_config.yaml
-e bundle_registry=quay.io \
-e bundle_image_namespace=operator_testing \
-e bundle_index_image_namespace=operator_testing \
-e bundle_index_image_name=upstream-community-operators-index \
-e quay_api_token=<quay-api-token>
```

### Deploy index image and force channels to be autodetected by playbook
```
ansible-playbook -vv -i myhost, local.yml \
-e run_upstream=true \
--tags deploy_bundles \
-e operators_config=test/operatos_config.yaml
-e operator_channel_force=""
```

### Deploy index image and force channels to stable
```
ansible-playbook -vv -i myhost, local.yml \
-e run_upstream=true \
--tags deploy_bundles \
-e operators_config=test/operatos_config.yaml
-e operator_channel_force=stable
```

## Misc options to use

Usage:

```
-e <option>=<value>
```

| Option  | Description  | Default value |
|---|---|---|
| run_upstream | Flag when running upstream part of playbooks. [bool] | false |
| run_remove_catalog_repo | Removes existing git repo for comunity-operators. [bool] | true |
| catalog_repo | Community operators repo url. [string] | https://github.com/operator-framework/community-operators.git |
| catalog_repo_branch | Community operators branch in repo. [string] | master |
| operators_config  | Path to operators config file using when deploying multiple operators. Examle in test/operatos_config.yaml. [string] | undefined  |
| quay_user | Username in quay registry login. [string] | undefined  |
| quay_password | Password in quay registry login. [string] | undefined  |
| quay_api_token | Quay api token to create project, delete tag. [string] | undefined |
| bundle_registry | Quay bundle and index registry url. [string] | kind-registry:5000 |
| bundle_image_namespace | Quay registry url. [string] | test-operator |
| bundle_index_image_namespace | Quay registry url. [string] | test-operator |
| bundle_index_image_name | Quay registry url. [string] | index |
| opm_container_tool | Container tool to use when using opm tool. [string] | docker  |
| operator_channel_force | Forcing to adde channel and default channed to current string value. When empty string it is autodetected by playbook. [string] | undefined  |
| index_force_rebuild | Force to rebuild currently running operators in index. [bool] | false  |
| index_skip | Skip building index (it will build bundle only). [bool] | undefined |

