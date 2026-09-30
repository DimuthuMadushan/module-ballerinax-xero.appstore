## Overview

[Xero](https://www.xero.com/) is a cloud accounting platform, and the [Xero App Store](https://marketplace.xero.com/) is where partners publish apps to Xero customers. The App Store Billing API lets partners read the subscriptions customers hold for their apps and report metered usage so that Xero can bill for it.

The Xero App Store connector lets Ballerina applications call the App Store API from their own billing and usage pipelines. It supports version `19.0.0` of the API.

### Key features

- Retrieve a customer subscription with its plans, subscription items, products and prices
- List every usage record submitted against a subscription for the current period
- Submit metered usage for a subscription item, with optional idempotency keys for safe retries
- Correct a previously submitted usage record
- Authenticate with the OAuth 2.0 client credentials flow and the `marketplace.billing` scope

## Setup guide

To use the Xero App Store connector, you need a Xero developer account and an app that is enrolled in the Xero App Store. The connector authenticates with the OAuth 2.0 client credentials grant, which Xero issues to App Store partners.

### Step 1: Create a Xero developer account

1. Sign up for a free account on the [Xero developer portal](https://developer.xero.com/).

2. Open **My Apps** and select **New app**.

### Step 2: Get the client credentials

1. Create the app and complete its configuration. Partners who bill through the App Store must have their app listed in the Xero App Store so that it has subscriptions to read.

2. On the app's **Configuration** page, copy the **Client id**.

3. Select **Generate a secret**, then copy the **Client secret**. Xero shows it only once.

4. The connector requests the `marketplace.billing` scope from `https://identity.xero.com/connect/token`, which is its default token URL.

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

