# 🏁 ResoluteDNS

**ResoluteDNS** is a lightweight bash utility designed for Fedora users who want to eliminate DNS latency. 

By default, `systemd-resolved` often maintains a conservative cache, leading to repetitive external queries that can slow down your web experience. This script reconfigures your system to store up to **10,000 entries** and enables stale-data resubmission for maximum performance.

---

## 🚀 Key Features

* **Massive Cache Boost:** Increases `CacheSize` to **10,000** entries.
* **High-Performance Upstreams:** Configures Cloudflare (`1.1.1.1`) and Google (`8.8.8.8`) as primary DNS providers.
* **StaleResubmit Enabled:** Serves expired cache entries if upstream servers are slow or unreachable—perfect for unstable connections.
* **Safety Backup:** Automatically creates `/etc/systemd/resolved.conf.bak` before making any changes.

## 🛠 Installation & Usage

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/your-username/ResoluteDNS.git](https://github.com/your-username/ResoluteDNS.git)
   cd ResoluteDNS
