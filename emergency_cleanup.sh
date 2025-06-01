# Aggiungi pulizia automatica ogni 6 ore
(crontab -l 2>/dev/null; echo "0 */6 * * * /home/xrdpuser/cleanup_rl_swarm.sh") | crontab -

# Script di emergenza se il disco si riempie
cat > ~/emergency_cleanup.sh << 'EOF'
#!/bin/bash
USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
if [ $USAGE -gt 90 ]; then
    echo "EMERGENZA: Disco al ${USAGE}% - pulizia aggressiva!"
    ~/cleanup_rl_swarm.sh
    # Pulizia aggressiva: elimina tutti gli optimizer
    find /home/xrdpuser/rl-swarm/runs -name "optimizer.pt" -delete
fi
EOF

chmod +x ~/emergency_cleanup.sh
(crontab -l 2>/dev/null; echo "0 * * * * /home/xrdpuser/emergency_cleanup.sh") | crontab -