=======================================
Script : Analyse des performances serveur
Auteur : Jean Ronel
Description : Script Bash pour superviser l'état d’un serveur Linux
=======================================

# 🔍 Server Performance Analyzer

> Script Bash interactif pour surveiller les statistiques clés des performances d’un serveur Linux.

## 🎯 Objectif

Ce script permet d’analyser en temps réel :

- L’usage du CPU
- La mémoire (utilisation, libre, pourcentage)
- Le disque principal (`/dev/sda1`, `/dev/sda2`, etc.)
- Les processus les plus gourmands en ressources
- Les infos système, uptime, utilisateurs connectés
- Les tentatives de connexions échouées (via `journalctl`)

---

## 📦 Fonctionnalités

| Option | Description |
|--------|-------------|
| `1` | Affiche l’utilisation totale du **CPU** |
| `2` | Affiche l’utilisation de la **mémoire** (MB et %) |
| `3` | Affiche l’utilisation du **disque principal** |
| `4` | Top 5 processus par **CPU** |
| `5` | Top 5 processus par **mémoire** |
| `6` | Affiche les **informations système** |
| `7` | Affiche le **temps de fonctionnement** |
| `8` | Affiche les **utilisateurs connectés** |
| `9` | Affiche les **tentatives de connexions échouées (SSH)** |
| `0` | Quitte le script |

---

## ⚙️ Prérequis

- Linux (Debian, Ubuntu, CentOS…)
- Bash ≥ v4
- Accès aux commandes : `top`, `ps`, `free`, `df`, `uname`, `uptime`, `who`, `journalctl`
- Droit `sudo` pour certaines options (journalctl)

---

## 🚀 Utilisation

1. Cloner ou télécharger ce dépôt
2. Donner les droits d’exécution au script :

   ```bash
   chmod +x server-stats.sh


# EXEMPLE

---------

$ ./server-stats.sh

       Analyse des performances serveur
==============================================

1. Usage CPU
2. Usage Memory
...
