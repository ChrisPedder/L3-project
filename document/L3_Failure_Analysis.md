---
title: "L3 Certification Flight — Failure Analysis"
subtitle: "Black Brant 6\" Scale Model — Flight of 11 April 2026"
author: "Chris Pedder — TRA 27990"
date: "April 2026"
toc: true
toc-depth: 3
numbersections: true
geometry: margin=2.5cm
fontsize: 11pt
mainfont: "DejaVu Serif"
sansfont: "DejaVu Sans"
monofont: "DejaVu Sans Mono"
header-includes:
  - \usepackage{float}
  - \floatplacement{figure}{H}
  - \usepackage{booktabs}
  - \usepackage{longtable}
---

\newpage

# Flight Summary

The L3 certification flight of the Black Brant 6" scale model took place on 11 April 2026. The flight was not successful for certification purposes. The rocket sustained damage on landing due to a failure of the main parachute to fully inflate, resulting in a higher-than-nominal descent rate during the main phase and the separation of a single fin on ground impact.

The root cause of the main parachute failure was identified through analysis of onboard video footage. A secondary issue — fin flutter at motor burnout — was also observed on the footage and is documented in this report.

# Timeline of Events

| Event | Status |
|:------|:-------|
| Launch and motor burn | Nominal |
| Motor burnout / max Q | Nominal — minor fin flutter observed (see Section 4) |
| Apogee detection and drogue deployment | Nominal |
| Drogue descent | Anomalous — descent rate significantly below target (see Section 3) |
| Main deployment altitude | Nominal — separation and main deployment triggered correctly |
| Main parachute inflation | **Failed** — parachute tangled by wrapped shock cord |
| Landing | Hard landing; single fin separated from airframe |

# Primary Failure: Main Parachute Tangling

## Observation

Onboard video footage captured the entire descent sequence and proved invaluable in diagnosing the failure. The footage clearly shows the following sequence of events:

1. At apogee, the drogue parachute deployed and inflated correctly.
2. During the drogue descent phase, the rocket entered a sustained, rapid spin beneath the drogue canopy.
3. At main deployment altitude, the electronics bay separation occurred correctly and the main deployment bag was ejected.
4. As the main parachute began to inflate, the drogue-side shock cord — which had been rotating with the spinning rocket — wrapped around the main canopy.
5. The wrapped shock cord constricted the main parachute, preventing it from fully inflating.
6. The rocket descended under a partially-inflated, tangled main parachute at a significantly higher rate than the design descent rate of 4.32 m/s (14.2 ft/s).

