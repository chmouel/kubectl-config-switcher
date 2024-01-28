#!/usr/bin/env zsh -f
# compdef '_arguments "1: :(${(Q)$(_kcs_list_profiles)})"' kcs

KCS_DIR="${HOME}/.kube"

function _kcs_set_kubeconfig() {
    local profile=${1}
    export KCS_PROFILE=${profile}
    local profilefile=${KCS_DIR}/config.${profile}
    local color=${KCS_DEFAULT_PROMPT_COLOR}
    local ns_color=${KCS_DEFAULT_NS_PROMPT_COLOR}

    [[ -e ${profilefile} ]] || {
        echo "I could not find the file ${profilefile}"
        return 1
    }

    [[ -e ${profilefile}.kcs.pre ]] && {
        source ${profilefile}.kcs.pre
    }

    export KUBECONFIG=${profilefile}
    touch ${KUBECONFIG}
}

function _kcs_list_profiles() {
    local _profiles=($HOME/.kube/config.*(Om));
    for file in ${(Oa)_profiles};do
        profile=${file#*/config.}
        [[ -z ${profile} ]] && continue
        echo ${profile[@]}
    done
}

function _kcs_set_last_profile() {
    local _files=($HOME/.kube/config.*(Om));
    local file=${_files[-1]}
    echo "Setting kubeconfig profile to ${file#*/config.}"
    _kcs_set_kubeconfig ${file#*/config.}
}

function _kcs_usage() {
    cat <<EOF
Usage: kcs [profile]

-L list profiles
-L Set to last profile
EOF
}

function kcs () {
    while getopts 'Ll' arg;do
        case $arg in
            (l)
                _kcs_list_profiles;
                return 0;;
            (L)
                _kcs_set_last_profile;
                return 0;;

            (*)
                _kcs_usage;
                return 1;;
        esac
    done
    shift $(( OPTIND - 1 ))
    profile=${1}
    [[ -z ${profile} ]] &&  {
        profile=$(_kcs_list_profiles | fzf --history=${HOME}/.kube/.kcs.history -1)
    }
    [[ -n ${profile} ]] && _kcs_set_kubeconfig ${profile}
}
