# Inquisitor

## Overview

A super simple gem intended to assist in finding stale gems

## Usage

    inquisitor report .

This will run through all subdirs looking in the current directory
./<project> or ./<project>/current (for capistrano) for Gemfile.lock
files.

When found these will be parsed and gems with new versions will be
looked for. These are then dumped as a JSON string report.


    inquisitor dump_outdated . report.txt

This will do the same as above but output a more readable report to the
filename (report.txt) specified.
