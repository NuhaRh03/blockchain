# blockchain

**TP — Blockchain & DApp (HelloWorld)**  
Auteur: nouhaila el rhazzaoui  
Date: 08/12/2025

## Description
Application décentralisée (DApp) simple: un contrat Ethereum `HelloWorld` qui stocke un nom, un frontend Flutter qui affiche le nom et permet de le modifier via une transaction.

## Structure du dépôt
- `blockchain/` : code Truffle (Smart contract, migrations, tests).
- `flutter_app/` : application Flutter qui consomme l'ABI et interagit avec le contrat.
- `README.md`, `.gitignore`.

## Prérequis
- Node.js (v16+)
- Truffle (`npm i -g truffle`)
- Ganache (GUI) ou Ganache CLI
- Flutter SDK (stable)
- Dart SDK (via Flutter)
- Un émulateur Android ou un appareil

## Étapes rapides (développement local)

### 1. Lancer Ganache
1. Ouvre Ganache (GUI).  
2. Note l'URL RPC (par défaut `http://127.0.0.1:7545`) et la clé privée d'un compte.

### 2. Compiler & migrer les contrats
Ouvre un terminal dans `blockchain/` :
```bash
npm install
truffle compile
truffle migrate --network development
truffle test
