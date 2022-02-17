# kubectl-config-switcher

A zsh plugin to switch via KUBECONFIG env variable between kubectl config files located in ~/.kube/


### Description

I have different kubectl config files in my `~/.kube` directory and I swtich to them by terminal window for different profile.

kubectl-config-switch (kcs) help you moving between them with fzf. The last used config is always a ENTER away.

## Usage

* Load the plugin with your favourite zsh plugin manager or simply source the [kubectl-config-switcher.plugin.zsh](./kubectl-config-switcher.plugin.zsh) file
* Do a kcs

## Requirement

* fzf
* kubectl

## Powerlevel10k Integration

the `KCS_PROFILE` env variable is exported so you can show it nicely in your prompt, for example with powerlevel9/10k : 

```
  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION='%F{13}${${${:-$KCS_PROFILE}:-$P9K_KUBECONTEXT_CLUSTER}}%f'
  POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='/%F{3}${${:-$P9K_KUBECONTEXT_NAMESPACE}:-default}%f'
```

