## Hostal

<p align="center">
  <a href="https://adeboyej.github.io/hostal-dacade/" target="_blank"><img src="https://i.ibb.co/tQ4LQDp/hostal.png" alt="Hostal"></a>
</p>

Hostal is a student hostel testnet dApp that utilizes Celo blockchain technologies, the word Hostal is Spanish for Hostel.
### Key Features

* **HostalContract** is where the majority of the dApp functionality resides. It has the CeloUSDToken interface that performs transactions based functions. It also enables users to add Hostels and Book Hostels.

* **HostalServiceContract** is where the Hostel Agent service actions happen. 


### Usage

1. Install the [CeloExtensionWallet](https://chrome.google.com/webstore/detail/celoextensionwallet/kkilomkmpmkbdnfelcpgckmpcaemjcdh?hl=en) from the Google Chrome store.
2. Create a Wallet.
3. Go to [https://celo.org/developers/faucet](https://celo.org/developers/faucet) and get tokens for the alfajores testnet.
4. Switch to the alfajores testnet in the CeloExtensionWallet.
5. Go to the Site [Homepage](https://adeboyej.github.io/hostal-dacade/).

## Development Guide

Below is the list of available scripts for developments;

### Install

```bash
npm install
```

*Installs required node packages.*

### Development

```bash
npm run dev
```

*Runs the app in the development mode.\
Open [http://localhost:4000](http://localhost:4000) to view it in the browser.*

### Build and Start

```bash
npm run build
```

*Compiles and minifies for production.*

> The below command requires the [servez](https://www.npmjs.com/package/servez) node package. Install globally with: ```npm install servez -g```

```bash
npm run start
```

*Runs the app in production mode.\
Open [https://localhost:8080](https://localhost:8080) to view it in the browser.*

## LICENSE

```md
