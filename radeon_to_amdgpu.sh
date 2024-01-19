#!/usr/bin/env bash
# --------------------------------------------------------------------------------------------- #
# ---------------------------------------- CABEÇALHO ------------------------------------------ #
## AUTOR:
### 	Paulo Aleixo <contato.phaleixo@outlook.com.br>
## NOME:
###     Trocar Radeon para Amdgpu

### Verificar se o root está ativo ou se vai ser usado o sudo

echo "Por favor, digite a sua senha root:"
if [[ "$(whoami)" != "root" ]]; then
	exec sudo -- "$0" "$@"
fi

drive_video_card=$(lspci -k | grep amdgpu)
video_card=$(lspci | grep VGA)

if [[ "$drive_video_card" = *"Kernel driver in use: amdgpu"* ]]; then
   
   echo " Placa de video:"
   echo " '$video_card'"
   echo "--------------------------------------------------------------------"
   echo " O driver amdgpu já está ativo"
elif [[ "$drive_video_card" = *"Kernel driver in use: radeon"* ]]; then
   echo "--------------------------------------------------------------------"
   echo " Placa de video:"
   echo " '$video_card'"
   echo "--------------------------------------------------------------------"
   echo "Alterando drive radeon para amdgpu"
   sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="\(.*\)"/GRUB_CMDLINE_LINUX_DEFAULT="\1 radeon.cik_support=0 amdgpu.cik_support=1 radeon.si_support=0 amdgpu.si_support=1"/' /etc/default/grub
   sudo update-grub
   echo "--------------------------------------------------------------------"
   echo "Configuração do driver atualizada. Reinicie o sistema para aplicar as alterações."
   echo "--------------------------------------------------------------------"
else
   echo "Placa de video:"
   echo "'$video_card'"
   echo "--------------------------------------------------------------------"
   echo "Não foi possível alterar o driver de vídeo atual."
   
fi

