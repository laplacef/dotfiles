# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| latest  | Yes       |

Only the latest release receives security patches.

## Reporting a Vulnerability

**Do not open a public GitHub issue for security vulnerabilities.**

To report a vulnerability, use [GitHub's private vulnerability reporting](https://github.com/laplacef/dotfiles/security/advisories/new). You can expect an initial response within 72 hours.

Please include:
- A description of the vulnerability
- Steps to reproduce the issue
- Potential impact assessment

## Scope

The following are considered security issues:
- Provisioning steps that widen privileges or weaken defaults beyond what is documented
- Insecure git, ssh, or gpg configuration that would expose keys or identity
- Fetch-and-execute steps that run unverified remote content

## Out of Scope

The following are **not** security issues:
- Vulnerabilities in the upstream tools these scripts install
- Ubuntu package or distribution vulnerabilities
- Personal preference in shell or editor configuration
