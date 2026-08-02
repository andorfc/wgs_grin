# SNPTrait — final coverage tables and figure

All numbers computed from the corrected (validated) accession membership: 464 GRIN accessions matched to SNPTools (name+PI matching), 24,075 total GRIN accessions with any phenotype record, 10,433 with ≥15 phenotyped traits.

### Table 1 — Total maize accessions in public sequence databases

| metric | n_accessions |
|---|---|
| Total maize accessions in public databases (any name-matched WGS) | 1,282 |
| ...with public WGS >10x depth | 552 |
| ...with public WGS >5x depth | 644 |

### Table 2 — All GRIN accessions, by variant-calling readiness

| metric | n_accessions |
|---|---|
| All GRIN accessions (any phenotype record) | 24,075 |
| ...already genotyped in SNPTools | 464 |
| ...with public WGS >10x - variant-callable now | 322 |
| ...with public WGS >5x (5-10x) - variant-callable now | 55 |
| ...with public data <=5x - impute or top-up | 505 |
| ...no public sequence - must be genotyped | 22,729 |
| ...priority FASTQ (files / TB) | 2,410 files / 16.8 TB |

### Table 3 — GRIN accessions with ≥15 phenotyped traits, by variant-calling readiness

| metric | n_accessions |
|---|---|
| All GRIN accessions (>=15 phenotyped traits) | 10,433 |
| ...already genotyped in SNPTools | 435 |
| ...with public WGS >10x - variant-callable now | 315 |
| ...with public WGS >5x (5-10x) - variant-callable now | 52 |
| ...with public data <=5x - impute or top-up | 488 |
| ...no public sequence - must be genotyped | 9,143 |
| ...priority FASTQ (files / TB) | 2,288 files / 15.7 TB |

### Table 4 — Top public sequencing projects by GRIN accession coverage

| study_accession | already_in_snptools | genotyped_gt5x | needs_sequencing | total | study_title |
|---|---|---|---|---|---|
| PRJNA661271 | 141 | 258 | 0 | 399 | Maize Wisconsin Diversity Panel Resequencing Project |
| PRJNA489924 | 158 | 181 | 49 | 388 | Genome-wide association study for cuticular evaporation rate in maize |
| PRJNA565870 | 117 | 77 | 31 | 225 | Resequencing of 775 maize inbred lines |
| PRJNA482446 | 13 | 8 | 163 | 184 | Maize raw sequence reads |
| PRJNA609577 | 131 | 13 | 7 | 151 | Zea mays subsp. mays Genome sequencing |
| PRJNA948871 | 82 | 52 | 12 | 146 | Zea mays Genome sequencing |
| PRJNA1170466 | 59 | 39 | 4 | 102 | Genome resequencing data of 447 maize inbred lines |
| PRJNA894503 | 1 | 0 | 94 | 95 | Evaluation of genetic diversity across inbreds used by GEM project (WGS skim sequencing) |
| PRJNA889703 | 4 | 2 | 88 | 94 | Eco-evolutionary maize microbiome |
| PRJNA684330 | 18 | 32 | 26 | 76 | Maize diversity to study rare alleles |
| PRJNA1142968 | 13 | 21 | 38 | 72 | Evaluation of genetic diversity across the inbreds used by G2F project - 2024/2025 germplasm (WGS skim sequencing) |
| PRJNA531553 | 41 | 0 | 2 | 43 | Deep DNA resequencing of the association mapping panel |
| PRJNA644582 | 22 | 18 | 1 | 41 | The maize structural variation map uncovered by Nanopore sequencing |
| PRJNA683126 | 4 | 8 | 23 | 35 | Target interval capture sequencing of 352 maize inbred lines |
| PRJNA359093 | 24 | 2 | 0 | 26 | Zea mays |

### 2×2 Matrix A — SNPTools membership × >5x public coverage (all 24,075 GRIN accessions)

| in_snptools | >5x coverage | <=5x / no public data |
|---|---|---|
| In SNPTools | 256 | 208 |
| Not in SNPTools | 377 | 23,234 |

### 2×2 Matrix B — SNPTools membership × >10x public coverage (all 24,075 GRIN accessions)

| in_snptools | >10x coverage | <=10x / no public data |
|---|---|---|
| In SNPTools | 226 | 238 |
| Not in SNPTools | 322 | 23,289 |

**Caveat:** all public-sequence matching is by name, not GRIN accession number — spot-check `matched_field`/`matched_str` columns in the underlying manifests before treating any single row as ground truth (see prior deliverables' README for the validated PI-link vs. name-match-only distinction).