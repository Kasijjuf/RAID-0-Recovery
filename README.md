# RAID-0-Recovery
A collection of tools to reconstruct the striped volume of a RAID 0 array from mostly complete images of the individual disks.

## What this is not:
* A way to recovery data from a RAID 0 array when one of the component disks is completely unreadable
* An excuse to use RAID 0 without redundancy or backup

## What this is (planned):
* A collection of scripts to reassemble RAID 0 disks into a single disk image
* A way of determining what files are affected as a result of unreadable sectors on the disks in a RAID 0 array
* A complement to existing tools such as [GNU ddrescue](https://www.gnu.org/software/ddrescue/), [ddrescueview](https://sourceforge.net/projects/ddrescueview/), and [ddrutility](https://sourceforge.net/projects/ddrutility/)
* A personal programming challenge
* A free/libre software project (GPLv3+)

## What this consists of (planned):
* A script to generate random stripes from the component disk images for the purpose of verifying the stripe size
* A script to create one whole non-RAID image or disk from all the individual disk images
* A script to take the logfiles generated from individually copying the component disks of a RAID 0 array with ddrescue and generate a logfile of the whole reconsructed volume suitable as an input for the ddru_findbad and ddru_ntfsfindbad commands in ddrutility
