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

instale o git com o comando:
```
sudo apt install git
```
clone o repositorio com o comando:
```
git clone https://github.com/phaleixo/radeon_to_amdgpu.git
```
abra o terminal e acesse a pasta clonada:
```
cd radeon_to_amdgpu
```
Torne o script executavel: 
```
chmod +x radeon_to_amdgpu.sh
```
execute o script:
```
./radeon_to_amdgpu.sh
```
reinicie
execute o script novamente, se estiver com o drive amdgpu ativo, aparecerá a mensagem na tela
 "O driver amdgpu já está ativo"
remova o script do computador com o comando:
```
rm -r radeon_to_amdgpu
```



