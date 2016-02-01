The Xing Framework
===

***To learn more about the Xing Framework, read the [Xing Book](https://xingframework.gitbooks.io/the-xing-framework/content/).***

Xing Frontend Utilities
---
[![Code Climate](https://codeclimate.com/github/XingFramework/xing-generator-tester/badges/gpa.svg)](https://codeclimate.com/github/XingFramework/xing-generator-tester)

The Xing Framework is a cutting edge web and mobile development platform by Logical Reality Design, Inc. It is designed to provide a completely modern (and even somewhat future-proofed) API + SPA web development platform with sensible defaults, solid conventions, and ease of rapid development. Xing uses Rails (4.2) on the backend and AngularJS (1.4) on the frontend. Most of the problems inherent in getting these two frameworks to talk to each other cleanly have been pre-solved in Xing.

This repo just contains a short shell script for testing whether the new application
generator (found in [http://github.com/XingFramework/xing-framework](Xing Framework)
successfully generates a working application.

It assumes that the xing generator executable can be found in your path under the
name 'xing'.

Usage
---

The command

```test-xing.sh my_project [options]```

Will attempt to build a new xing project, install gems, and run tests.  The only option is --rvm,
which will attempt to use rvm's gemset functionality to build the project in a clean/empty gemset
named after the project.

Testing against rubies
---

If you set an environment variable RUBY to a version number like '2.2.2', this script
will create appropriate .ruby-version files in your generated xing project.

Authors
-------

* Judson Lester
* Evan Dorn

The Xing Framework strives to be an open and inclusive project. All Contributors to the Xing Framework must abide by our [Code Of Conduct](CODE_OF_CONDUCT.md).
