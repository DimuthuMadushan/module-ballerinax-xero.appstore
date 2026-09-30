# Examples

The `ballerinax/xero.appstore` connector provides practical examples illustrating usage in various scenarios.

| Example | Description |
|---------|-------------|
| [`metered_usage_reporting`](./metered_usage_reporting/metered_usage_reporting.md) | Find a subscription's metered item, submit a usage record for it and optionally correct the quantity. |
| [`subscription_usage_audit`](./subscription_usage_audit/subscription_usage_audit.md) | Retrieve a subscription and total the quantity of its usage records per subscription item. |

## Prerequisites

1. Follow the [setup guide](https://github.com/ballerina-platform/module-ballerinax-xero.appstore/tree/main/README.md#setup-guide) to obtain your Xero client credentials.

2. For each example, create a `Config.toml` file in the example directory with the values that example's document lists. Both need your client credentials:

    ```toml
    clientId = "<Your Xero client ID>"
    clientSecret = "<Your Xero client secret>"
    ```

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
