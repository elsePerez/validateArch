# natds-commons

A monorepo containing Natura Design System multiplatform packages.

[![Build Status](https://app.bitrise.io/app/31fba7fef7b852a0/status.svg?token=cq37m7wlp8mfWe2kfQ2u-w&branch=main)](https://app.bitrise.io/app/31fba7fef7b852a0) [![codecov](https://codecov.io/gh/natura-cosmeticos/natds-commons/branch/main/graph/badge.svg)](https://codecov.io/gh/natura-cosmeticos/natds-commons) ![GitHub issues](https://img.shields.io/github/issues/natura-cosmeticos/natds-commons) ![GitHub](https://img.shields.io/github/license/natura-cosmeticos/natds-commons) [![lerna](https://img.shields.io/badge/maintained%20with-lerna-cc00ff.svg)](https://lerna.js.org/)


___

## Getting started

Make sure you have `node` and `yarn` installed

## Instalation

At the root directory run `yarn install`

___

## Commands available to all packages

The commands bellow can be run by:

```bash
yarn <command>
```

`test`: runs packages tests

`test:watch`: runs packages tests and watch for changes

`lint`: runs eslint using the `@naturacosmeticos/eslint-config-natura` rules

`commit`: opens an interactive GUI to help you write commits in compliance with `conventional commits`

`build`: run packages build task

`release`: analize commits, bump packages and make the apropriate releases

`prerelease`: analize commits, bump packages and make the apropriate pre-releases

`start`: runs packages `start` task, generally used to open a browser visualization

___

## Adding new packages

#### Create a new package

create a new folder inside the `packages` folder and run

```bash
yarn init
```

and fill the package information.

#### Create the package scripts

After that, create in the package's `package.json` file the above scripts.

This enable us to run all packages commands from the root folder.

#### Register the new package

Add the created package in the root `package.json` workspaces array

```json
{
"workspaces": [
    "packages/natds-themes",
    "packages/<your-new-package>"
  ]
}
```

#### Adding dependencies to a package

from the root folder

```shell
npx lerna add <package-I-want-to-add> --scope @naturacosmeticos/<my-package> -D
```

#### Adding shared dependencies to all packages

from the root folder (devDependencies only. if it is a **dependency**, it should be added and listed in the packages `package.json` with the above command)

```shell
yarn add <package-I-want-to-add> -D -W
```

#### Start hacking!

___

## Commiting

We are using the `conventional commits` guidelines to automate our versioning and changelog criation process.

You can read more about [here](https://www.conventionalcommits.org/en/v1.0.0/).

If you are unsure about how to follow the commit guidelines, we have an interective guide to help you with this. See the `commit` command above.

> All the commits have to contain an issue number starting with `DSY-`. If you are having trouble commiting (reference error) you probably forgot that! Using the `commit` command, you can include this information on the long description field
