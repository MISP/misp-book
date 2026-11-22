# CLD\-042 \| Azure role assignment on ledgerarchive

**Status DRAFT**

Briefing fingerprint **sha256:668b8f5da3c1c53434fa174d3e57ebd201202104b039c0a2e343c36e8102563e**

## Release checks

- The Event Report has no analyst approval for this briefing version\.

MISP event UUID 1f7d3464-85e6-5810-9571-d0bd09a7b80a

Event Report UUID 95006cda-7921-55fb-8ae2-7b98085bf73e

## Event Report

For the cloud incident lead · 20 November 2026 · Exercise, internal distribution · Assessment at 10:00 UTC\.

Finding\. [J1](#j1) Whether the grant was approved and whether anyone read blobs remain open\.

Scope\. The case covers selected Azure Portal sign\-in and Resource Manager records from 09:00 to 09:30 UTC in tenant d78a81b2\-00b7\-4e59\-8e68\-178c4a9c3410 and subscription 74097513\-65cf\-4ee6\-84cb\-7d485f31e831\. All times below are UTC\.

09:14:11\. Entra recorded a successful interactive sign\-in by alex@tenant\.example from 192\.0\.2\.41\. Entra record 1 [S1](#s1)\.

09:16:03\. Azure recorded the start of a role assignment write\. The caller object ID matches the Entra user ID\. The request names a different principal as recipient\. Activity record 1 [S2](#s2)\.

09:16:05\. Azure recorded Succeeded / Created for the same operation\. The response names service principal 6ab25386\-9a59\-465d\-998f\-9db68ef01272, the Storage Blob Data Reader role and the ledgerarchive account in rg\-ledger\. Activity record 2 [S3](#s3)\.

Attribution\. The records identify a directory account\. The evidence cannot identify the person controlling the session or prove that this particular sign\-in supplied the token for the write\.

Disposition\. The cloud IAM team should verify the assignment and approval with the resource owner\. The storage team should preserve and examine blob read logs from the grant onward and record coverage\. Containment and data impact are pending\.

Evidence E1\. entra\-signins\.json, Graph value\[0\], SHA\-256 7a1908b3bf28713d753b684e88151ce770a51f31c21df408fcbf63151e4d7208\. [S4](#s4)

Evidence E2\. azure\-activity\.json, Resource Manager value\[0\] and value\[1\], SHA\-256 d6ab8e23d24d7dc8c9ec8a3df9b2c2aaaada55d3cad590503ed9cea843c90fd7\. [S5](#s5)

## Key judgments

### J1

Blob read access was granted — Azure created a Storage Blob Data Reader assignment for service principal 6ab25386\-9a59\-465d\-998f\-9db68ef01272 on the ledgerarchive storage account\.
- MISP judgment UUID 031639b1-f1c9-5ffa-96d0-07c2391bf632
- Confidence **high**
- Confidence rationale — The closing Azure record reports Succeeded and Created\. Its response identifies the recipient, role and scope and matches the opening request\.
- Supporting evidence — [S2](#s2), [S3](#s3)
- Alternative — A sanctioned inventory job could explain the grant\. The exports contain no change approval or blob access records\. Whether the change was authorized or the recipient used it remains open\.

## Sources

### S1

- MISP Object — microsoft\-audit\-event
- UUID 400b45f4-1f64-5ecf-9d38-d6923abd0fff

### S2

- MISP Object — azure\-activity\-log\-event
- UUID b5012152-c35b-5e91-b2e9-75b2a1526e0d

### S3

- MISP Object — azure\-activity\-log\-event
- UUID e143c2a7-89a2-5630-9061-f6b49adde6ad

### S4

- MISP Object — file
- UUID 68852750-858f-54f2-bf75-0e82410855bd

### S5

- MISP Object — file
- UUID 825f048f-e249-52ac-89b5-95de3dac9e1c
