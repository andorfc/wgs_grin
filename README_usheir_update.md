# SNPTrait — updated coverage tables & figure (SNPTools + public archives + USHeirloom)

This update adds a third genotyping source: **USHeirloom** — a panel of 943 GRIN accessions genotyped at ~20x whole-genome coverage by Jim Holland (`USHeir_EntryOrigins_Aug26.xlsx`), matched to GRIN passport records via the `Plant_ID_DNA_RNA` column (PI-number-dominant; 943 of 993 rows matched — see caveats below).

**Headline finding: USHeirloom is fully additive.** Zero overlap with SNPTools (464 accessions) or with existing public WGS >5x (821 accessions) — every one of the 943 USHeirloom accessions is a genuinely new genotyped resource.

|   | SNPTools | USHeirloom | PublicWGS>5x |
|---|---|---|---|
| SNPTools | 464.0 | 0.0 | 407.0 |
| USHeirloom | 0.0 | 943.0 | 0.0 |
| PublicWGS>5x | 407.0 | 0.0 | 821.0 |

### Table 1 — Public database landscape (unchanged; USHeirloom is not a public archive)

| metric | n_accessions |
|---|---|
| Total maize accessions in public databases (any name-matched WGS) | 1,417 |
| ...with public WGS >10x depth | 636 |
| ...with public WGS >5x depth | 821 |

### Table 2 — All GRIN accessions with any phenotype record (n=24,083), by genotyping-source tier

| metric | value |
|---|---|
| All GRIN accessions (any phenotype record) | 24,083 |
| ...already genotyped in SNPTools | 464 |
| ...already genotyped in USHeirloom project (20x, Jim Holland) | 943 |
| ...with public WGS >10x - variant-callable now | 336 |
| ...with public WGS 5-10x - variant-callable now | 61 |
| ...with public data <=5x - impute or top-up | 490 |
| ...no public sequence, not in SNPTools/USHeir - must be genotyped | 21,789 |
| ...priority FASTQ (files / TB) [public WGS only, callable >5x tiers] | 2,580 files / 17.6 TB |

### Table 3 — GRIN accessions with ≥15 phenotyped traits (n=10,433), by genotyping-source tier

| metric | value |
|---|---|
| GRIN accessions with >=15 phenotyped traits | 10,433 |
| ...already genotyped in SNPTools | 435 |
| ...already genotyped in USHeirloom project (20x, Jim Holland) | 795 |
| ...with public WGS >10x - variant-callable now | 315 |
| ...with public WGS 5-10x - variant-callable now | 52 |
| ...with public data <=5x - impute or top-up | 432 |
| ...no public sequence, not in SNPTools/USHeir - must be genotyped | 8,404 |
| ...priority FASTQ (files / TB) [public WGS only, callable >5x tiers] | 2,416 files / 16.4 TB |

### Table 4 — Top projects/panels by GRIN accession coverage (public bioprojects + USHeirloom)

| study_accession | already_in_snptools | already_in_usheir | genotyped_gt5x_public | needs_sequencing | total | study_title |
|---|---|---|---|---|---|---|
| USHeirloom_20x | 0 | 943 | 0 | 0 | 943 | USHeirloom Entry Origins panel (Jim Holland, 20x WGS, not yet public) |
| PRJNA661271 | 141 | 0 | 258 | 0 | 399 | Maize Wisconsin Diversity Panel Resequencing Project |
| PRJNA489924 | 158 | 0 | 180 | 50 | 388 | Genome-wide association study for cuticular evaporation rate in maize |
| PRJNA565870 | 119 | 0 | 77 | 31 | 227 | Resequencing of 775 maize inbred lines |
| PRJEB56320 | 191 | 0 | 0 | 0 | 191 | Resequencing of a subset of the maize Wisconsin Diversity Panel (Hansey et al., 2011) |
| PRJNA482446 | 13 | 18 | 9 | 144 | 166 | Maize raw sequence reads |
| PRJNA609577 | 131 | 0 | 12 | 8 | 151 | Zea mays subsp. mays Genome sequencing |
| PRJNA948871 | 82 | 0 | 52 | 12 | 146 | Zea mays Genome sequencing |
| PRJNA1170466 | 59 | 0 | 39 | 4 | 102 | Genome resequencing data of 447 maize inbred lines |
| PRJNA894503 | 1 | 0 | 0 | 94 | 95 | Evaluation of genetic diversity across inbreds used by GEM project (WGS skim sequencing) |
| PRJNA889703 | 4 | 7 | 2 | 81 | 87 | Eco-evolutionary maize microbiome |
| PRJNA684330 | 18 | 0 | 32 | 26 | 76 | Maize diversity to study rare alleles |
| PRJNA1142968 | 13 | 0 | 21 | 39 | 73 | Evaluation of genetic diversity across the inbreds used by G2F project - 2024/2025 germplasm (WGS skim sequencing) |
| PRJNA627044 | 7 | 0 | 13 | 45 | 65 | The GBS data of 365 recombinant inbred lines derived from inbreds Ye478 and Qi319 |
| PRJNA531553 | 42 | 0 | 13 | 8 | 63 | Deep DNA resequencing of the association mapping panel |

### USHeirloom matching detail

- 993 total rows in `USHeir_EntryOrigins_Aug26.xlsx` (Entries sheet)
- 943 matched to a GRIN passport accession number (94.9%)
- Unmatched (50 rows) breakdown: 35 `Heir######` heirloom-collection IDs not present in the GRIN passport extract, 12 `NSL######` IDs not found (19/31 NSL IDs did match), plus single unmatched `LH`, `T`, `B`-prefixed IDs.
- Matched-ID prefixes: PI (898/898, 100%), Ames (26/26, 100%), NSL (19/31, 61%).

**Caveats:** matching is by name/ID-normalization only (adding a space between letter prefix and digits, e.g. `PI358584`→`PI 358584`) against the GRIN passport list; unmatched `Heir`-prefixed IDs likely refer to accessions not yet assigned a standard PI/Ames/NSL number in this GRIN extract, or a naming convention specific to the Heirloom donor program — worth a follow-up check with GRIN curators or Holland's group directly before treating the 50 unmatched rows as truly absent from GRIN.