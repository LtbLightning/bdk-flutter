#!/usr/bin/env bash
if [[ $(git status --porcelain) ]]; then
  printf "\e[31;1m%s\e[0m\n" 'This script needs to run against committed code only. Please commit or stash you changes.'
  exit 1
fi
printf "\e[33;1m%s\e[0m\n" 'Running flutter format'
dart format .
printf "\e[33;1m%s\e[0m\n" 'Finished running flutter format'

printf "\e[33;1m%s\e[0m\n" 'Running flutter analyze'
flutter analyze
 if [  $? -ne 0 ] ; then
  exit 1
fi
printf "\e[33;1m%s\e[0m\n" 'Finished running flutter analyze'

printf "\e[33;1m%s\e[0m\n" 'Running flutter test'
flutter test ../test/bdk_flutter_test.dart
if  [ $? -ne 0 ] ; then
   printf "\e[31;1m%s\e[0m\n" 'Mock tests error'
  exit 1
fi
printf "\e[33;1m%s\e[0m\n" 'Finished running flutter test'