# EvictionVault Refactor & Security Mitigation

## Overview

This repository contains a **refactored and secured version of the EvictionVault smart contract system**.  
The original implementation existed as a **single-file monolithic contract**, which made auditing, testing, and maintenance difficult and also exposed several **critical security vulnerabilities**.

The objective of this refactor was to:

- Break the monolithic contract into a **modular architecture**
- **Mitigate critical security vulnerabilities**
- Ensure the contracts **compile cleanly using Foundry**
- Implement **basic positive tests**
- Produce a maintainable structure suitable for future audits and upgrades

---

# Project Architecture

The contract system has been decomposed into multiple modules based on responsibility.

### Module Responsibilities

| Module | Responsibility |
|------|------|
| **EvictionVault.sol** | Main vault logic including deposits, withdrawals and claims |
| **Ownership.sol** | Owner management and access control |
| **EmergencyControls.sol** | Pause mechanism and emergency withdrawals |
| **MerkleClaims.sol** | Merkle-based claim verification logic |
| **IEvictionVault.sol** | Interface definitions |

This modular structure improves:

- **Security**
- **Code readability**
- **Maintainability**
- **Auditability**

---

# Critical Security Vulnerabilities & Fixes

The following critical vulnerabilities were identified and mitigated.

---

## 1. `setMerkleRoot` Callable by Anyone

### Vulnerability

The Merkle root controlling claim eligibility could previously be updated by **any address**, allowing malicious actors to manipulate the claim tree.

### Fix

The function is now restricted to the contract owner.
## 2. emergencyWithdrawAll


