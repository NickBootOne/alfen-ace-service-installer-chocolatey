# Alfen ACE Service Installer (Chocolatey Package)

[![Chocolatey](https://img.shields.io/chocolatey/v/alfen-ace-service-installer.svg)](https://community.chocolatey.org/packages/alfen-ace-service-installer)

This repository contains the Chocolatey package for installing the **Alfen ACE Service Installer** on Windows systems.

---

## 📘 About ACE Service Installer

ACE Service Installer is an official tool from **Alfen N.V.** used by installers and service engineers to configure, commission, and troubleshoot Alfen EV charging stations (NG platform).

This package automates the installation of the vendor-provided MSI using Chocolatey.

**Vendor page:**  
https://knowledge.alfen.com/space/IN/1627488257/Download+the+ACE+Service+Installer

---

## 🚀 Installation

Install from the Chocolatey Community Repository:

```powershell
choco install alfen-ace-service-installer -y
```

---

## 🔄 Upgrade

```powershell
choco upgrade alfen-ace-service-installer -y
```

---

## ❌ Uninstall

```powershell
choco uninstall alfen-ace-service-installer -y
```

---

## ⚙️ Package Behavior

- Downloads the official vendor MSI
- Installs silently using:

```powershell
msiexec /i installer.msi /qn /norestart
```

- Verifies the download using SHA256 checksum
- Uninstalls silently using:

```powershell
msiexec /x {ProductCode} /qn /norestart
```

---

## 🔐 Notes

- This package installs the official vendor-provided MSI.
- Access to the software may require Alfen credentials depending on your environment.
- This repository contains only the Chocolatey packaging scripts, not the software itself.
- This package is not officially affiliated with Alfen N.V.

---

## 🏷 Package Information

| Property | Value |
|----------|--------|
| Package ID | `alfen-ace-service-installer` |
| Maintainer | `nickboot` |
| Vendor | Alfen N.V. |
| Platform | Windows |
| Installer Type | MSI |

---

## 🛠 Development

Build the package locally:

```powershell
choco pack
```

Test locally:

```powershell
choco install alfen-ace-service-installer --source .
```

---

## 📄 Disclaimer

This Chocolatey package is maintained independently and is not officially affiliated with Alfen N.V.  
All trademarks and copyrights belong to their respective owners.
