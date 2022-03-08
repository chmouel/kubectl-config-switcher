# Kubectl Config Switcher (kcs)

A zsh plugin to switch via KUBECONFIG env variable between kubectl config files located in `~/.kube/`

<img width="504" alt="image" src="https://user-images.githubusercontent.com/98980/154470753-36c17566-d813-4826-ae28-f65683aeb0ec.png">


### Description

I have different kubectl config files in my `~/.kube` directory and I swtich to them by terminal window for different profile.

kubectl-config-switch (kcs) help you moving between them with fzf. The last used config is always a ENTER away.

## Usage

* Load the plugin with your favourite zsh plugin manager or simply source the [kubectl-config-switcher.plugin.zsh](./kubectl-config-switcher.plugin.zsh) file
* use the `kcs` command and it will ask which profile to choose with `fzf`
* you can do a `kcs -l` to simply just list the profiles
* you can do a `kcs -L` to set it to the last kubeconfig that was chosen previously.

## Requirement

* fzf
* kubectl
* some kubernetes config files in `~/.kube` named as `~/.kube/config.${PROFILE_NAME}`

## Powerlevel10k Integration

the `KCS_PROFILE` env variable is exported so you can show it nicely in your prompt, for example with powerlevel9/10k add this to your configuration : 

```shell
  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION='%F{13}${${${:-$KCS_PROFILE}:-$P9K_KUBECONTEXT_CLUSTER}}%f'
  POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='/%F{3}${${:-$P9K_KUBECONTEXT_NAMESPACE}:-default}%f'
```

it will look like this :

<img width="606" alt="image" src="https://user-images.githubusercontent.com/98980/154470505-876e4e1f-f711-4d7e-afc9-21de99f3e551.png">
