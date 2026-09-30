_Author_:  Dimuthu Madushan \
_Created_: 2026/09/30 \
_Updated_: 2026/09/30 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Xero App Store.
The OpenAPI specification is obtained from [wso2/api-specs](https://github.com/wso2/api-specs/blob/main/openapi/xero/appstore/19.0.0/openapi.yaml).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Change the `url` property of the servers object
- **Original**: `https://api.xero.com/appstore/2.0`
- **Updated**: `https://api.xero.com/appstore/2.0/subscriptions`
- **Reason**: Common prefix added to base URL to simplify endpoint paths.

2. Update the API Paths
- **Original**: Paths included common prefix `/subscriptions` in each endpoint.
- **Updated**: Common prefix removed from endpoints as it is now in the base URL.
- **Reason**: Simplifies API paths and avoids duplication.

3. Rename operations
- **Original**: `postUsageRecords`, `putUsageRecords` and `getUsageRecords`.
- **Updated**: `createUsageRecord`, `updateUsageRecord` and `listUsageRecords`. `getSubscription` is unchanged.
- **Reason**: Operation names avoid HTTP verbs and describe the action, and the list operation is distinct from single-item operations.

4. Rename request body schemas
- **Original**: `CreateUsageRecord` and `UpdateUsageRecord`.
- **Updated**: `CreateUsageRecordRequest` and `UpdateUsageRecordRequest`.
- **Reason**: Request body types follow the `<Verb><Object>Request` naming convention.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json -o ballerina --mode client --client-methods remote --license docs/license.txt
```

Note: The license year is hardcoded to 2026, change if necessary.
