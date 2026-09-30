// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/os;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? "https://api.xero.com/appstore/2.0/subscriptions" : "http://localhost:9090";
final string subscriptionId = isLiveServer ? os:getEnv("XERO_APPSTORE_SUBSCRIPTION_ID") : "a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d";
final string subscriptionItemId = isLiveServer ? os:getEnv("XERO_APPSTORE_SUBSCRIPTION_ITEM_ID") : "2d9e4b7a-6c1f-4a83-b5d0-7e8f9a1b2c3d";

Client xeroClient = test:mock(Client);

@test:BeforeSuite
function initClient() returns error? {
    xeroClient = check new (
        {auth: {tokenUrl: isLiveServer ? "https://identity.xero.com/connect/token" : "http://localhost:9444/connect/token", clientId: isLiveServer ? os:getEnv("XERO_APPSTORE_CLIENT_ID") : "test_client", clientSecret: isLiveServer ? os:getEnv("XERO_APPSTORE_CLIENT_SECRET") : "test_secret"}, httpVersion: isLiveServer ? http:HTTP_2_0 : http:HTTP_1_1},
        serviceUrl
    );
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetSubscription() returns error? {
    Subscription response = check xeroClient->getSubscription(subscriptionId);
    test:assertEquals(response.id, subscriptionId);
    test:assertTrue(response.plans.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListUsageRecords() returns error? {
    UsageRecordsList response = check xeroClient->listUsageRecords(subscriptionId);
    test:assertTrue(response.usageRecords.length() > 0);
}

@test:Config {groups: ["mock_tests"]}
function testCreateUsageRecord() returns error? {
    if isLiveServer {
        return;
    }
    UsageRecord response = check xeroClient->createUsageRecord(subscriptionId, subscriptionItemId, {quantity: 10, timestamp: "2026-09-30T10:15:00Z"});
    test:assertEquals(response.quantity, 10);
    test:assertEquals(response.subscriptionItemId, subscriptionItemId);
}

@test:Config {groups: ["mock_tests"]}
function testUpdateUsageRecord() returns error? {
    if isLiveServer {
        return;
    }
    UsageRecord response = check xeroClient->updateUsageRecord(subscriptionId, subscriptionItemId, "e7f6a5b4-c3d2-4e1f-a0b9-8c7d6e5f4a3b", {quantity: 12});
    test:assertEquals(response.quantity, 12);
    test:assertEquals(response.usageRecordId, "e7f6a5b4-c3d2-4e1f-a0b9-8c7d6e5f4a3b");
}
