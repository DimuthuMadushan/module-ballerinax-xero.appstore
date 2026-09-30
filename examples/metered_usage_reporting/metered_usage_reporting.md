# Metered usage reporting

This example finds the metered subscription item of a Xero App Store subscription, submits a usage record for it, and optionally corrects the quantity that was just reported.

It demonstrates:

1. Reading a subscription with `getSubscription` and walking its plans to find the item whose product type is `METERED`.
2. Submitting usage for that item with `createUsageRecord`.
3. Correcting the recorded quantity with `updateUsageRecord`, only when `applyCorrection` is `true`.

The example fails with an error if the subscription has no metered item.

## Prerequisites

1. Follow the [setup guide](https://github.com/ballerina-platform/module-ballerinax-xero.appstore/tree/main/README.md#setup-guide) to obtain your Xero client credentials.

2. Create a `Config.toml` file in this directory:

    ```toml
    clientId = "<Your Xero client ID>"
    clientSecret = "<Your Xero client secret>"
    subscriptionId = "<ID of a subscription with a metered item>"
    usageQuantity = 10
    correctedQuantity = 12
    usageTimestamp = "<UTC time the product was used, e.g. 2026-09-30T10:15:00Z>"
    applyCorrection = false
    ```

## Run the example

The example depends on the `ballerinax/xero.appstore` version in this repository through the local repository. Pack the connector and push it there first:

```bash
cd ../../ballerina
bal pack && bal push --repository=local
cd ../examples/metered_usage_reporting
```

Then execute the following command to run the example:

```bash
bal run
```
