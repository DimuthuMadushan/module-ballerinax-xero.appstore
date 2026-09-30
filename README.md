# Ballerina Xero Appstore connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-xero.appstore/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-xero.appstore/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-xero.appstore.svg)](https://github.com/ballerina-platform/module-ballerinax-xero.appstore/commits/main)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/xero.appstore.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%2Fxero.appstore)

## Overview

[Xero](https://www.xero.com/) is a cloud accounting platform, and the [Xero App Store](https://marketplace.xero.com/) is where partners publish apps to Xero customers. The App Store Billing API lets partners read the subscriptions customers hold for their apps through Xero App Store Subscriptions (XASS) and report metered usage against them.

> **Note:** XASS is retired. Xero stopped accepting new apps into XASS on 4 December 2025 and required partners to move their subscribers to their own billing by 30 June 2026. The API is legacy and is not an option for new integrations.

Use the Xero App Store connector only if your app already billed customers through XASS, for example to read, reconcile or finish reporting usage for those subscriptions while you migrate them. New apps should bill customers through their own billing system. It supports version `19.0.0` of the API.

## Setup guide

To use the Xero App Store connector, you need the credentials of an existing Xero app that was set up for XASS billing. Apps can no longer enroll in XASS, and a new app has no XASS subscriptions to read. Whether the endpoints still respond for a migrated app is up to Xero, so confirm with Xero developer support before you rely on them. The connector authenticates with the OAuth 2.0 client credentials grant.

### Step 1: Open your app in the Xero developer portal

1. Sign in to the [Xero developer portal](https://developer.xero.com/) with the account that owns your XASS app.

2. Open **My Apps** and select the app.

### Step 2: Get the client credentials

1. On the app's **Configuration** page, copy the **Client id**.

2. Select **Generate a secret**, then copy the **Client secret**. Xero shows it only once.

3. The connector requests the `marketplace.billing` scope from `https://identity.xero.com/connect/token`, which is its default token URL.

### Step 3: Find the subscription details

Each call needs the ID of a subscription. Xero sends it to your app when a customer subscribes, and the connector's `getSubscription` operation returns the subscription items that usage records are reported against.

## Quickstart

To use the Xero App Store connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

Import the `xero.appstore` module.

```ballerina
import ballerinax/xero.appstore;
```

### Step 2: Instantiate a new connector

1. Create a `Config.toml` file and configure the credentials obtained in the setup guide:

    ```toml
    clientId = "<Your Xero client ID>"
    clientSecret = "<Your Xero client secret>"
    ```

2. Create an `appstore:ConnectionConfig` with the client credentials and initialize the connector with it.

```ballerina
configurable string clientId = ?;
configurable string clientSecret = ?;

final appstore:Client appStore = check new ({
    auth: {
        clientId,
        clientSecret,
        scopes: ["marketplace.billing"]
    }
});
```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### Retrieve a subscription

```ballerina
public function main() returns error? {
    appstore:Subscription _ = check appStore->getSubscription("<subscription ID>");
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```

## Examples

The `Xero App Store` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-xero.appstore/tree/main/examples/), covering the following use cases:

1. [Metered usage reporting](https://github.com/ballerina-platform/module-ballerinax-xero.appstore/tree/main/examples/metered_usage_reporting) - Find a subscription's metered item, submit a usage record for it and optionally correct the quantity.
2. [Subscription usage audit](https://github.com/ballerina-platform/module-ballerinax-xero.appstore/tree/main/examples/subscription_usage_audit) - Retrieve a subscription and total the quantity of its usage records per subscription item.

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`xero.appstore` package](https://central.ballerina.io/ballerinax/xero.appstore/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
