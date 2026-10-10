"""Passing tests so coverage-py, cosmic-ray, testmon, and pymcdc can run."""

from trigger_app.core import add, decide, nested


def test_add() -> None:
    assert add(1, 2) == 3


def test_nested_high() -> None:
    assert nested(4) == 8


def test_nested_zero() -> None:
    assert nested(0) == 0


def test_decide_both() -> None:
    assert decide(True, True) == "both"


def test_decide_none() -> None:
    assert decide(False, False) == "none"

# test
