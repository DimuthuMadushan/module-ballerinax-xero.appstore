// Reports metered usage for a Xero App Store subscription and then corrects the recorded quantity.

import ballerina/io;
import ballerinax/xero.appstore;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string subscriptionId = ?;
configurable int usageQuantity = ?;
configurable int correctedQuantity = ?;
configurable string usageTimestamp = ?;
configurable boolean applyCorrection = false;

public function main() returns error? {
    appstore:Client appStore = check new ({
        auth: {
            clientId,
            clientSecret,
            scopes: ["marketplace.billing"]
        }
    });

    // Step 1: Look up the subscription and find its metered subscription item.
    appstore:Subscription subscription = check appStore->getSubscription(subscriptionId);
    string? meteredItemId = ();
    foreach appstore:Plan plan in subscription.plans {
        foreach appstore:SubscriptionItem item in plan.subscriptionItems {
            if item.product?.'type == "METERED" {
                meteredItemId = item.id;
            }
        }
    }
    if meteredItemId is () {
        return error("Subscription " + subscriptionId + " has no metered subscription item");
    }
    io:println("Metered subscription item: ", meteredItemId);

    // Step 2: Submit the metered usage.
    appstore:UsageRecord record1 = check appStore->createUsageRecord(subscriptionId, meteredItemId,
        {quantity: <int:Signed32>usageQuantity, timestamp: usageTimestamp});
    io:println("Created usage record ", record1.usageRecordId, " with quantity ", record1.quantity);

    // Step 3: Optionally correct the quantity that was just reported.
    if applyCorrection {
        appstore:UsageRecord record2 = check appStore->updateUsageRecord(subscriptionId, meteredItemId,
            record1.usageRecordId, {quantity: <int:Signed32>correctedQuantity});
        io:println("Updated usage record ", record2.usageRecordId, " to quantity ", record2.quantity);
    }
}
