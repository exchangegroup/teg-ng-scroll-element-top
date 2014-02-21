# Overview

Scrolls the page so the element appears on top on small screens.

This is useful for input fields with autocomplete on small screens because it allows you to see more content under the input.

## Install

    bower install git@github.com:bikeexchange/teg-ng-scroll-element-top.git

Include the JS script:

    <script src="/bower_components/teg-ng-scroll-element-top/dist/teg-ng-scroll-element-top.min.js"></script>

Add `TegNgOnEnter` module to your app's dependencies:

    angular.module('YourApp', ['TedNgScrollElementTop'])

## Use

From JavaScript:

    tegNgScrollElementTop.scrollIfNeeded(element);

Or in HTML:

    <input teg-ng-scroll-element-top />


## Development

Setup:

    git clone git@github.com:bikeexchange/teg-ng-scroll-element-top.git
    cd teg-ng-scroll-element-top
    npm install
    bower install

Test:

    grunt test

View demo in browser:

    grunt serve

Build:

    grunt

Finally, bump bower version number:

    git tag v0.1.[patch number]
    git push origin v0.1.[patch number]