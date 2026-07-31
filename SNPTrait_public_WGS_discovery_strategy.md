# Finding public WGS for phenotype-rich GRIN accessions

*Method and results for the archive-discovery half of SNPTrait. All numbers from live ENA Portal, NCBI E-utilities, and EVA queries.*

---

## Result

**367 GRIN accessions with ≥15 phenotyped traits, not currently in SNPTools, already have public whole-genome sequence at >5× — 315 of them at ≥10×.** Calling them requires no new sequencing: **1,420 FASTQ files, ~15.8 TB, across 77 projects.** That roughly doubles a 435-accession panel to ~800.

A further 488 phenotyped accessions have public data at ≤5× (imputation or top-up territory), and 71 have existing genotypes in EVA but no reads anywhere.

![SNPTools cross-check and corrected partition](figures/fig5_snptools_crosscheck_correction.png)

---

## The query, and the trap in it

One ENA Portal request over the *Zea* subtree returns everything:

```
tax_tree(4577) AND library_source="GENOMIC"
  AND (library_strategy="WGS" OR "WGA" OR "WXS" OR "OTHER")
```

**41,694 runs / 32,007 samples / 2,356 studies.**

The first version of this query filtered on `library_strategy="WGS"` alone, and it was wrong. Depth by strategy label:

| library_strategy | runs | total bases |
|---|---|---|
| `WGS` | 25,132 | 315.7 Tb |
| `OTHER` | 13,313 | 29.0 Tb |
| `WXS` | 1,987 | 1.7 Tb |
| `WGA` | 1,262 | **30.9 Tb** |

`WGA` averages ~24 Gb per run — deeper than the `WGS` mean. It is whole-genome data with a different label. **`PRJNA661271`, the Maize Wisconsin Diversity Panel Resequencing Project — the single largest source of callable phenotyped accessions in the archive — is registered as `WGA`.** A `WGS`-only query drops all 458 of its runs and with them 246 accessions, 67% of the total opportunity.

**Standing recommendation: never filter maize genotype discovery on `library_strategy` alone.** Filter on `library_source="GENOMIC"`, accept the four strategy labels above, then filter on *measured* depth from `base_count`. Broadening the filter took the callable count from 177 to 457; the SNPTools cross-check then reduced it to the final 367.

`ena_maize_wgs_run_metadata.tsv` is the raw pull, refreshable in that one call.

---

## Linking archive samples to GRIN accessions

Almost no archive record cites a germplasm accession number, so the link has to be made on names.

**Normalization.** Uppercase; strip a leading `Zea mays [subsp. mays]`; drop the words `INBRED`, `LINE`, `CULTIVAR`, `MAIZE`, `ACCESSION`; remove all whitespace, hyphens, underscores, periods, and parentheses. `Zea mays inbred B73` and `B-73` both become `B73`.

**Field preference order.** `cultivar` → `strain` → `isolate` → `ecotype` → `sample_alias` → `sample_title` → `description`. The first field yielding a hit wins, and the matched field and string are both recorded.

**Risky-key rule.** A normalized key that is purely numeric, or shorter than three characters, is quarantined regardless of uniqueness — `1`, `A`, `27` match GRIN records by coincidence, not identity.

**Ambiguity rule.** A key mapping to more than one GRIN accession is quarantined. This is why `P39` is excluded: GRIN holds it as `NSL 8585`, `PI 587133`, `PI 692185`, and `PI 690333`. Resolving these duplicate records is curator work, not matcher work.

**Validation.** 335 archive samples have both a PI-derived truth link (from `combined_GRIN_accessions.tsv`) and an independent name-based prediction. **They agree 335/335 — 100%.** That is a real positive control and it is the argument for accepting the confident tier without manual review. It explicitly does **not** license accepting the quarantined tier.

**Yields.** Confident matches resolve to accessions; **343 samples land only on ambiguous or risky keys and have ≥5× coverage** — those are worth a curator's time and are in `view11`. Most remaining samples have no GRIN name hit at all, and that is correct: the largest studies among them are CUBIC, BT, MT, and NAM-derived RIL populations. Those are segregating progeny, not germplasm accessions, and they should not match.

---

## Why the SNPTools cross-check mattered

The first pass defined "already in SNPTools" from PI numbers in `SRA2accession.tsv`. But only 384 of 2,332 SNPTools names ever received a PI number, so accessions genotyped under an unlinked name looked un-genotyped. Re-matching every name in `SNPTools_accession_list.tsv` recovered **91 accessions SNPTools already holds, 90 of which were in the build queue.**

Three projects account for 49 of those: `PRJNA531553` (521 runs already in SNPTools, 36 → 8 targets), `PRJNA609577` (453 runs, 14 → 3), `PRJEB31061` (77 runs, 11 → 1). `PRJEB56320` — the correctly-labelled WiDiv subset study — drops out entirely.

The other 41 came from projects *not* in the SNPTools list at all, including 30 from WiDiv itself: the same accession is genotyped in SNPTools from a different project's reads. **Project-level exclusion is therefore not sufficient — the check must be per accession.** `view19_snptools_list_grin_crosswalk.csv` is the artifact that makes this repeatable.

---

## EVA is a secondary channel, not a build target

EVA's maize holdings are genotyping studies, not reads. The largest, `PRJEB7723` ("Biology of Rare Alleles in Maize", 17,280 samples), is the Ames GBS panel submitted as variant-call analyses. Amaizing Dent (`PRJEB40124`) and the domestication study (`PRJEB41335`) do resolve to GRIN accessions, and **71 phenotype-rich accessions there have no WGS reads anywhere** (`view12`).

Those 71 are not variant-calling targets — they are *existing genotypes you could import* at whatever marker density the study used. Useful for population structure and kinship, not for allele mining. Import them as a separate, clearly labelled marker-density tier.

---

## Build order

1. **WiDiv first** — `PRJNA661271`, 492 files, 6.4 TB, **246 accessions.** Two-thirds of the opportunity in one download, and it validates the pipeline on a panel whose phenotypes you can sanity-check against known line characteristics.
2. **The ≥10× remainder** — 315 accessions total at ≥10×, highest confidence.
3. **The 5–10× tier** (52 accessions) with depth-aware filtering; expect some to fall short of usable depth after alignment.
4. **Work the curator queue** — 343 ambiguous/risky samples with ≥5× coverage (`view11`). Each resolution is a free accession.
5. **Import the 71 EVA genotypes** as a marker-density tier.
6. **Then decide what to sequence de novo.** Steps 1–5 remove ~370 accessions from the sequencing list, which changes the answer — particularly for the 1,727 phenotyped landraces that have nothing.

---

## Caveats

- `x_cov = base_count / 2.3 Gb` is a **yield proxy**. It ignores duplication, read quality, and mapping rate; realized depth is lower. 5× is a soft floor.
- Name-based links are validated at 335/335 but are not PI-number links. Store `match_method` per link and surface it.
- The 91 recovered SNPTools accessions rest on name matching by construction — the PI control is unavailable for exactly those cases. `view20` lists them for spot-checking.
- Public maize sequence grows fast enough that this pull is worth re-running quarterly. The matcher is deterministic, so the queue refills on its own.