[View onboard video — drogue descent spin and landing](https://chrispedder.github.io/L3-project/slides/videos/l3_drogue_spin_and_landing.mp4)

## Root Cause: Excessive Drogue Descent Rate Margin

The onboard flight computer recorded a drogue descent rate of approximately **58 ft/s (17.7 m/s)**. The design target for the drogue descent rate was **75–85 ft/s**, based on the need for a fast enough descent to avoid excessive drift while keeping loads within structural limits.

However, the actual descent rate of 58 ft/s was well *below* the target range. This means the 36" drogue canopy was providing significantly more drag than intended, which in turn resulted in a slow descent that allowed the rocket to develop and sustain the rotational spin observed on the footage.

For reference, the pre-flight calculated drogue descent rate was 47.2 ft/s (14.4 m/s) based on the standard drag equation:

$$v = \sqrt{\frac{2mg}{\rho \, C_D \, A}}$$

The measured 58 ft/s (17.7 m/s) is higher than the calculated 47.2 ft/s, likely due to the high altitude (lower air density) and the real-world performance of the canopy differing slightly from the assumed $C_D = 2.2$. Nevertheless, the descent was still slow enough relative to the target range to allow the spin to develop.

The slow drogue descent, combined with the harness geometry and aerodynamic asymmetries, created the conditions for the rocket to spin. As the spin developed, the drogue-side shock cord accumulated wraps, which then trapped the main parachute during inflation.

## Contributing Factor: Harness Attachment Geometry

The shock cord separation point was positioned at approximately one-third / two-thirds of the total harness length from the electronics bay. This geometry placed the drogue-side shock cord closer to the electronics bay, leaving a longer run of cord on the main side. The longer main-side cord provided more material to wrap around the main canopy during the spin.

# Secondary Observation: Fin Flutter at Max Q

## Observation

Careful review of the onboard footage revealed small but visible signs of fin flutter occurring at or very near motor burnout, corresponding to the point of maximum dynamic pressure (max Q) during the flight.

[View onboard video — launch to apogee (fin flutter visible at motor burnout)](https://chrispedder.github.io/L3-project/slides/videos/l3_launch_to_apogee.mp4)

## Correlation with Pre-Flight Analysis

This observation is consistent with the pre-flight fin flutter analysis documented in the L3 Design Document (Section 9.3). That analysis calculated a flutter boundary velocity of **284 m/s (Mach 0.85)** against a maximum flight velocity of **215 m/s (Mach 0.64)**, giving a safety factor of **1.32**.

While the safety factor of 1.32 indicates the fins were not expected to reach the full flutter boundary, the pre-flight discussion noted that the margin was "not as generous as might initially be expected from 5 mm G10 plate", owing to the low thickness ratio ($t/c = 0.012$) resulting from the long 422 mm root chord.

The observed flutter — small-amplitude oscillations that did not progress to structural failure — is consistent with the fins operating within the lower portion of the aeroelastic response curve, where aerodynamic excitation is present but below the divergence threshold. The pre-flight conservatisms (through-the-wall construction, Kevlar reinforcement, epoxy fillets) appear to have prevented the flutter from progressing, as no structural damage to the fins was observed from flutter alone.

# Damage Assessment

The hard landing under the partially-inflated main parachute resulted in the following damage:

| Component | Damage | Severity |
|:----------|:-------|:---------|
| Fin (×1) | Separated from motor tube at bonding joint | Major — requires re-bonding |
| Fin fillets (×1) | Destroyed on separated fin | Major — requires re-creation |
| Remaining fins (×2) | No visible damage | None |
| Body tube | No visible damage | None |
| Nose cone | No visible damage | None |
| Electronics bay | No visible damage; all electronics functional | None |
| Parachutes | No visible damage after untangling | None |

# Proposed Remediations

## 6.1 — Drogue Parachute: Reduce Size and Modify Harness Geometry

**Problem:** The 36" drogue canopy produced too much drag, resulting in a slow descent rate (58 ft/s vs. 75–85 ft/s target) that allowed the rocket to develop a sustained spin.

**Remediation 1 — Reduce drogue size to 24":**

Replace the 36" Fruity Chutes Iris Ultra drogue with a **24"** canopy. The expected descent rate with a 24" drogue ($C_D = 2.2$, canopy area $A = \pi (0.305)^2 = 0.292$ m²) is:

$$v = \sqrt{\frac{2 \times 17.25 \times 9.81}{1.131 \times 2.2 \times 0.292}} = 21.6 \text{ m/s (70.9 ft/s)}$$

This brings the descent rate much closer to the 75–85 ft/s target range, reducing the time available for spin to develop and increasing the aerodynamic damping of any rotational motion.

**Remediation 2 — Move harness attachment point:**

Relocate the shock cord separation point from the current one-third / two-thirds split to approximately **one-quarter / three-quarters**, moving the attachment closer to the electronics bay. This achieves two things:

1. Shortens the drogue-side shock cord run, reducing the amount of cord available to wrap around the main.
2. Positions the main parachute further from the drogue attachment, giving it more clearance during inflation.

## 6.2 — Fin Flutter: Carbon Fibre Airfoil Fairings

**Problem:** Minor fin flutter was observed at max Q, confirming the pre-flight analysis that the safety factor of 1.32 is marginal for the flat 5 mm G10 fin profile.

**Remediation — 3D-printed diamond airfoil fairings with composite overlay:**

The flat G10 fins will be converted to a diamond airfoil cross-section by adding shaped fairings. The construction will be:

1. **Core:** 3D-printed ABS fairings, shaped to give the fins the correct diamond airfoil profile.
2. **Bonding:** Fairings attached to the flat 5 mm G10 fins using fibreglass layup.
3. **Structural overlay:** Two layers of 210 g/m² carbon fibre over the entire fin surface.
4. **Outer layer:** One layer of 100 g/m² fibreglass over the carbon fibre (for UV protection and to provide a paintable surface).

This remediation addresses the flutter issue in two ways:

- **Aerodynamic:** The diamond airfoil profile reduces the aerodynamic excitation forces compared to a flat plate, as the flow separates more cleanly from a profiled section.
- **Structural:** The carbon fibre overlay significantly increases the torsional and bending stiffness of the fins, raising the flutter boundary velocity.

**Additional benefit — centre of gravity shift:**

The added mass of the fairings and composite layup on the fins shifts the centre of gravity aft, towards the tail. This reduces the static margin (distance between CG and CP), addressing the overstable nature of the current model. A less overstable rocket is more responsive to wind and produces a straighter flight path, reducing weathercocking.

## 6.3 — Fin Repair

**Problem:** One fin separated from the motor tube on landing impact.

**Remediation:**

1. **Re-bonding:** The separated fin will be re-bonded to the motor tube using **Proline 4500** epoxy, matching the original construction method.
2. **Fillet reconstruction:** Internal and external fillets will be re-created at the fin root joint, matching the original fillet dimensions and construction (Proline 4500 with Kevlar reinforcement internally, West Systems with silica externally).
3. **Airfoil treatment:** After repair, this fin will receive the same diamond airfoil fairing and carbon fibre overlay treatment as the other two fins (see Section 6.2).
4. **Refinishing:** All three fins will be repainted to match after the composite overlay is complete.

# Summary of Actions

| # | Action | Component | Status |
|:--|:-------|:----------|:-------|
| 1 | Replace 36" drogue with 24" drogue | Recovery | Planned |
| 2 | Move harness attachment to 1/4–3/4 split | Recovery | Planned |
| 3 | Re-bond separated fin with Proline 4500 | Booster | Planned |
| 4 | Reconstruct fin root fillets | Booster | Planned |
| 5 | 3D print ABS diamond airfoil fairings | Booster | Planned |
| 6 | Bond fairings to G10 fins with fibreglass | Booster | Planned |
| 7 | Apply 2× 210 g/m² carbon fibre overlay | Booster | Planned |
| 8 | Apply 1× 100 g/m² fibreglass outer layer | Booster | Planned |
| 9 | Repaint all fins | Booster | Planned |

\newpage

# Appendix: Onboard Video References

The following onboard video clips are referenced in this report:

| Reference | Description | Link |
|:----------|:------------|:-----|
| Video 1 | Launch to apogee — fin flutter visible at motor burnout | [View](https://chrispedder.github.io/L3-project/slides/videos/l3_launch_to_apogee.mp4) |
| Video 2 | Drogue descent spin and landing — shows sustained rotation and main parachute tangling | [View](https://chrispedder.github.io/L3-project/slides/videos/l3_drogue_spin_and_landing.mp4) |
