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
    int:Signed32 quantity = check toQuantity("usageQuantity", usageQuantity);
    int:Signed32 correction = check toQuantity("correctedQuantity", correctedQuantity);

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
                if meteredItemId is string {
                    return error("Subscription " + subscriptionId + " has more than one metered subscription item");
                }
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
        {quantity, timestamp: usageTimestamp});
    io:println("Created usage record ", record1.usageRecordId, " with quantity ", record1.quantity);

    // Step 3: Optionally correct the quantity that was just reported.
    if applyCorrection {
        appstore:UsageRecord record2 = check appStore->updateUsageRecord(subscriptionId, meteredItemId,
            record1.usageRecordId, {quantity: correction});
        io:println("Updated usage record ", record2.usageRecordId, " to quantity ", record2.quantity);
    }
}

// Rejects a negative quantity or one too large for the API's 32-bit field, instead of letting the cast panic.
function toQuantity(string name, int value) returns int:Signed32|error {
    if value < 0 || value > int:SIGNED32_MAX_VALUE {
        return error(string `${name} must be between 0 and ${int:SIGNED32_MAX_VALUE}, got ${value}`);
    }
    return <int:Signed32>value;
}
