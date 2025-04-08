#!/bin/bash

TOP_COUNT=5

print_funct(){
    echo ""
    echo "=============== $1 ==============="
    echo ""
}

# 1. Total CPU usage
display_cpu(){
    print_funct "CPU Usage"
    cpu_idle=$(top -b -n1 | grep "Cpu(s)" | awk '{print $8}' | cut -d"," -f1)
    cpu_usage=$(echo "scale=1; 100 - $cpu_idle" | bc)
    echo "Utilisation totale du CPU : $cpu_usage %"
}

# 2. Total memory usage (Free vs Used including percentage)
display_memory(){
    print_funct "Memory Usage"
    total=$(free -m | awk '/Mem:/ {print $2}')
    used=$(free -m | awk '/Mem:/ {print $3}')
    free_mem=$(free -m | awk '/Mem:/ {print $4}')
    used_percent=$(echo "scale=1; $used*100/$total" | bc)
    echo "Total : ${total}MB"
    echo "Utilisé : ${used}MB (${used_percent}%)"
    echo "Libre : ${free_mem}MB"
}

# 3. Total disk usage (Free vs Used including percentage)
display_disk(){
    print_funct "Utilisation Disque"
    df_output=$(df -h / | grep '^/dev/')
    total=$(echo $df_output | awk '{print $2}')
    used=$(echo $df_output | awk '{print $3}')
    avail=$(echo $df_output | awk '{print $4}')
    percent=$(echo $df_output | awk '{print $5}')
    echo "Total : $total"
    echo "Utilisé : $used ($percent)"
    echo "Libre : $avail"
}

# 4. Top 5 processes by CPU usage
display_top_cpu(){
    print_funct "Top $TOP_COUNT processus par CPU"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n $((TOP_COUNT + 1))
}

# 5. Top 5 processes by memory usage
display_top_mem(){
    print_funct "Top $TOP_COUNT processus par Mémoire"
    ps -e --format pid,comm,%mem --sort=-%mem | head -n $((TOP_COUNT + 1))
}

# 6. Informations système
display_os_info(){
    print_funct "Informations système"
    uname -srm
}

display_uptime(){
    print_funct "Temps de fonctionnement"
    uptime -p
}

display_users(){
    print_funct "Utilisateurs connectés"
    who | wc -l
}

display_failed_logins(){
    print_funct "Connexions échouées (SSH)"
    if command -v journalctl > /dev/null 2>&1; then
        sudo journalctl -u ssh --since today | grep "Failed password" | tail -n 5
    else
        echo "journalctl non disponible"
    fi
}

display_menu(){
    echo ""
    echo "       Analyse des performances serveur"
    echo "=============================================="
    echo ""
    echo "1. Usage CPU"
    echo "2. Usage Memory"
    echo "3. Usage Disk"
    echo "4. Top 5 processus par CPU"
    echo "5. Top 5 processus par mémoire"
    echo "6. Informations système"
    echo "7. Temps de fonctionnement"
    echo "8. Utilisateurs connectés"
    echo "9. Tentatives de connexion échouées"
    echo "0. Quitter"
    echo ""
}

main(){
    while true; do
        clear
        display_menu
        read -p "Choisissez une option : " choix

        case $choix in
            1) display_cpu ;;
            2) display_memory ;;
            3) display_disk ;;
            4) display_top_cpu ;;
            5) display_top_mem ;;
            6) display_os_info ;;  # erreur corrigée ici
            7) display_uptime ;;
            8) display_users ;;
            9) display_failed_logins ;;
            0) 
                echo "Fin de l'analyse. À bientôt !"
                break
                ;;
            *) echo "Option invalide. Veuillez choisir un nombre entre 0 et 9." ;;
        esac

        echo ""
        read -p "Appuyez sur Entrée pour continuer... "
        
    done
}

main
