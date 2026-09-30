// Audits the usage records submitted against a Xero App Store subscription for the current period.

import ballerina/io;
import ballerinax/xero.appstore;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string subscriptionId = ?;

public function main() returns error? {
    appstore:Client appStore = check new ({
        auth: {
            clientId,
            clientSecret,
            scopes: ["marketplace.billing"]
        }
    });

    // Step 1: Retrieve the subscription to report its status and billing period.
    appstore:Subscription subscription = check appStore->getSubscription(subscriptionId);
    io:println("Subscription ", subscription.id, " is ", subscription.status,
            ", current period ends ", subscription.currentPeriodEnd);

    // Step 2: List all usage records and total the quantity per subscription item.
    appstore:UsageRecordsList usage = check appStore->listUsageRecords(subscriptionId);
    map<int> totals = {};
    foreach appstore:UsageRecord usageRecord in usage.usageRecords {
        totals[usageRecord.subscriptionItemId] = (totals[usageRecord.subscriptionItemId] ?: 0) + usageRecord.quantity;
    }
    if totals.length() == 0 {
        io:println("No usage records found for this subscription");
    }
    foreach [string, int] [itemId, total] in totals.entries() {
        io:println("Item ", itemId, ": total quantity ", total);
    }
}
