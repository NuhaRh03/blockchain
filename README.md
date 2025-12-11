# TP Blockchain – DApp « HelloWorld » sur Ethereum

**Auteur :** Nouhaila El Rhazzaoui  
**Date :** 08/12/2025  

---

## 1. Objectif du projet

Ce TP a pour but de créer une petite application décentralisée (**DApp**) basée sur Ethereum :

- Un **smart contract HelloWorld** qui enregistre un nom sur la blockchain et permet de le modifier.
- Une **application Flutter** qui :
  - lit la valeur stockée dans le contrat,
  - envoie une transaction pour mettre à jour ce nom.

L’idée est de parcourir tout le flux :  
**écrire le contrat → le déployer en local → l’utiliser depuis une interface mobile.**

---

## 2. Structure du dépôt

```text
.
├── blockchain/      # Projet Truffle (contrats, migrations, tests)
├── flutter_app/     # Application Flutter qui interagit avec le contrat
├── README.md
└── .gitignore
blockchain/
Contient :

les contrats Solidity,

les scripts de migration,

les tests Truffle.

flutter_app/
Contient :

le code Flutter/Dart,

la logique pour charger l’ABI,

les appels aux fonctions du contrat (lecture / écriture).

3. Prérequis
Assure-toi d’avoir installé :

Node.js (version 16 ou +)

Truffle :

bash
Copy code
npm install -g truffle
Ganache (GUI ou CLI)

Flutter SDK (canal stable)

Dart SDK (inclus avec Flutter)

Un émulateur Android ou un téléphone pour lancer l’app

4. Mise en place – Environnement local
4.1. Démarrer Ganache
Lance Ganache (interface graphique ou CLI).

Crée un workspace ou utilise celui par défaut.

Note :

l’URL RPC (souvent http://127.0.0.1:7545),

la clé privée d’un compte si tu veux signer des transactions côté Flutter.

4.2. Compiler et déployer les contrats
Dans un terminal, place-toi dans le dossier blockchain/ :

bash
Copy code
cd blockchain

# 1) Installer les dépendances du projet Truffle
npm install

# 2) Compiler les contrats Solidity
truffle compile

# 3) Migrer (déployer) sur le réseau local Ganache
truffle migrate --network development

# 4) Lancer les tests (optionnel mais conseillé)
truffle test
Après truffle migrate, l’ABI et l’adresse du contrat déployé sont générées dans build/contracts/.
Ces fichiers seront utilisés par l’application Flutter pour communiquer avec le contrat.

5. Aperçu de l’intégration Flutter
Dans le dossier flutter_app/, le code Flutter va :

Charger l’ABI du contrat (copiée depuis blockchain/build/contracts/).

Utiliser l’adresse du contrat déployé sur Ganache.

Se connecter au nœud RPC :

dart
Copy code
// Exemple de configuration Web3Client en Dart
final client = Web3Client(
  'http://127.0.0.1:7545', // URL RPC Ganache
  http.Client(),
);
Appeler les fonctions exposées par le contrat, par exemple :

dart
Copy code
// Lecture de la valeur
final currentName = await helloWorldContract.readName();

// Écriture (transaction)
await helloWorldContract.setName(
  'Nouveau Nom',
  credentials, // dérivés de la clé privée d’un compte Ganache
);
Explication rapide :

readName() correspond à une fonction view ou public de lecture dans le contrat.

setName() est une fonction qui modifie l’état, donc elle nécessite une transaction signée (d’où l’utilisation des credentials).
