# AWS Disaster Recovery & Multi-Region Failover Architecture 🛡️☁️

A comprehensive, hands-on project demonstrating enterprise-grade disaster recovery (DR) and business continuity strategies on **Amazon Web Services (AWS)**. This project simulates and resolves three critical real-world failure scenarios: server crashes, data volume corruption, and catastrophic multi-region outages.

---

## 🏗️ Architecture Overview

![Architecture Diagram](./docsarchitecture.png.jfif)

---

## 🔑 Core Concepts & Metrics

* **RPO (Recovery Point Objective):** The maximum targeted duration of data (in time) that can be lost from an IT service during an unplanned incident.
* **RTO (Recovery Time Objective):** The targeted duration of time and a service level within which a business process must be restored after a disaster.
* **Failover vs. Failback:** Shifting live traffic/operations from a primary environment to a secondary DR site (Failover), and vice versa once the primary site is healthy (Failback).

---

## 🚀 Implemented Scenarios & Step-by-Step Execution

### Scenario 1: EC2 Instance Failure (Server Crash)
* **Objective:** Recover a crashed web server instantly without losing application data.
* **Implementation:**
  1. Launched an Ubuntu EC2 instance in the primary region (`ap-south-1`) and configured an Nginx web server.
  2. Created a separate 10GB **Amazon EBS volume** specifically for application data and mounted it to a custom mount point (`/production-data`).
  3. Created an **Amazon Machine Image (AMI)** template of the configured server.
  4. Terminated the EC2 instance to simulate a catastrophic hardware crash.
  5. Provisioned a new EC2 instance using the saved AMI template and re-attached the surviving data volume to instantly restore the application state.

### Scenario 2: EBS Volume Failure & Data Corruption Recovery
* **Objective:** Recover from accidental data deletion or volume corruption using point-in-time backups.
* **Implementation:**
  1. Simulated data corruption by deleting live orders data inside the application mount point.
  2. Utilized pre-configured **EBS snapshots** (backups) taken prior to the corruption event.
  3. Created a new data volume from the snapshot and attached it to the active EC2 instance, restoring the application back to its last known safe state within the acceptable RPO window.

### Scenario 3: Cross-Region Disaster Recovery (Regional Outage)
* **Objective:** Maintain business continuity during a total regional outage by failing over to a secondary AWS region.
* **Implementation:**
  1. Simulated a complete failure of the primary region (`ap-south-1`).
  2. Copied and replicated AMIs and EBS snapshots across regions to the secondary DR region (`ap-south-2` - Hyderabad).
  3. Launched a recovered EC2 instance from the replicated AMI and provisioned the data volume using the copied cross-region snapshot.
  4. Verified full application functionality and accessibility in the secondary region.

---

## 🛠️ Tech Stack & Tools

* **Cloud Provider:** Amazon Web Services (AWS)
* **Compute:** Amazon EC2 (Ubuntu 24.04 LTS, T3 Micro)
* **Storage:** Amazon EBS (Elastic Block Store), Snapshots, AMIs (Amazon Machine Images)
* **Web Server:** Nginx
* **Networking & Security:** VPC, Security Groups, Subnets (Multi-AZ / Multi-Region)
* **OS & Scripting:** Linux, Bash

---

## 📂 Repository Structure

```text
├── README.md               # Project documentation
├── scripts/                # Automation and mounting scripts
│   ├── mount_volume.sh     # Volume formatting and mounting script
│   └── backup_data.py      # Automated python backup routines
└── docs/                   # Architecture diagrams and screenshots
    └── architecture.png    # High-level DR workflow diagram
