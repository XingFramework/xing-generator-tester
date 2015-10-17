The Xing Framework
===

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
will create appropriate .ruby-version files in your generated xing project.  If you
also pass the flah
