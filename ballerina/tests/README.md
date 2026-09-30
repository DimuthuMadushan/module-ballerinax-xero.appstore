# Running Tests

## Prerequisites

The tests run against a local mock service by default, so no credentials are needed. To run them against the live Xero App Store API, set the following environment variables:

```bash
export IS_LIVE_SERVER=true
export XERO_APPSTORE_CLIENT_ID=<Your Xero client ID>
export XERO_APPSTORE_CLIENT_SECRET=<Your Xero client secret>
export XERO_APPSTORE_SUBSCRIPTION_ID=<ID of a subscription with at least one usage record>
export XERO_APPSTORE_SUBSCRIPTION_ITEM_ID=<ID of a metered subscription item>
```

## Test groups

* `mock_tests` - all four operations against the mock service in `mock_service.bal`. A second mock service in `sts_service.bal` answers the OAuth 2.0 token request on port 9444.
* `live_tests` - the read-only operations (`getSubscription` and `listUsageRecords`). Operations that create or change usage records run only against the mock, so live runs never alter billing data.

## Running the tests

```bash
bal test
```

To run a single group:

```bash
bal test --groups mock_tests
```
