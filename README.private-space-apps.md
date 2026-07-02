# Private-space priv-apps: intentionally dropped

The OOS "private-space" cluster ships three `system_ext` privileged apps that
this device tree intentionally does **not** ship. They are not part of the
camera/gallery port and were removed from the `vendor_oplus_camera` extract:

| package | stock app | why it exists on OOS |
|---|---|---|
| `com.oplus.pantanal.ums` | UMS | Pantanal "User Model Service" — smart-service/card hub host |
| `com.oplus.phonemanager` | PhoneManager | OEM phone-manager (clear/scan providers) |
| `com.oplus.exsystemservice` | OplusExSystemService | OEM extended-system service host |

## Why dropped (not allowlisted)

With `ro.control_privapp_permissions=enforce` (LineageOS userdebug), every
`system_ext` priv-app that requests a platform privileged permission **without**
a `privapp-permissions` allowlist entry turns into a
`PackageManagerService.systemReady` `IllegalStateException` — a hard bootloop.

These three apps request such permissions, but the privapp enforce gate only
fires for packages that are actually **present**. Because the private-space
cluster is not load-bearing for the camera port (the kept stack references them
only via `<queries>` package-visibility or in-apk `"stub"` replicas — no live
bind), dropping them removes the boot risk without shipping allowlist entries
for apps we no longer install. Verified on-device: camera + gallery are fully
functional with all three absent.

Full origin/consumer provenance for the six private-space apps is recorded in
the port's engineering notes (`privspace-apps-provenance.md`).

## TODO (deferred — nothing built here)

A future "better private-space" base could run the OplusCamera stack **with**
these apps replaced by lightweight provider/service stubs plus targeted
no-ops, so OplusCamera's pantanal/UMS integration hooks resolve cleanly instead
of throwing caught exceptions. This tree simply drops them; the stub-surface
blueprint lives in the provenance notes above and is a post-rebase candidate,
not part of this series.
