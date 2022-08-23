# Enrich-SigninIncidents

This playbook is intended to provide the analyst with enough information on a given sign-in-related incident without having to leave the main/front page of sentinel.

This playbook adds the following tags:

- Device trust type (AD joined/none)
- Name of the application DeviceDetail.DisplayName
- Signin Code (Status.errorCode)


This playbook comments the following tables:

- Basic information
- Conditional Access policies present on the tenant
- Details on the device where the signin originated
- Status

## Prerequisites

None

