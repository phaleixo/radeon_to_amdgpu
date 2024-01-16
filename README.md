# radeon_to_amdgpu
Trocar Radeon para Amdgpu em distros baseadas no Debian

Script para ativar o drive amdgpu e desativar o drive Radeon no linux, testada no Debian 12, mas deve funcionar em qualquer distro baseada em Debian.
Abaixo está uma lista de todos os modelos de GPUs das famílias ‘Sea Islands’ e ‘Southern Islands’.
Caso a sua GPU esteja nessa lista, então o procedimento provavelmente será necessário.  

Tahiti,
Bonaire,
Hawaii, 
Pitcairn,
Cape Verde,
Oland.  

Passo a passo:
-----------------------------------------
Forma simples com um comando apenas com curl (Recomendado).

Abra o gnome-terminal copie e cole o comando abaixo:
```
curl -o radeon_to_amdgpu.sh https://raw.githubusercontent.com/phaleixo/radeon_to_amdgpu/main/radeon_to_amdgpu.sh && chmod +x radeon_to_amdgpu.sh && ./radeon_to_amdgpu.sh && rm radeon_to_amdgpu.sh
```
Após instalado reinice.

Para verificar se o amdgpu está ativo rode o comando:
```
lspci -k | grep amdgpu
```
----------------------------------------




