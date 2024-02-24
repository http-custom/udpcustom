#!/bin/bash

# Agrega el alias al archivo .bashrc
echo "alias udp='/root/udp.sh'" >> ~/.bashrc

# Recarga el archivo .bashrc para que el alias sea efectivo
source ~/.bashrc

# Función para mostrar el título

show_title() {

    clear

    echo "————————————————————————————————————————————————————"

    echo "  MINI INSTALADOR UDP CUSTOM (HC)  "

    echo "————————————————————————————————————————————————————"
    
    echo "  PARA ACCEDER A LA SCRIPT USE EL COMANDO udp  "

    echo "————————————————————————————————————————————————————"

    echo

}

# Función para mostrar el menú

show_menu() {

    echo "MENÚ DE OPCIONES:"

    echo "1. INSTALAR UDP CUSTOM"

    echo "2. INSTALAR BAD VPN (OPCIONAL)"
    
    echo "3. VER SERVICIOS EN EJECUCIÓN"
    
    echo "4. REINICIAR UDP CUSTOM"

    echo "5. DESINSTALAR BAD VPN Y DETENER SERVICIO"
    
    echo "6. DESINSTALAR UDP CUSTOM Y DETENER SERVICIO"

    echo "7. SALIR"

    echo "————————————————————————————————————————————————————"

}

# Función para esperar una opción válida

wait_for_option() {

    local valid_options="1 2 3 4 5 6 7"

    read -p "INGRESE UNA OPCIÓN: " option

    while [[ ! $valid_options =~ (^|[[:space:]])$option($|[[:space:]]) ]]; do

        read -p "OPCIÓN INVÁLIDA. INGRESE UNA OPCIÓN VÁLIDA: " option

    done

}

# Función para limpiar la pantalla y esperar una entrada

wait_for_enter() {

    echo
    
    read -p "PRESIONE ENTER PARA CONTINUAR..." enter

}

# Función para instalar y ejecutar udp

install_udp() {

    show_title

    echo "INSTALANDO UDP CUSTOM ESPERE..."
    
    echo "EN CASO DE NO FUNCIONAR REINICIE LA VPS"
    
    echo "SE RECOMIENDA TENER MINIMO UBUNTU 16 O SUPERIOR"
    
    echo "————————————————————————————————————————————————————"

    echo "  BINARIO SOLO FUNCIONA EN HTTP CUSTOM  "

    echo "————————————————————————————————————————————————————"

    echo

    wget https://raw.githubusercontent.com/http-custom/udpcustom/main/folder/udp-custom.sh -O install-udp && chmod +x install-udp && ./install-udp

    echo "————————————————————————————————————————————————————"

    echo "  ¡INSTALACIÓN COMPLETA!  "

    echo "————————————————————————————————————————————————————"
    
    echo

    wait_for_enter

}

# Función para instalar bad VPN 7300

install_badvpn() {

    show_title

    echo "INSTALANDO BAD VPN 7300 NO ES OBLIGATORIO"

    echo

    wget https://raw.githubusercontent.com/powermx/badvpn/master/easyinstall && bash easyinstall

    badvpn start

    wait_for_enter

}

# Función para ver servicios en ejecucion

show_services() {

    show_title

    echo "TODOS LOS SERVICIOS EN EJECUCIÓN"

    echo

    apt install net-tools
    
    netstat -tnpl

    wait_for_enter

}

# Función para mostrar el código Psiphon en formato hexadecimal

reboot_udp() {

    show_title

    echo "REINICIANDO UDP CUSTOM..."
    
    echo " "
    
    echo "¡COMPLETADO!"

    echo

    start udp-custom

    wait_for_enter

}

# Función para desinstalar badvpn
    
stop_and_remove_badvpn() {

    show_title

    echo "⚠️ DESINSTALANDO BAD VPN DETENIENDO PUERTO 7300 ⚠️"

    echo

    badvpn stop

    badvpn uninstall

    wait_for_enter

}

# Función para detener los servicios de udp y eliminar archivos

stop_and_remove_udp() {

    show_title

    echo "⚠️ UDP CUSTOM FUE DESINSTALADO. ⚠️"

    echo
    
  systemctl stop udp-custom &>/dev/null
  systemctl disable udp-custom &>/dev/null
  # systemctl stop udp-request &>/dev/null
  # systemctl disable udp-request &>/dev/null
  # systemctl stop autostart &>/dev/null
  # systemctl disable autostart &>/dev/null
  rm -rf /etc/systemd/system/udp-custom.service
  # rm -rf /etc/systemd/system/udp-request.service
  # rm -rf /etc/systemd/system/autostart.service
  rm -rf /usr/bin/udp-custom
  rm -rf /root/udp/udp-custom
  # rm -rf /root/udp/udp-request
  # rm -rf /usr/bin/udp-request
  rm -rf /root/udp/config.json
  rm -rf /etc/UDPCustom/udp-custom
  # rm -rf /usr/bin/udp-request
  # rm -rf /etc/UDPCustom/autostart.service
  # rm -rf /etc/UDPCustom/autostart
  # rm -rf /etc/autostart.service
  # rm -rf /etc/autostart
  rm -rf /usr/bin/udpgw
  rm -rf /etc/systemd/system/udpgw.service
  systemctl stop udpgw &>/dev/null
  del 1
  print_center -ama "${a34:-Uninstallation completed!}"
  rm -rf /usr/bin/udp

    echo "⚠️ SERVICIOS DE UDP CUSTOM DETENIDOS Y ARCHIVOS ELIMINADOS. ⚠️"

    wait_for_enter

}

# Función principal para mostrar el menú y procesar las opciones

main() {

    local option

    while true; do

        show_title

        show_menu

        wait_for_option

        case $option in

            1)

                install_udp


                ;;

            2)

                install_badvpn

                ;;
                
            3)

                show_services

                ;;
                
            4)

                reboot_udp

                ;;

            5)

                stop_and_remove_badvpn

                ;;

            6)

                stop_and_remove_udp

                ;;

            7)

                show_title

                echo "SALIENDO DEL INSTALADOR PSIPHON."

                echo

                exit 0

                ;;

        esac

    done

}

# Ejecutar la función principal

main
