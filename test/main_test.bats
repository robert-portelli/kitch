#!/usr/bin/env bash

setup() {
    load 'test_helpers/common-setup'
    _common_setup
}

@test "test case 1a: always passes && bats-core working" {
    run true
    [[ "$status" -eq 0 ]]
}

@test "test case 1b: always passes && bats-core+bats-assert" {
    run true
    assert_success
}

@test "test case 2: always passes in a subshell" {
    (
        run true
        assert_success
    )
}

@test "test case 3: subshell cleanup" {
    export TMPVAR="this"
    (
        export TMPVAR="that"
        assert_equal "$TMPVAR" "that"
    )
    assert_equal "$TMPVAR" "this"
}

@test "test case 4: bats-file" {
    TESTDIR="$(mktemp -d)"
    assert_exists "$TESTDIR"
    rm -dr "$TESTDIR"
    assert_not_exists "$TESTDIR"
}