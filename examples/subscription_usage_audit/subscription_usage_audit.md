# Subscription usage audit

This example retrieves a Xero App Store subscription, lists all usage records submitted against it, and prints the total quantity reported for each subscription item.

It demonstrates:

1. Reading the subscription status and current billing period end with `getSubscription`.
2. Listing the usage records of the subscription with `listUsageRecords`.
3. Totalling the quantities per subscription item to check what will be billed.

## Prerequisites

1. Follow the [setup guide](https://github.com/ballerina-platform/module-ballerinax-xero.appstore/tree/main/README.md#setup-guide) to obtain your Xero client credentials.

2. Create a `Config.toml` file in this directory:

    ```toml
    clientId = "<Your Xero client ID>"
    clientSecret = "<Your Xero client secret>"
    subscriptionId = "<ID of the subscription to audit>"
    ```

## Run the example

The example depends on the `ballerinax/xero.appstore` version in this repository through the local repository. Pack the connector and push it there first:

```bash
cd ../../ballerina
bal pack && bal push --repository=local
cd ../examples/subscription_usage_audit
```

Then execute the following command to run the example:

```bash
bal run
```
