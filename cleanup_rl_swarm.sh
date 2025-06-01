#!/bin/bash
echo "Pulizia RL-Swarm iniziata: $(date)"
# Elimina optimizer states più vecchi di 2 giorni
find /home/xrdpuser/rl-swarm/runs -name "optimizer.pt" -mtime +2 -delete
# Elimina checkpoint intermedi, mantieni solo gli ultimi 2
for model_dir in /home/xrdpuser/rl-swarm/runs/*/multinode/*/; do
    if [ -d "$model_dir" ]; then
        cd "$model_dir"
        # Mantieni solo le ultime 2 directory checkpoint-*
        ls -dt checkpoint-* 2>/dev/null | tail -n +3 | xargs rm -rf 2>/dev/null
    fi
done
# Pulisci cache Node.js se diventa troppo grande
MODAL_SIZE=$(du -s /home/xrdpuser/rl-swarm/modal-login 2>/dev/null | awk '{print $1}')
if [ "$MODAL_SIZE" -gt 2097152 ]; then  # Se > 2GB
    rm -rf /home/xrdpuser/rl-swarm/modal-login/node_modules/.cache/
    echo "Cache Node.js pulita"
fi
echo "Pulizia RL-Swarm completata: $(date)"
df -h /
