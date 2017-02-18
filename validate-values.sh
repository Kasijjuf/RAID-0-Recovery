#!/bin/bash

# Copyright 2017 David Paul <DavidPaul31@gmail.com>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.



# Collect necessary information via script options

while getopts 'n:b:t:s:' OPTION
do
    case $OPTION in
# If someone has strong opinions about what letters the options should
# be, give me your reasoning and I'll consider your suggestion, but
# do it quickly before this script is used more widely
        n) number_of_disks="$OPTARG"
           ;;
        b) smallest_disk_size="$OPTARG"
           ;;
        t) stripe_size="$OPTARG"
           ;;
        s) sector_size="$OPTARG"
           ;;
        \?) echo "Invalid option: -$OPTARG" >&2
           exit 1
           ;;
    esac
done
shift $(( $OPTIND - 1 ))

# Input validation
# Verify disk size is a multiple of sector size
if (( "$smallest_disk_size" % "$sector_size" != 0 ));
then
    echo "Sector size must be smaller than disk size" >&2
    exit 1;
fi
# Verify stripe size is a multiple of the number of disks
if (( "$stripe_size" % "$number_of_disks" != 0 ));
then
    echo "Stripe size is the combined size of one stripe spanning across all disks" >&2
    exit 1;
fi
# Verify stripe size is a multiple of the sector size
if (( "$stripe_size" % "$sector_size" != 0 ));
then
    echo "Stripe size must be a multiple of sector size" >&2
    exit 1;
fi
# Verify sector size is not greater than stripe size / number of disks
if (( "$sector_size" > ("$stripe_size" / "$number_of_disks") ));
then
    echo "Stripe size can't be smaller than sector size times the number of disks" >&2
    exit 1;
fi
# Verify stripe size / number of disks is not greater than the smallest disk size
if (( ("$stripe_size" / "$number_of_disks") > "$smallest_disk_size" ));
then
    echo "Stripe size too big or smallest disk too small" >&2
    exit 1;
fi
echo "Input options are valid."
exit 0