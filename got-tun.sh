#!/bin/bash
# ====================================================
# GOT TUNNEL - Azumi TCP Tunnel Manager (ASCII + Color)
# ====================================================

set -e

# -----------------------------
# Color Definitions
# -----------------------------
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
MAGENTA="\e[35m"
BOLD="\e[1m"
RESET="\e[0m"

# -----------------------------
# Function: Display Banner
# -----------------------------
show_banner() {
    clear
    echo -e "${BOLD}${MAGENTA}"
    echo " ________  ________  _________        _________  ___  ___  ________   ________   _______   ___          "
    echo "|\   ____\|\   __  \|\___   ___\     |\___   ___\\  \|\  \|\   ___  \|\   ___  \|\  ___ \ |\  \         "
    echo "\ \  \___|\ \  \|\  \|___ \  \_|     \|___ \  \_\ \  \\\  \ \  \\ \  \ \  \\ \  \ \   __/|\ \  \        "
    echo " \ \  \  __\ \  \\\  \   \ \  \           \ \  \ \ \  \\\  \ \  \\ \  \ \  \\ \  \ \  \_|/_\ \  \       "
    echo "  \ \  \|\  \ \  \\\  \   \ \  \           \ \  \ \ \  \\\  \ \  \\ \  \ \  \\ \  \ \  \_|\ \ \  \____  "
    echo "   \ \_______\ \_______\   \ \__\           \ \__\ \ \_______\ \__\\ \__\ \__\\ \__\ \_______\ \_______\ "
    echo "    \|_______|\|_______|    \|__|            \|__|  \|_______|\|__| \|__|\|__| \|__|\|_______|\|_______|"
    echo -e "${RESET}"
    echo -e "\e[1;32mTelegram:@mzydev | YouTube: youtube.com/@sixtininelearn\e[0m"
    echo -e "${BOLD}${MAGENTA}====================================================${RESET}"
}

# -----------------------------
# Function: Install Iran Server
# -----------------------------
install_iran() {
    echo -e "${CYAN}🌐 Setting up Iran server...${RESET}"
    apt update -y
    apt install wget unzip -y
    wget -O /root/amd64.zip https://github.com/Azumi67/PortforwardSec/releases/download/v1.0.1/amd64.zip
    unzip -o /root/amd64.zip -d /root/portforward
    cd /root/portforward
    chmod +x azuminodelay_amd64 azumi4_amd64 azumi6_amd64
    ./azumi6_amd64 --install

    read -p "🌐 Enter your Iran server IP: " IRAN_IP
    read -p "🌍 Enter your foreign server IP: " FOREIGN_IP
    read -p "🛡 Enter TCP ports (space-separated, e.g. 5051 5052 5053): " PORTS

    if [ -z "$PORTS" ]; then
        echo -e "${RED}❌ No ports entered. Exiting.${RESET}"
        return
    fi

    # Performance tuning
    ulimit -n 1048576
    sysctl -w net.core.rmem_max=67108864
    sysctl -w net.core.wmem_max=67108864
    sysctl -w net.ipv4.tcp_rmem="4096 87380 67108864"
    sysctl -w net.ipv4.tcp_wmem="4096 65536 67108864"
    sysctl -w net.core.netdev_max_backlog=300000

    BUFFER_SIZE=65535
    for PORT in $PORTS; do
        SERVICE_FILE="/etc/systemd/system/azumi_${PORT}.service"
        cat > $SERVICE_FILE <<EOF
[Unit]
Description=Azumi TCP Tunnel Port $PORT
After=network.target

[Service]
Type=simple
Restart=always
RestartSec=5s
LimitNOFILE=1048576
ExecStart=/root/portforward/azuminodelay_amd64 $IRAN_IP $PORT $FOREIGN_IP $PORT tcp true $BUFFER_SIZE

[Install]
WantedBy=multi-user.target
EOF
        chmod u+x $SERVICE_FILE
        systemctl daemon-reload
        systemctl enable azumi_${PORT}.service
        systemctl restart azumi_${PORT}.service
        echo -e "${GREEN}✅ azumi_${PORT}.service created and started!${RESET}"
    done

    echo -e "${MAGENTA}🎯 All TCP tunnels are active:${RESET}"
    for PORT in $PORTS; do
        echo -e "${GREEN}🟢 $IRAN_IP:$PORT → $FOREIGN_IP:$PORT (TCP)${RESET}"
    done
}

# -----------------------------
# Function: Install Foreign Server
# -----------------------------
install_kharej() {
    echo -e "${CYAN}🌍 Setting up foreign server...${RESET}"
    apt update -y
    apt install wget unzip -y
    wget -O /root/amd64.zip https://github.com/Azumi67/PortforwardSec/releases/download/v1.0.1/amd64.zip
    unzip -o /root/amd64.zip -d /root/portforward
    cd /root/portforward
    chmod +x azuminodelay_amd64 azumi4_amd64 azumi6_amd64
    ./azumi6_amd64 --install
    echo -e "${GREEN}✅ Installation completed successfully!${RESET}"
    echo -e "${YELLOW}📁 Binaries are located in: /root/portforward${RESET}"
}

# -----------------------------
# Function: Show Status
# -----------------------------
show_status() {
    echo -e "${BLUE}📊 Current Azumi services status:${RESET}"
    systemctl list-units --type=service | grep azumi || echo -e "${RED}No Azumi services found.${RESET}"
}

# -----------------------------
# Function: Uninstall All
# -----------------------------
uninstall_all() {
    echo -e "${RED}🛠 Removing all Azumi tunnels...${RESET}"
    systemctl stop azumi_*.service 2>/dev/null || true
    systemctl disable azumi_*.service 2>/dev/null || true
    rm -f /etc/systemd/system/azumi_*.service
    systemctl daemon-reload
    systemctl reset-failed
    rm -rf /root/portforward /root/amd64.zip
    if [ -f /usr/bin/azumi6_amd64 ]; then
        rm -f /usr/bin/azumi6_amd64
        echo -e "${YELLOW}🗑 Removed azumi6_amd64 from /usr/bin/${RESET}"
    fi
    journalctl --rotate
    journalctl --vacuum-time=1s >/dev/null 2>&1 || true
    echo -e "${GREEN}✅ All Azumi tunnels and files have been completely removed!${RESET}"
}

# -----------------------------
# Main Menu (ASCII + Color)
# -----------------------------
while true; do
    show_banner
    echo -e "${YELLOW}1️⃣  Iran Server Setup${RESET}"
    echo -e "${CYAN}2️⃣  Foreign Server Setup${RESET}"
    echo -e "${GREEN}3️⃣  Show Status${RESET}"
    echo -e "${RED}4️⃣  Uninstall All${RESET}"
    echo -e "${MAGENTA}5️⃣  Exit${RESET}"
    echo -e "${BOLD}${MAGENTA}====================================================${RESET}"
    read -p "Choose an option [1-5]: " choice
    case $choice in
        1) install_iran ;;
        2) install_kharej ;;
        3) show_status ;;
        4) uninstall_all ;;
        5) echo -e "${CYAN}👋 Exiting GOT TUNNEL...${RESET}"; exit 0 ;;
        *) echo -e "${RED}❌ Invalid option!${RESET}"; sleep 1 ;;
    esac
    echo -e "${BOLD}Press Enter to continue...${RESET}"
    read
done
