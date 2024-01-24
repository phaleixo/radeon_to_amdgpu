#!/usr/bin/env bash

# Autor: Paulo Aleixo <contato.phaleixo@outlook.com.br>
# Este script verifica e, se necessário, altera o driver de vídeo para placas AMD em distribuições baseadas no Debian. Certifique-se de entender as alterações antes de prosseguir.

# Função para exibir mensagens informativas
function informar {
    # Códigos ANSI para cores
    verde='\033[0;32m'
    vermelho='\033[0;31m'
    reset='\033[0m'
    
    # Determinar a cor com base no segundo argumento
    cor=$verde
    [[ "$2" == "erro" ]] && cor=$vermelho
    
    echo -e "${cor}===================================================================${reset}"
    echo -e "${cor}$1${reset}"
    echo -e "${cor}===================================================================${reset}"
}

# Mensagem inicial
echo -e "\n       ############################################################"
echo -e "       # Trocar Radeon para Amdgpu em distros baseadas no Debian. #"
echo -e "       ############################################################ \n"
echo "Para mais informações, acesse o link do projeto:"
echo "https://github.com/phaleixo/radeon_to_amdgpu"

# Confirmar a execução do script
read -p "Deseja prosseguir? (y/n): " resposta
[[ "$resposta" != "y" ]] && informar "Operação cancelada pelo usuário." && exit 0

# Verificar se é adm
sudo -v || (informar "O sudo pode não estar instalado ou o usuário pode não ter permissões sudo." "erro" && exit 1)

# Verificar o driver de vídeo
drive_video_card=$(lspci -k | grep amdgpu)
video_card=$(lspci | grep VGA)

if [[ "$drive_video_card" == *"Kernel driver in use: amdgpu"* ]]; then
    # Driver amdgpu já está ativo
    informar "Placa de vídeo: '$video_card'\n----------------------------------------------------------------" "sucesso"
    informar "O driver amdgpu já está ativo. Nenhuma ação necessária." "sucesso"
elif [[ "$drive_video_card" == *"Kernel driver in use: radeon"* ]]; then
    # Alterar de radeon para amdgpu
    informar "Placa de vídeo: '${verde}$video_card${reset}'\n----------------------------------------------------------------" "sucesso"
    informar "Alterando driver radeon para amdgpu..."
    sed_command='s/GRUB_CMDLINE_LINUX_DEFAULT="\(.*\)"/GRUB_CMDLINE_LINUX_DEFAULT="\1 radeon.cik_support=0 amdgpu.cik_support=1 radeon.si_support=0 amdgpu.si_support=1"/'

    if sudo sed -i "$sed_command" /etc/default/grub && sudo update-grub; then
        informar "Configuração do driver atualizada com sucesso. Reinicie o sistema para aplicar as alterações." "sucesso"
    else
        informar "Erro ao atualizar o GRUB ou ao alterar o driver. Por favor, reinicie o sistema manualmente após corrigir o problema." "erro"
    fi
else
    # Nenhum driver AMDGPU ou Radeon detectado
    informar "Placa de vídeo: '${vermelho}$video_card${reset}'" "erro"
    informar "Não foi possível detectar o driver de vídeo AMDGPU ou Radeon no sistema." "erro"
fi
